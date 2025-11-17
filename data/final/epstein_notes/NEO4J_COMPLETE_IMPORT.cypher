// ============================================================================
// NEO4J RELATIONSHIP IMPORT - COMPLETE SCRIPT
// ============================================================================
// Generated automatically from CSV schemas
// Relationship types: 65
//
// IMPORTANT: Run this after importing nodes and creating indexes
// ============================================================================

// ============================================================================
// PRIORITY RELATIONSHIPS (Claims, Citations, High-Value Connections)
// ============================================================================

// CLAIM_ABOUT (113 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CLAIM_ABOUT.csv' AS row
MATCH (start:Claim {claim_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CLAIM_ABOUT {
  section: row.section,
  confidence: toFloat(row.`confidence:float`)
}]->(end);

// SUPPORTED_BY (67 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SUPPORTED_BY.csv' AS row
MATCH (start:Claim {claim_id: row.`:START_ID`})
MATCH (end:Citation {citation_id: row.`:END_ID`})
CREATE (start)-[r:SUPPORTED_BY]->(end);

// ABUSED (21 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ABUSED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ABUSED {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// IN_BLACK_BOOK (66 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/IN_BLACK_BOOK.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:IN_BLACK_BOOK {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// FAMILY (38 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/FAMILY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:FAMILY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ASSOCIATED_WITH (31 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ASSOCIATED_WITH.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ASSOCIATED_WITH {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// WORKED_FOR (18 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/WORKED_FOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:WORKED_FOR {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// REPRESENTED_BY (21 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/REPRESENTED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:REPRESENTED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// SUED_BY (17 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SUED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:SUED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ============================================================================
// REMAINING RELATIONSHIPS (Alphabetical Order)
// ============================================================================

// ACCUSED_BY (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ACCUSED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ACCUSED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ACQUIRED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ACQUIRED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ACQUIRED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ALLEGED_(DENIED) (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ALLEGED_(DENIED).csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ALLEGED_(DENIED) {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ALLEGED_ABUSER (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ALLEGED_ABUSER.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ALLEGED_ABUSER {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ALLEGED_CO_CONSPIRATOR (4 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/ALLEGED_CO_CONSPIRATOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:ALLEGED_CO_CONSPIRATOR {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// APPOINTED_BY (5 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/APPOINTED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:APPOINTED_BY {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// BUSINESS_RIVAL (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/BUSINESS_RIVAL.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:BUSINESS_RIVAL {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CAMPAIGN_MANAGED_FOR (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CAMPAIGN_MANAGED_FOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CAMPAIGN_MANAGED_FOR {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CEO_OF (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CEO_OF.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CEO_OF {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CHAIRMAN_OF (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CHAIRMAN_OF.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CHAIRMAN_OF {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CLERKED_FOR (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CLERKED_FOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CLERKED_FOR {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CLIENT_OF (6 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CLIENT_OF.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CLIENT_OF {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CORRESPONDED_WITH (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CORRESPONDED_WITH.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CORRESPONDED_WITH {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CO_CHAIRMAN_OF (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CO_CHAIRMAN_OF.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CO_CHAIRMAN_OF {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CO_COUNSEL (5 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CO_COUNSEL.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CO_COUNSEL {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// CO_DEFENDANT_WITH (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/CO_DEFENDANT_WITH.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:CO_DEFENDANT_WITH {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// DIRECTOR_OF (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/DIRECTOR_OF.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:DIRECTOR_OF {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// DONATED_TO (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/DONATED_TO.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:DONATED_TO {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// EVENT_ORGANIZER (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/EVENT_ORGANIZER.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:EVENT_ORGANIZER {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// FBI_INTERVIEWEE (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/FBI_INTERVIEWEE.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:FBI_INTERVIEWEE {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// FINANCED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/FINANCED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:FINANCED {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// FOUNDED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/FOUNDED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:FOUNDED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// GOVERNMENT_AFFILIATED (5 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/GOVERNMENT_AFFILIATED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:GOVERNMENT_AFFILIATED {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// HELPED_DRAFT_NPA_FOR (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/HELPED_DRAFT_NPA_FOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:HELPED_DRAFT_NPA_FOR {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// HIRED (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/HIRED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:HIRED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// HUSBANDS_EMPLOYER (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/HUSBANDS_EMPLOYER.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:HUSBANDS_EMPLOYER {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// INTENDED_DEPOSITION_TARGET (4 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/INTENDED_DEPOSITION_TARGET.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:INTENDED_DEPOSITION_TARGET {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// INTRODUCED (6 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/INTRODUCED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:INTRODUCED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// INVESTIGATED_BY (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/INVESTIGATED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:INVESTIGATED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// LEASED_FROM (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/LEASED_FROM.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:LEASED_FROM {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// MANAGED_MONEY_FOR (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/MANAGED_MONEY_FOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:MANAGED_MONEY_FOR {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// MENTORED_BY (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/MENTORED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:MENTORED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// MODEL_DISCOVERED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/MODEL_DISCOVERED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:MODEL_DISCOVERED {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// MODEL_REPRESENTED (9 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/MODEL_REPRESENTED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:MODEL_REPRESENTED {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// MURDER_VICTIM_(ALLEGED_CONNECTION) (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/MURDER_VICTIM_(ALLEGED_CONNECTION).csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:MURDER_VICTIM_(ALLEGED_CONNECTION) {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// OWNS (8 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/OWNS.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:OWNS {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PAID_BY (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PAID_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PAID_BY {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PARDONED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PARDONED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PARDONED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PARTNERED_WITH (5 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PARTNERED_WITH.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PARTNERED_WITH {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PATRONIZED_BY (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PATRONIZED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PATRONIZED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// POLICY_ADVISOR (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/POLICY_ADVISOR.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:POLICY_ADVISOR {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// POLITICAL_DONATION_RECIPIENT (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/POLITICAL_DONATION_RECIPIENT.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:POLITICAL_DONATION_RECIPIENT {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PRESIDED_OVER_BY (6 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PRESIDED_OVER_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PRESIDED_OVER_BY {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PROMOTED_BY (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PROMOTED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PROMOTED_BY {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// PROSECUTED_BY (6 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/PROSECUTED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:PROSECUTED_BY {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// RECRUITED (4 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/RECRUITED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:RECRUITED {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// REFERENCED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/REFERENCED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:REFERENCED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// REPLACED_BY (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/REPLACED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:REPLACED_BY {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// RUMORED_ACQUISITION_TARGET (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/RUMORED_ACQUISITION_TARGET.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:RUMORED_ACQUISITION_TARGET {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// SOLD_TO (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SOLD_TO.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:SOLD_TO {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// SOURCE_OF_INFORMATION (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SOURCE_OF_INFORMATION.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:SOURCE_OF_INFORMATION {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// SUBJECT_OF_RULING (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SUBJECT_OF_RULING.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:SUBJECT_OF_RULING {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// SUBPOENAED_BY (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SUBPOENAED_BY.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:SUBPOENAED_BY {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// SUPPLIED (2 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/SUPPLIED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:SUPPLIED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// TUTORED (1 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/TUTORED.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:TUTORED {
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// WORKED_WITH (3 relationships)
LOAD CSV WITH HEADERS FROM 'file:///epstein/relationships/WORKED_WITH.csv' AS row
MATCH (start {entity_id: row.`:START_ID`})
MATCH (end {entity_id: row.`:END_ID`})
CREATE (start)-[r:WORKED_WITH {
  circled: CASE WHEN row.`circled:boolean` = 'true' THEN true ELSE false END,
  citations: CASE WHEN row.`citations:string[]` IS NOT NULL AND row.`citations:string[]` <> ''
             THEN split(row.`citations:string[]`, ';')
             ELSE [] END,
  confidence: toFloat(row.`confidence:float`),
  context: row.context,
  verification_status: row.verification_status
}]->(end);

// ============================================================================
// VALIDATION
// ============================================================================

// Verify total relationship count
MATCH ()-[r]-()
RETURN count(r) as total_relationships;
// Expected: 534

// Count by relationship type
MATCH ()-[r]-()
RETURN type(r) as rel_type, count(r) as count
ORDER BY count DESC;
