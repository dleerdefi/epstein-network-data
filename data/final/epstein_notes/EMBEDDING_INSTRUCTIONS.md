# Voyage-3-Large Embedding Instructions for Neo4j GraphRAG

**Date**: 2025-11-16
**Status**: ✅ PRODUCTION READY

---

## Overview

This guide covers generating and importing **1024-dimensional Voyage-3-Large embeddings** for semantic search in Neo4j GraphRAG.

### What Gets Embedded

- **286 Person nodes**: Name + aliases + occupations + summary
- **97 Organization nodes**: Name + location + note
- **53 Claim nodes**: Text + analysis + section + verification status

### Why Voyage-3-Large?

- **State-of-the-art** general-purpose embedding model (Jan 2025)
- **1024 dimensions**: Optimal balance of quality vs storage (8x smaller than 2048d)
- **32K context length**: Handles long summaries
- **Multilingual**: Supports international names/organizations
- **Matryoshka learning**: Efficient dimension scaling

---

## Prerequisites

### 1. Install Dependencies

```bash
cd github-ready
pip install -r requirements.txt
```

This installs:
- `neo4j>=5.0.0` - Neo4j Python driver
- `voyageai>=0.2.0` - Voyage AI embedding client
- `python-dotenv>=1.0.0` - Environment variable management
- `rich>=13.0.0` - Terminal output formatting
- `tqdm` - Progress bars

### 2. Configure Environment Variables

```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your credentials
nano .env
```

Required variables:
```bash
# Neo4j Connection
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your_password_here

# Voyage AI API Key (get from: https://dash.voyageai.com/)
VOYAGE_API_KEY=your_voyage_api_key_here

# Embedding Configuration (optional, defaults shown)
VOYAGE_MODEL=voyage-3-large
EMBEDDING_DIMENSIONS=1024
EMBEDDING_BATCH_SIZE=128
```

### 3. Verify Neo4j is Running

```bash
# Check Neo4j is accessible
curl http://localhost:7474

# Or if using Neo4j Desktop, verify database is started
```

---

## Step-by-Step Workflow

### Step 1: Import Data to Neo4j (If Not Done)

```bash
# Run automated import
python3 scripts/import_to_neo4j.py

# Expected output: 514 nodes, 534 relationships imported
```

See [IMPORT_INSTRUCTIONS.md](IMPORT_INSTRUCTIONS.md) for details.

---

### Step 2: Create Vector Indexes

Create vector indexes **before** generating embeddings for optimal performance.

```bash
python3 scripts/create_vector_indexes.py
```

**What this does:**
- Creates `person_embedding_idx` (1024d, cosine similarity)
- Creates `organization_embedding_idx` (1024d, cosine similarity)
- Creates `claim_embedding_idx` (1024d, cosine similarity)
- Verifies indexes are created successfully

**Expected output:**
```
✅ Connected to Neo4j at bolt://localhost:7687
📇 Creating vector index: person_embedding_idx
   Label: Person
   Property: embedding
   Dimensions: 1024
   Similarity: cosine
✅ Index person_embedding_idx created successfully
...
📊 Found 3 vector indexes
```

---

### Step 3: Generate Embeddings with Voyage AI

Generate embeddings for all nodes using Voyage-3-Large.

```bash
python3 scripts/generate_embeddings_voyage.py
```

**What this does:**
- Loads all person, organization, and claim nodes from CSV
- Constructs comprehensive text for embedding:
  - **Persons**: "Name: {name}. Also known as: {aliases}. Occupations: {occupations}. Background: {summary}"
  - **Organizations**: "Organization: {name}. Location: {location}. Details: {note}"
  - **Claims**: "Claim: {text}. Analysis: {analysis}. Context: {section}. Status: {verification}"
- Generates 1024d embeddings in batches of 128
- Implements rate limiting (300 requests/minute)
- Saves to CSV format for Neo4j import

**Output files** (saved to `data/final/epstein_notes/embeddings/`):
- `person_embeddings.csv` - 286 person embeddings
- `organization_embeddings.csv` - 97 organization embeddings
- `claim_embeddings.csv` - 53 claim embeddings

**Expected output:**
```
✅ Initialized Voyage AI client
   Model: voyage-3-large
   Dimensions: 1024
   Batch size: 128

📊 Generating embeddings for 286 texts...
   Estimated batches: 3
Batches: 100%|████████| 3/3 [00:15<00:00, 5.2s/it]
✅ Saved 286 person embeddings

Total embeddings generated: 436
```

**Cost estimate** (as of Jan 2025):
- ~436 texts × average 100 tokens = ~43,600 tokens
- Voyage-3-Large pricing: ~$0.10 per 1M tokens
- **Total cost: ~$0.004 (less than 1 cent)**

---

### Step 4: Import Embeddings to Neo4j

Update Neo4j nodes with generated embeddings.

```bash
python3 scripts/import_embeddings_to_neo4j.py
```

**What this does:**
- Loads embedding CSVs
- Uses batched UNWIND + MATCH pattern for efficient updates
- Updates Person, Organization, and Claim nodes with `embedding` property
- Verifies all nodes received embeddings
- Runs test vector similarity query

**Expected output:**
```
📥 Importing 286 embeddings for Person nodes...
   Batch size: 500
Person batches: 100%|████████| 1/1 [00:02<00:00, 2.1s/it]
✅ Updated 286/286 Person nodes

VERIFICATION REPORT
✅ Person
   Nodes with embeddings: 286/286
   Embedding dimensions: 1024

🔍 Most similar persons to Jeffrey Epstein:
   1. Jeffrey Edward Epstein (similarity: 1.0000)
   2. Ghislaine Maxwell (similarity: 0.8234)
   3. Leslie Wexner (similarity: 0.7891)
   ...
```

---

### Step 5: Test Vector Retrieval

Run example semantic searches to verify embeddings work correctly.

```bash
python3 scripts/vector_retrieval_examples.py
```

**Example queries:**
1. "wealthy businessmen involved in finance"
2. "attorneys and lawyers"
3. "financial institutions and investment firms"
4. "legal settlements and court cases"
5. "British royalty and socialites" (with network expansion)
6. "models and entertainment industry" (black book search)

**Sample output:**
```
🔍 Searching persons: 'attorneys and lawyers'

Top 5 Similar Persons
┌──────────────────────┬────────────┬────────────────────┬────────────────────┐
│ Name                 │ Similarity │ Occupations        │ Summary            │
├──────────────────────┼────────────┼────────────────────┼────────────────────┤
│ Alan Dershowitz      │ 0.8421     │ attorney, law prof │ Harvard Law...     │
│ Brad Edwards         │ 0.8234     │ attorney           │ Represented vict...│
│ Jack Scarola         │ 0.7912     │ attorney           │ Partner at Searcy..│
└──────────────────────┴────────────┴────────────────────┴────────────────────┘
```

---

## Advanced Usage

### Custom Semantic Search Queries

Use Neo4j Browser or cypher-shell to run custom vector searches:

```cypher
// Find persons similar to a description
MATCH (p:Person)
WHERE p.embedding IS NOT NULL
WITH p, vector.similarity.cosine(p.embedding, $queryVector) as score
WHERE score >= 0.6
RETURN p.name, p.occupations, score
ORDER BY score DESC
LIMIT 10;
```

**Note**: You need to generate `$queryVector` using Voyage AI's query embedding:

```python
import voyageai
client = voyageai.Client(api_key="your_key")
result = client.embed(
    texts=["your search query"],
    model="voyage-3-large",
    input_type="query",  # Important: use "query" for search
    output_dimension=1024
)
query_vector = result.embeddings[0]
```

### Hybrid Search (Vector + Graph Traversal)

Combine semantic similarity with graph relationships:

```cypher
// Find similar persons and their connections
MATCH (p:Person)
WHERE p.embedding IS NOT NULL
WITH p, vector.similarity.cosine(p.embedding, $queryVector) as score
WHERE score >= 0.7
ORDER BY score DESC
LIMIT 5

// Expand to 1-hop relationships
OPTIONAL MATCH (p)-[r]-(connected)
RETURN p.name, score,
       collect(DISTINCT {type: type(r), name: connected.name})[0..10] as connections
ORDER BY score DESC;
```

### Filter by Verification Status

Search only factual claims:

```cypher
MATCH (c:Claim)
WHERE c.embedding IS NOT NULL
  AND c.verification_status = 'Factual'
WITH c, vector.similarity.cosine(c.embedding, $queryVector) as score
WHERE score >= 0.5
RETURN c.text, c.confidence, score
ORDER BY score DESC, c.confidence DESC
LIMIT 10;
```

---

## Troubleshooting

### Issue: "VOYAGE_API_KEY not set"

**Solution:**
```bash
# Create .env file if missing
cp .env.example .env

# Add your API key
echo "VOYAGE_API_KEY=your_key_here" >> .env
```

### Issue: "No module named 'voyageai'"

**Solution:**
```bash
pip install voyageai
```

### Issue: Vector index creation fails

**Error**: `There is no procedure with the name 'db.index.vector.createNodeIndex'`

**Solution**: You're using Neo4j < 5.11. Upgrade to Neo4j 5.13+ for vector index support.

```bash
# Check Neo4j version
cypher-shell "RETURN 'Neo4j ' + split(neo4j.version(), '.')[0..1]"

# Upgrade Neo4j Desktop or Docker image to 5.13+
```

### Issue: Rate limiting errors from Voyage AI

**Error**: `429 Too Many Requests`

**Solution**: The script already implements rate limiting (300 req/min). If you still hit limits:

```bash
# Edit .env to reduce request rate
VOYAGE_REQUESTS_PER_MINUTE=150
```

### Issue: Embeddings not showing in verification

**Check nodes exist:**
```cypher
MATCH (p:Person) RETURN count(p);
// Expected: 286
```

**Check embeddings imported:**
```cypher
MATCH (p:Person) WHERE p.embedding IS NOT NULL RETURN count(p);
// Expected: 286
```

**If count is 0**, re-run import:
```bash
python3 scripts/import_embeddings_to_neo4j.py
```

---

## Performance Optimization

### Batch Size Tuning

Adjust batch size based on available memory:

```python
# Edit generate_embeddings_voyage.py
self.batch_size = 256  # Increase for faster generation (within 1000 limit)
```

### Index Warm-up

After importing embeddings, warm up indexes for faster queries:

```cypher
// Warm up person embeddings index
MATCH (p:Person)
WHERE p.embedding IS NOT NULL
WITH p LIMIT 100
WITH p, vector.similarity.cosine(p.embedding, p.embedding) as score
RETURN count(*);
```

### Query Performance

Use `LIMIT` and minimum score thresholds:

```cypher
// Fast: Limits candidates early
WITH p, vector.similarity.cosine(p.embedding, $queryVector) as score
WHERE score >= 0.6  // Filter early
RETURN p.name, score
ORDER BY score DESC
LIMIT 10;  // Limit results
```

---

## Cost Considerations

### Voyage AI Pricing (Jan 2025)

- **voyage-3-large**: ~$0.10 per 1M tokens
- **Average person embedding**: ~100 tokens
- **Total for 436 embeddings**: ~$0.004

### Storage in Neo4j

- **1024 dimensions × 4 bytes/float** = 4KB per embedding
- **436 embeddings × 4KB** = ~1.7MB total storage
- Negligible compared to typical Neo4j databases

### Re-generation

Embeddings are **deterministic** for the same input text. Only re-generate if:
- Node content changes (new persons, updated summaries)
- Upgrading to newer Voyage model
- Changing embedding dimensions

---

## Next Steps

### 1. Integrate with Black Book & Flight Logs

Once you have black_book and flight_logs data in Neo4j:

```cypher
// Find persons in black book similar to a description
MATCH (p:Person)-[:IN_BLACK_BOOK]->(contact)
WHERE p.embedding IS NOT NULL
WITH p, vector.similarity.cosine(p.embedding, $queryVector) as score
WHERE score >= 0.6
RETURN p.name, score, collect(contact.name)[0..5] as contacts
ORDER BY score DESC;
```

### 2. Build GraphRAG Application

Use embeddings for RAG (Retrieval-Augmented Generation):

1. **User query** → Generate query embedding
2. **Vector search** → Find top-k similar nodes
3. **Graph expansion** → Fetch relationships
4. **Context assembly** → Build prompt context
5. **LLM generation** → Generate response with citations

### 3. Multi-modal Search

Combine person, organization, and claim searches:

```python
# Search all node types
person_results = retriever.search_persons(query, top_k=3)
org_results = retriever.search_organizations(query, top_k=3)
claim_results = retriever.search_claims(query, top_k=3)

# Merge and rank by score
all_results = sorted(
    person_results + org_results + claim_results,
    key=lambda x: x['score'],
    reverse=True
)
```

---

## Success Criteria

✅ Vector indexes created for 3 node types
✅ 436 embeddings generated (286 persons + 97 orgs + 53 claims)
✅ All embeddings are 1024 dimensions
✅ All nodes updated with `embedding` property
✅ Vector similarity queries return relevant results
✅ Test queries complete successfully
✅ Cosine similarity scores range from 0.0 to 1.0
✅ Similar entities score > 0.6
✅ Hybrid queries combine vector + graph traversal

---

## Reference

### Voyage AI Documentation
- **API Docs**: https://docs.voyageai.com/docs/embeddings
- **Model Details**: https://blog.voyageai.com/2025/01/07/voyage-3-large/
- **Dashboard**: https://dash.voyageai.com/

### Neo4j Vector Documentation
- **Vector Indexes**: https://neo4j.com/docs/cypher-manual/current/indexes/semantic-indexes/vector-indexes/
- **GraphRAG**: https://neo4j.com/docs/neo4j-graphrag-python/current/
- **Similarity Functions**: https://neo4j.com/docs/cypher-manual/current/functions/vector/

### Created Scripts
- `scripts/create_vector_indexes.py` - Create Neo4j vector indexes
- `scripts/generate_embeddings_voyage.py` - Generate Voyage-3-Large embeddings
- `scripts/import_embeddings_to_neo4j.py` - Import embeddings to Neo4j
- `scripts/vector_retrieval_examples.py` - Example semantic searches

---

**Generated**: 2025-11-16
**Model**: Voyage-3-Large (1024d)
**Total Embeddings**: 436
**Total Cost**: <$0.01
