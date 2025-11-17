# Epstein Network Analysis - Data Repository

**Git LFS data storage for network analysis application**

This repository contains source documents, extracted data, and processed datasets for the [Epstein Files AI application](https://github.com/dleerdefi/epstein-files-ai). All large files (PDFs, PNGs) are tracked with Git LFS.

---

## Repository Purpose

Pure **data storage repository** providing:
- 📁 Source documents (1.1GB PNG images, PDFs)
- 📝 Extracted JSON data (manual + automated extraction)
- 📊 Final processed CSVs for Neo4j import
- 📖 Dataset documentation and metadata

**Application repository**: https://github.com/dleerdefi/epstein-files-ai
*Contains all scripts, Neo4j import, embedding generation, and GraphRAG application*

---

## How to Use This Repository

### As Git Submodule (Recommended)

```bash
# In your application repository
git submodule add https://github.com/dleerdefi/epstein-network-data.git data
cd data
git checkout main

# Update to latest data
git submodule update --remote data
```

### Direct Clone

```bash
# Requires Git LFS
git lfs install
git clone https://github.com/dleerdefi/epstein-network-data.git
cd epstein-network-data
```

**Note**: Git LFS is required to download source images (1.1GB).

---

## What's Included

### 📁 Source Documents (1.1GB)
**Location**: `data/source/`

| Document | Pages | Size | Format | Tracked by LFS |
|----------|-------|------|--------|----------------|
| **Birthday Book** | 128 | ~244MB | PNG | ✅ |
| **Black Book** | 95 | ~79MB | PNG | ✅ |
| **Flight Logs** | 118 | ~797MB | PNG | ✅ |

**Content**:
- Birthday Book: Event photos, guest lists, signatures
- Black Book: Contact directory with addresses, phones, emails
- Flight Logs: Passenger manifests 1991-2019

### 📦 External Data Sources (11MB)
**Location**: `data/external_sources/`

- **Black Book CSV** (`complete.json`): 1,252 contacts with full details
- **Flight Logs PDF** (unredacted): Pages 39-118 from government release
- **Jeffrey Epstein Research Notes**: Verified background on 286 key individuals

### 📝 Extracted Data (8.1MB)
**Location**: `data/extracted/`

| Dataset | Status | Format | Purpose |
|---------|--------|--------|---------|
| **Birthday Book** | 🔄 In Progress | JSON | Manual extraction + AI verification |
| **Black Book** | ⏸️ Halted | JSON | External CSV found (more complete) |
| **Flight Logs** | 🔄 In Progress | JSON | Manual extraction with date inference |
| **Epstein Notes** | ✅ Complete | JSON | Source for Neo4j production dataset |

### 📊 Final Processed Data (7.3MB)
**Location**: `data/final/`

#### Epstein Notes - Neo4j Dataset v1.3

**Location**: `data/final/epstein_notes/`

Production-ready knowledge graph for Neo4j GraphRAG:

**Nodes** (514 total):
- 286 Persons (with occupations, summaries, aliases)
- 97 Organizations (companies, institutions, agencies)
- 5 Equipment (aircraft: N908JE, etc.)
- 53 Claims (verified factual statements with confidence scores)
- 73 Citations (court filings, news articles, Wikipedia)

**Relationships** (534 total, 65 types):
- Provenance: CLAIM_ABOUT (113), SUPPORTED_BY (67)
- Social: IN_BLACK_BOOK (66), FAMILY, ASSOCIATED_WITH
- Legal: ABUSED (21), SUED_BY, REPRESENTED_BY, PROSECUTED_BY
- Professional: WORKED_FOR, CEO_OF, FOUNDED, APPOINTED_BY

**Embeddings** (436 vectors):
- Voyage-3-Large model (1024 dimensions)
- 286 person embeddings
- 97 organization embeddings
- 53 claim embeddings

**Quality Metrics**:
- ✅ 0 orphaned relationships
- ✅ 0 duplicate relationships
- ✅ 3-tier normalization applied (147→65 types, -56% complexity)
- ✅ All person names in Title Case
- ✅ Full provenance layer (claims linked to citations + entities)

**Files**:
- `nodes/` - 5 CSV files (persons.csv, organizations.csv, equipment.csv, claims.csv, citations.csv)
- `relationships/` - 65 CSV files (one per relationship type)
- `embeddings/` - 3 CSV files (person, organization, claim embeddings)
- `README.md` - Dataset overview and use cases
- `IMPORT_INSTRUCTIONS.md` - Neo4j import reference (scripts in app repo)
- `EMBEDDING_INSTRUCTIONS.md` - Embedding generation reference (scripts in app repo)
- `NEO4J_COMPLETE_IMPORT.cypher` - Complete Cypher import script

#### Other Datasets

- **Black Book** (`data/final/black_book/`): Extracted contacts with geocoded data
- **Flight Logs** (`data/final/flight_logs/`): Passenger manifests with normalized dates
- **Flight Logs PDF** (`data/final/flight_logs_pdf/`): Pages 39-118 extracted from PDF
- **Geocoded** (`data/final/geocoded/`): Phone numbers and addresses with lat/lon coordinates
- **Corrections** (`data/final/corrections/`): Data quality fixes and validations

---

## Data Directory Structure

```
data/
├── source/                         # 1.1GB - Original documents (LFS tracked)
│   ├── birthday_book/             # 128 PNG pages
│   ├── black_book/                # 95 PNG pages
│   ├── black_book_cropped/        # 95 PNG pages (border-removed for better OCR)
│   └── flight_logs/               # 118 PNG pages
│
├── external_sources/              # 11MB - Third-party validated data
│   ├── black_book/
│   │   └── processed/complete.json  # 1,252 contacts
│   ├── flight_logs/
│   │   └── EPSTEIN FLIGHT LOGS UNREDACTED.pdf
│   └── Jeffrey Epstein Notes/
│       ├── Jeffrey Epstein Research.md
│       └── A Report on the Verifiable Factual and Legal Record.md
│
├── extracted/                     # 8.1MB - AI extraction outputs (JSON)
│   ├── birthday_book/            # Manual extraction in progress
│   ├── black_book/               # Manual extraction halted (external CSV found)
│   ├── flight_logs/              # Manual extraction in progress
│   └── epstein_notes/            # Complete (source for Neo4j dataset)
│
└── final/                         # 7.3MB - Processed datasets for import
    ├── epstein_notes/            # ⭐ Production Neo4j dataset v1.3
    │   ├── nodes/                # 5 CSV files (514 nodes)
    │   ├── relationships/        # 65 CSV files (534 relationships)
    │   ├── embeddings/           # 3 CSV files (436 embeddings, 1024d)
    │   ├── README.md
    │   ├── IMPORT_INSTRUCTIONS.md
    │   ├── EMBEDDING_INSTRUCTIONS.md
    │   └── NEO4J_COMPLETE_IMPORT.cypher
    ├── black_book/               # Extracted contact data
    ├── flight_logs/              # Passenger manifests (pages 1-31)
    ├── flight_logs_pdf/          # Passenger manifests (pages 39-118 from PDF)
    ├── geocoded/                 # Geocoded phones/addresses
    └── corrections/              # Data quality fixes
```

---

## Dataset Documentation

| Document | Purpose |
|----------|---------|
| **[DATA_STATUS.md](DATA_STATUS.md)** | Extraction progress across all documents (Birthday Book, Black Book, Flight Logs) |
| **[CONTRIBUTING.md](CONTRIBUTING.md)** | How to contribute data improvements, corrections, and validations |
| **[EXAMPLE-CLAUDE.md](EXAMPLE-CLAUDE.md)** | AI extraction guidelines for multimodal document processing |
| **[data/final/epstein_notes/README.md](data/final/epstein_notes/README.md)** | Neo4j dataset overview, schema, and example queries |
| **[data/final/epstein_notes/IMPORT_INSTRUCTIONS.md](data/final/epstein_notes/IMPORT_INSTRUCTIONS.md)** | Neo4j import reference (see app repo for scripts) |
| **[data/final/epstein_notes/EMBEDDING_INSTRUCTIONS.md](data/final/epstein_notes/EMBEDDING_INSTRUCTIONS.md)** | Voyage-3-Large embedding reference (see app repo for scripts) |

**Note**: All import scripts and application code are in the [epstein-files-ai](https://github.com/dleerdefi/epstein-files-ai) repository.

---

## Dataset Versions

### v1.3 (2025-11-16) - Current
- ✅ Epstein Notes Neo4j dataset (514 nodes, 534 relationships)
- ✅ Voyage-3-Large embeddings (436 vectors, 1024 dimensions)
- ✅ Case normalization (all person names in Title Case)
- ✅ Full provenance layer (claims + citations with CLAIM_ABOUT, SUPPORTED_BY relationships)
- ✅ 3-tier relationship normalization (147→65 types)

### v1.2 (2025-11-16)
- ✅ Case normalization applied to all person names and aliases
- ✅ Initials preserved (JE, GM, IS-R, etc.)
- ✅ 19 persons normalized from ALL CAPS to Title Case

### v1.1 (2025-11-16)
- ✅ Claims & citations enhancement (53 claims, 73 citations)
- ✅ 180 provenance relationships added
- ✅ Quality report updated with new metrics

### v1.0 (2025-11-16)
- ✅ Initial release: 3-tier relationship normalization
- ✅ 388 entity nodes (286 persons + 97 organizations + 5 equipment)
- ✅ 354 normalized relationships
- ✅ Complete validation and documentation

---

## Git LFS Configuration

Large files tracked by LFS (see [.gitattributes](.gitattributes)):
- `*.pdf` - All PDF files
- `data/source/**/*.png` - All source document images (~1.1GB)

**Total LFS Size**: ~1.1GB (source images)

### LFS Setup

```bash
# Install Git LFS
brew install git-lfs  # macOS
# or: sudo apt-get install git-lfs  # Linux
# or: Download from https://git-lfs.github.com/  # Windows

# Initialize LFS
git lfs install

# Clone with LFS
git clone https://github.com/dleerdefi/epstein-network-data.git
```

---

## Source Documents

All documents are publicly available government releases and FOIA documents:

- **Black Book**: [DocumentCloud - Jeffrey Epstein's Little Black Book](https://www.documentcloud.org/documents/1508273-jeffrey-epsteins-little-black-book-redacted/) (92 pages redacted version)
- **Flight Logs**: [DocumentCloud - Epstein Flight Logs](https://www.documentcloud.org/documents/6404379-Epstein-Flight-Logs-Lolita-Express/) (118 pages, 1991-2019)
- **Birthday Book**: [DocumentCloud - Jeffrey Epstein 50th Birthday Book](https://www.documentcloud.org/documents/26086390-jeffey-epstein-50th-birthday-book/) (238 pages)
- **House Oversight Committee**: [Epstein Records Release](https://oversight.house.gov/release/oversight-committee-releases-epstein-records-provided-by-the-department-of-justice/)

---

## Data Extraction Progress

| Document | Pages | Manual Extraction Status | Neo4j Integration |
|----------|-------|--------------------------|-------------------|
| **Birthday Book** | 128 | 🔄 In Progress (0/128 pages) | ❌ Not yet integrated |
| **Black Book** | 95 | ✅ Complete (external CSV) | ✅ Partial (66 circled entries) |
| **Flight Logs** | 118 | 🔄 In Progress (31/38 pages needed) | 🔄 Partial (pages 39-118 available) |
| **Epstein Notes** | N/A | ✅ Complete (manual research) | ✅ Production ready (v1.3) |

**Current Focus**:
1. Flight Logs pages 32-38 (7 pages remaining)
2. Birthday Book manual extraction (128 pages)
3. Black Book full integration (1,252 contacts → Neo4j)

See [DATA_STATUS.md](DATA_STATUS.md) for detailed progress tracking.

---

## Contributing

We welcome contributions to improve data quality, add missing information, and suggest new data sources.

**How to Contribute**:
- **Report discrepancies**: Open an issue with `[ERROR]` tag
- **Submit corrections**: Create a pull request with evidence/sources
- **Validate data**: Review extracted data against original source images
- **Suggest new sources**: Propose court cases, emails, or other public documents

See [CONTRIBUTING.md](CONTRIBUTING.md) for complete guidelines.

**Planned Future Sources**:
- Court case documents (depositions, exhibits, filings)
- Recent email release (newly released communications)
- Additional public records (property records, business filings)

---

## License

**MIT License** - See [LICENSE](LICENSE)

This repository processes publicly available court records, FOIA releases, and government documents. All extraction work and processed datasets are released under MIT License.

---

## Repository Information

**Primary Use**: Git submodule for [Epstein Files AI Application](https://github.com/dleerdefi/epstein-files-ai)

**Repository Type**: Data storage (Git LFS)

**Maintained By**: [@dleerdefi](https://github.com/dleerdefi)

**Issues & Support**: [GitHub Issues](https://github.com/dleerdefi/epstein-network-data/issues)

---

**Making public documents queryable through structured data storage**

*Transform 341 pages of handwritten documents and 1,252 contacts into a searchable knowledge graph with provenance tracking and semantic search capabilities.*
