# Neo4j CSV Generation - Work Plan

**Date**: 2025-11-14  
**Status**: Ready to proceed

---

## Data Inventory - Final 13 Files (All Corrected)

### ✅ Batch 1: Core Profiles (7 files)
All have `associates[]` arrays - converter already handles these
1. batch1_jeffrey_epstein_extraction.json
2. batch1_ghislaine_maxwell_extraction.json  
3. batch1_jean_luc_brunel_extraction.json
4. batch1_leslie_wexner_extraction.json
5. batch1_robert_maxwell_extraction.json
6. batch1_sarah_kellen_extraction.json
7. batch1_virginia_giuffre_extraction.json

### ✅ Batch 2: Victims/Procurers (1 file)
NOW CORRECTED - has `relationships[]` arrays in batch3_part2 format
8. batch2_victims_procurers_extraction.json (26 profiles, 14 relationships)

### ✅ Batch 3: Remaining Profiles (3 files)
9. batch3_remaining_profiles_part1.json (has `associates[]` - works)
10. batch3_remaining_profiles_part2_cronies_legal.json (summary only - SKIP)
11. batch3_remaining_profiles_part3_final.json (NOW CORRECTED - 92 person nodes, 74 relationships)

### ✅ Batch 3 Part 2: FULL Extraction (1 file)
ALREADY CORRECT - reference format with `relationships[]` arrays
12. batch3_part2_FULL_extraction.json (33 profiles, 159 relationships)

### ✅ Supplemental: Missing Victims (1 file)
NOW CORRECTED - has `relationships[]` arrays in batch3_part2 format
13. supplemental_victim_extraction.json (8 profiles, 17 relationships)

---

## Infrastructure Files (4 files - for reference/validation)

1. canonical_entities.json - Entity deduplication mapping (183 entities)
2. relationship_vocabulary.json - Standardized relationship types (28 types)
3. citation_entity_index.json - Entity-to-citation linkage
4. verification_document_extraction.json - 61 verification claims

---

## Relationship Inventory Summary

| File | Relationship Field | Count | Format Status |
|------|-------------------|-------|---------------|
| batch1_* (7 files) | `associates[]` | ~110 | ✅ Converter ready |
| batch2_victims | `relationships[]` | 14 | ✅ batch3_part2 format |
| batch3_part1 | `associates[]` | ~30 | ✅ Converter ready |
| batch3_part2_FULL | `relationships[]` | 159 | ✅ Reference format |
| batch3_part3_final | `relationships[]` | 74 | ✅ batch3_part2 format |
| supplemental_victims | `relationships[]` | 17 | ✅ batch3_part2 format |
| **TOTAL** | | **~404** | **All formats compatible** |

---

## CSV Generation Strategy

### Phase 1: Node CSV Generation

#### 1.1 Person Nodes (persons.csv)
**Source Files**: All 13 extraction files
**Expected Count**: ~270 person nodes

**Extraction Logic**:
```python
# From batch1-3: primary_person, profiles[], missing_profiles[]
# From batch3_part3: journalists[], black_book_circled[], black_book_not_circled[]
# Apply canonical_entities.json mapping for deduplication
```

**CSV Schema**:
```csv
entity_id:ID,:LABEL,name,aliases:string[],birth_year:int,death_year:int,nationality,occupations:string[],summary,sources:string[]
```

**Deduplication Strategy**:
- Use canonical_entities.json to map aliases to primary entity_id
- Merge person_ref_* placeholders with actual profiles if found
- Black book names: Check if already exists as full profile

#### 1.2 Organization Nodes (organizations.csv)
**Source Files**: All 13 files (companies[], organizations[] fields)
**Expected Count**: ~100 organizations

**CSV Schema**:
```csv
entity_id:ID,:LABEL,name,founded:int,location,note,sources:string[]
```

#### 1.3 Equipment Nodes (equipment.csv)
**Source Files**: batch3_part3_final.json (aircraft[] array)
**Expected Count**: 5 aircraft/equipment

**CSV Schema**:
```csv
equipment_id:ID,:LABEL,name,tail_number,note,sources:string[]
```

#### 1.4 Legal Case Nodes (legal_cases.csv)
**Source Files**: All files with legal_cases[] arrays
**Expected Count**: ~30 legal cases

**CSV Schema**:
```csv
case_id:ID,:LABEL,name,year:int,case_number,outcome,sources:string[]
```

#### 1.5 Claim Nodes (claims.csv)
**Source Files**: verification_document_extraction.json
**Expected Count**: 61 claims

**CSV Schema**:
```csv
claim_id:ID,:LABEL,text,verification_status,section,confidence:float,sources:string[]
```

#### 1.6 Citation Nodes (citations.csv)
**Source Files**: verification_document_extraction.json
**Expected Count**: 74 citations

**CSV Schema**:
```csv
citation_id:ID,:LABEL,title,url,accessed_date,source_type,reliability_score:float
```

---

### Phase 2: Relationship CSV Generation

#### 2.1 Relationship Type Breakdown

Based on relationship_vocabulary.json, generate separate CSV per type:

| Relationship Type | Expected Count | Source Files |
|------------------|----------------|--------------|
| ABUSED_BY | ~40 | batch2, supplemental, batch3_part2 |
| REPRESENTED_BY | ~20 | batch2, supplemental, batch3_part2 |
| WORKED_FOR | ~50 | batch2, batch3_part2 |
| WORKED_AT | ~80 | batch1 associates, batch3_part2 |
| IN_BLACK_BOOK | 67 | batch3_part3 black_book_* |
| RECRUITED_BY | ~10 | supplemental |
| TRAVELED_WITH | ~15 | batch1, supplemental |
| PROVIDED_TO | ~5 | supplemental |
| OWNED_BY | 5 | batch3_part3 aircraft |
| MET | ~10 | batch1, supplemental |
| FAMILY | ~50 | batch1, batch3_part2 family[] |
| MANAGED_MONEY_FOR | ~15 | batch1, batch3_part2 |
| **Total** | **~367+** | |

#### 2.2 Relationship CSV Schema (per type)

**Example: ABUSED_BY.csv**
```csv
:START_ID,:END_ID,:TYPE,context,confidence:float,verification_status,citations:string[],year:int
```

**Extraction Logic**:
```python
# From relationships[] arrays:
for rel in profile['relationships']:
    start_id = profile['entity_id']  # Source person
    end_id = rel['entity_id']        # Target person/entity
    rel_type = rel['type']           # e.g., "ABUSED_BY"
    
    # Write to {rel_type}.csv
    
# From associates[] arrays (batch1 files):
for assoc in profile['associates']:
    # Parse relationship type from context
    # Create relationship row
```

#### 2.3 Special Relationship Handling

**Family Relationships** (from family[] arrays):
- Extract as FAMILY relationships with `relationship` property (e.g., "daughter", "son")

**Associates Relationships** (from associates[] arrays):
- Parse context to infer relationship type
- Default to ASSOCIATED_WITH if unclear

**Black Book Relationships**:
- All use IN_BLACK_BOOK type
- Include `circled: true/false` property

---

### Phase 3: Entity Resolution & Placeholder Mapping

#### 3.1 Resolve person_ref_* Placeholders

**Known placeholders**:
- `person_ref_edwards` → Find "Bradley J. Edwards" in batch3_part2
- `person_ref_dershowitz` → Find "Alan Dershowitz" in batch3_part2
- `person_ref_donald_trump` → Find in batch3_part1 or create
- `person_ref_bill_clinton` → Find in batch3_part1 or create
- `person_ref_david_boies` → Find "David Boies" in batch3_part2

**Resolution Strategy**:
1. Search all 13 files for matching name
2. If found, use canonical entity_id from canonical_entities.json
3. If not found, create new person node with placeholder ID
4. Update all relationship references

#### 3.2 Black Book Deduplication

**Examples of overlap**:
- "Jean Luc Brunel" (black_book_circled) → already exists as person_011
- "Ghislaine Maxwell" (black_book_circled) → already exists as person_002
- "Les Wexner" (black_book_circled) → already exists as person_003
- "Cindy Lopez" (black_book_circled) → already exists as person_076

**Strategy**:
- Check canonical_entities.json for name match
- If exists, use canonical entity_id and add IN_BLACK_BOOK relationship
- If new, create person node with black_book entity_id

---

### Phase 4: CSV Validation

#### 4.1 Node Validation Checks
- ✅ All entity_id values are unique within node type
- ✅ No null/empty required fields
- ✅ All :LABEL fields populated
- ✅ Array fields properly semicolon-delimited
- ✅ Integer fields are valid integers
- ✅ Float fields are valid floats (0.0-1.0 for confidence)

#### 4.2 Relationship Validation Checks
- ✅ All :START_ID values exist in source node CSV
- ✅ All :END_ID values exist in target node CSV
- ✅ No self-loops (START_ID ≠ END_ID)
- ✅ All :TYPE values match relationship_vocabulary.json
- ✅ Confidence scores between 0.0-1.0

#### 4.3 Expected Row Counts
- persons.csv: ~270 rows
- organizations.csv: ~100 rows
- equipment.csv: 5 rows
- legal_cases.csv: ~30 rows
- claims.csv: 61 rows
- citations.csv: 74 rows
- **Total relationship rows**: ~367+ across all relationship CSVs

---

## Implementation Approach

### Script Architecture

**File**: `github-ready/scripts/generate_neo4j_csvs.py`

```python
class Neo4jCSVGenerator:
    def __init__(self):
        self.persons = {}
        self.organizations = {}
        self.equipment = {}
        self.legal_cases = {}
        self.relationships = defaultdict(list)
        self.canonical_map = {}  # From canonical_entities.json
        
    def load_canonical_entities(self):
        """Load canonical entity mapping for deduplication"""
        
    def process_batch_file(self, filepath):
        """Process single extraction JSON file"""
        
    def extract_person(self, person_data, source_file):
        """Extract person node with canonical ID resolution"""
        
    def extract_relationships(self, profile, source_file):
        """Extract relationships from relationships[] or associates[] arrays"""
        
    def resolve_placeholders(self):
        """Map person_ref_* to actual entity_ids"""
        
    def generate_node_csvs(self, output_dir):
        """Generate all node CSV files"""
        
    def generate_relationship_csvs(self, output_dir):
        """Generate relationship CSV files grouped by type"""
        
    def validate_csvs(self, output_dir):
        """Run validation checks on generated CSVs"""
        
    def generate_quality_report(self, output_dir):
        """Generate final statistics and quality metrics"""
```

---

## Success Criteria

After CSV generation:

✅ **persons.csv**: ~270 rows (no duplicates)
✅ **Relationship CSVs**: ~367+ total rows across all types
✅ **IN_BLACK_BOOK relationships**: 67 rows (circled property set correctly)
✅ **No orphaned relationships**: All START_ID/END_ID exist in nodes
✅ **Confidence scores**: Average ≥ 0.7
✅ **Validation**: 0 errors, 0 warnings
✅ **Ready for Neo4j bulk import**

---

## Next Steps

1. Create `generate_neo4j_csvs.py` script
2. Run CSV generation
3. Validate outputs
4. Generate quality report
5. Ready for Neo4j import

