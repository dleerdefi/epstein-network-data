# Contributing to Epstein Network Data

Thank you for your interest in improving this data repository! This document provides guidelines for contributing data corrections, validations, and suggesting new data sources.

**Repository Type**: Data storage only (Git LFS)
**Application Repository**: https://github.com/dleerdefi/epstein-files-ai (for code contributions)

---

## How to Contribute

### 1. Reporting Data Discrepancies

If you find extraction errors, data quality issues, or discrepancies:

#### A. Extraction Errors (Flight Logs, Birthday Book)
1. Open an issue with the title: `[ERROR] Document_Type - Page_Number`
2. Provide:
   - Specific field with error
   - Current incorrect value
   - Correct value with evidence
   - Source/reasoning for correction

Example:
```
Title: [ERROR] Flight_Logs - Page_35
Field: passengers.identified[2]
Current: "John Doe"
Correct: "Jane Doe"
Evidence: Matching signature on page 23, cross-referenced with Black Book entry
```

#### B. Neo4j Data Issues (Epstein Notes)
1. Open an issue with the title: `[NEO4J-ERROR] Node_Type - Entity_Name`
2. Provide:
   - Node type (Person, Organization, Claim, etc.)
   - Entity ID or name
   - Field with error
   - Correct information with source citation

Example:
```
Title: [NEO4J-ERROR] Person - Bill Clinton
Field: occupations
Current: "Politician"
Correct: "Politician, 42nd U.S. President (1993-2001)"
Evidence: Public records, Wikipedia
```

#### C. Cross-Reference Issues
1. Open an issue with the title: `[XREF-ERROR] Missing_Link or Incorrect_Link`
2. Provide:
   - Entities that should be linked (or shouldn't be)
   - Dataset sources (Black Book, Flight Logs, Epstein Notes)
   - Evidence for the connection

Example:
```
Title: [XREF-ERROR] Missing link between Flight Log passenger and Black Book contact
Entity 1: "Jane Doe" (Flight Logs page 15)
Entity 2: "Jane Doe" (Black Book page 45)
Evidence: Name match, same geographic location codes, likely same person
```

### 2. Submitting Corrections via Pull Request

#### Setup
1. Fork the repository
2. Clone your fork locally
3. Create a feature branch: `git checkout -b fix/document-page-field`

#### Making Changes to Extraction Data
1. Locate the JSON file in `data/extracted/[document_type]/`
2. Make your correction
3. Update the `validation` section:
   ```json
   "validation": {
     "manual_review": true,
     "reviewer": "your-github-username",
     "review_date": "2025-11-16",
     "changes": ["corrected passenger name spelling"]
   }
   ```

#### Making Changes to Neo4j CSVs
1. Locate the CSV file in `data/final/epstein_notes/nodes/` or `data/final/epstein_notes/relationships/`
2. Make your correction maintaining CSV format
3. Add a comment in your PR describing the change and source

#### Making Changes to Code/Scripts
**Note**: All scripts and application code are in the [epstein-files-ai](https://github.com/dleerdefi/epstein-files-ai) repository. Code contributions should be made there, not in this data repository.

#### Submission
1. Commit with clear message: `Fix: Correct [field] in [document] page [number]`
2. Push to your fork
3. Create Pull Request with:
   - Clear description of changes
   - Evidence/reasoning for corrections
   - Any relevant issue numbers
   - Screenshots if applicable

### 3. OSINT Research Guidelines

When researching entities mentioned in documents:

#### Acceptable Research
✅ Public records and databases
✅ Published news articles
✅ Academic publications
✅ Corporate registrations
✅ Public social media profiles
✅ Government databases

#### Research Standards
1. **Verification**: Cross-reference minimum 2 sources
2. **Documentation**: Provide links to sources
3. **Objectivity**: Report facts only, no speculation
4. **Privacy**: Respect privacy of non-public figures
5. **Relevance**: Focus on network connections, not personal details

#### Hierarchical Research Approach
When researching individuals:
1. **Tier 1**: Name, professional affiliations, public roles
2. **Tier 2**: Business relationships, organizational memberships
3. **Tier 3**: Public event attendance, documented connections
4. **Out of Scope**: Personal life, family (unless publicly relevant), speculation

### 4. Data Validation Contributions

Help validate existing extractions and Neo4j data:

#### A. Extraction Data Validation (Flight Logs, Birthday Book)
1. Select unvalidated pages (check `validation.manual_review = false`)
2. Compare JSON against source PNG in `data/source/[document_type]/`
3. Document findings:
   - ✅ Confirmed accurate
   - ⚠️ Minor issues (list them)
   - ❌ Major issues (detail required)

**Validation Checklist**:
- [ ] All visible names extracted
- [ ] Phone numbers correctly formatted
- [ ] Dates properly inferred (Flight Logs: MM/DD/YYYY)
- [ ] Signatures identification attempted
- [ ] Cross-references noted

#### B. Neo4j Data Validation (Epstein Notes)
1. Review nodes in `data/final/epstein_notes/nodes/` CSVs
2. Verify against public sources (Wikipedia, news articles, court records)
3. Document findings:
   - ✅ Confirmed accurate
   - ⚠️ Needs clarification (provide source)
   - ❌ Factual error (provide correct info + source)

**Neo4j Validation Checklist**:
- [ ] Person names accurate and properly capitalized
- [ ] Occupations match public records
- [ ] Relationships are factually correct
- [ ] Claims have supporting citations
- [ ] No duplicate entities
- [ ] Citations include valid URLs/references

#### C. Cross-Dataset Validation
1. Compare entities across Black Book, Flight Logs, and Epstein Notes
2. Identify potential matches or conflicts
3. Document suggested links or corrections

**Cross-Reference Checklist**:
- [ ] Same person appears in multiple datasets
- [ ] Geographic consistency (addresses, locations)
- [ ] Temporal consistency (dates align)
- [ ] Relationship consistency (connections make sense)

### 5. Code of Conduct

#### Required Behavior
- **Accuracy First**: Never guess or fabricate data
- **Evidence-Based**: All corrections need supporting evidence
- **Respectful**: Professional discourse only
- **Objective**: No editorializing or personal opinions
- **Collaborative**: Work with other contributors

#### Prohibited Behavior
- ❌ Doxxing or harassment
- ❌ Speculation presented as fact
- ❌ Malicious or false corrections
- ❌ Copyright violations
- ❌ Personal attacks or discrimination

## Quality Standards

### For Data Corrections
- Must improve accuracy demonstrably
- Include evidence or clear reasoning
- Maintain consistent JSON/CSV structure
- Update metadata appropriately
- Cite sources for all factual claims

### For New Extractions (Flight Logs, Birthday Book)
- Follow [EXAMPLE-CLAUDE.md](EXAMPLE-CLAUDE.md) guidelines
- **Flight Logs**: Apply date inference rules (header DATE cell + explicit month changes)
- **Birthday Book**: Attempt all signature identifications, count photo individuals
- Include confidence scores for uncertain data
- Document uncertainty appropriately

### For Neo4j Data Contributions
- Maintain CSV structure exactly
- Use Title Case for person names (except initials: JE, GM, etc.)
- Provide citations for all claims
- Follow existing relationship type naming conventions
- Test changes against Neo4j schema using the [application repository](https://github.com/dleerdefi/epstein-files-ai)

### For OSINT Contributions
- Minimum 2 source verification
- Public information only (no doxxing, no private data)
- Network-relevant data focus
- Clear source attribution with URLs
- Respect privacy of non-public figures

## Review Process

1. **Automated Checks**: JSON/CSV validation, schema compliance, formatting
2. **Peer Review**: Community verification of changes and sources
3. **Maintainer Review**: Final approval, conflict resolution, and merge
4. **Post-Merge**: Changes added to validation tracking, Neo4j import tested
5. **Documentation Update**: Relevant docs updated (DATA_STATUS.md, quality reports)

## Recognition

Contributors are recognized in:
- [CONTRIBUTORS.md](CONTRIBUTORS.md) - All contributors
- Commit history - Individual contributions
- JSON metadata - Reviewer attribution

## Getting Help

- **Questions**: Open an issue with `[QUESTION]` tag
- **Discussion**: Use GitHub Discussions
- **Extraction Guidelines**: Review [EXAMPLE-CLAUDE.md](EXAMPLE-CLAUDE.md)
- **Current Status**: Check [DATA_STATUS.md](DATA_STATUS.md)
- **Neo4j Import**: See `data/final/epstein_notes/IMPORT_INSTRUCTIONS.md` (manual Cypher queries)
- **Embeddings**: See `data/final/epstein_notes/EMBEDDING_INSTRUCTIONS.md` (reference documentation)
- **Application Code**: See [epstein-files-ai](https://github.com/dleerdefi/epstein-files-ai) for import scripts

## Priorities

Current priority areas needing contribution:

### High Priority
1. **Flight Logs pages 32-38** - Complete final 7 pages of manual extraction
2. **Birthday Book** - Manual extraction and review of all 128 pages
3. **Data Validation** - Review existing Neo4j Epstein Notes data for discrepancies
4. **Cross-referencing** - Link entities across Black Book, Flight Logs, and Epstein Notes

### Medium Priority
5. **Black Book Validation** - Verify external CSV data quality against source images
6. **Name Standardization** - Resolve variations and aliases across datasets
7. **Geocoding Support** - Help validate 960 Black Book physical addresses
8. **Flight Log Integration** - Assist with integrating pages 39-118 PDF data into Neo4j

### Ongoing Needs
9. **Additional Source Suggestions** - Propose court cases, emails, or other relevant documents
10. **Community Review** - Verify extracted data against original source images

## Tools and Resources

### Recommended Tools
- JSON validators and formatters
- Image viewers with zoom capability
- Text comparison tools
- Git GUI clients (optional)

### Useful Resources
- **Original Documents**:
  - [Birthday Book Images](data/source/birthday_book/) - 128 PNG pages
  - [Black Book Images](data/source/black_book/) - 95 PNG pages
  - [Flight Logs Images](data/source/flight_logs/) - 118 PNG pages
- **External Sources**:
  - [Black Book CSV](data/external_sources/black_book/processed/complete.json)
  - [Flight Logs PDF](data/external_sources/flight_logs/) - Pages 39-118
- **Neo4j Dataset**:
  - [Epstein Notes CSVs](data/final/epstein_notes/) - Production-ready knowledge graph
- **Documentation**:
  - [Extraction Guidelines](EXAMPLE-CLAUDE.md) - How to extract data
  - [Data Status](DATA_STATUS.md) - Current progress across all datasets
  - [Import Instructions](data/final/epstein_notes/IMPORT_INSTRUCTIONS.md) - Neo4j manual import
- **Application**:
  - [Epstein Files AI](https://github.com/dleerdefi/epstein-files-ai) - Import scripts and GraphRAG app

---

## Suggesting New Data Sources

We welcome suggestions for additional documents to integrate into this project. Currently planned but not yet started:

### Planned Future Sources
1. **Court Case Documents** - Depositions, exhibits, filings
2. **Recent Email Release** - Newly released communications
3. **Additional Public Records** - Property records, business filings, etc.

### How to Suggest New Sources
1. Open an issue with title: `[NEW-SOURCE] Document_Name`
2. Provide:
   - Document name/description
   - Public availability (URL or access method)
   - Relevance to network analysis
   - Estimated page count or data volume
   - Any known quality issues (redactions, legibility, etc.)

### Criteria for New Sources
- ✅ **Publicly available** (no leaked/stolen documents)
- ✅ **Relevant to network analysis** (connections, relationships, events)
- ✅ **Reasonably verifiable** (can cross-reference with other sources)
- ✅ **Processable** (readable text or images, not heavily corrupted)
- ❌ **Not primarily personal/private** (respect privacy of non-public figures)

Example:
```
Title: [NEW-SOURCE] Epstein v. Edwards Court Transcripts
URL: https://courtlistener.com/...
Relevance: Contains depositions mentioning 20+ individuals from Black Book
Pages: 450 pages (PDF)
Quality: Good - searchable text, minimal redactions
```

---

*By contributing, you agree to uphold the quality standards and code of conduct outlined above. Your efforts help build a more accurate and complete knowledge graph for network analysis.*