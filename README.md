# Enterprise Data Quality & Governance Platform

![Enterprise Data Platform Architecture](architecture/enterprise_data_platform_architecture.png)

Snowflake • dbt • Data Quality • Metadata Governance • Data Reliability • Data Observability

---

# Overview

This project demonstrates a **modern enterprise data platform architecture** built using **Snowflake and dbt** with integrated:

• Data Quality Monitoring  
• Metadata Governance  
• Data Contracts  
• Data Lineage  
• Data Reliability Monitoring  
• Operational Observability  

The platform simulates how organizations build **trusted data systems** where data pipelines are governed, monitored, and validated to ensure reliable analytics.

The design follows a **layered architecture pattern used in modern enterprise data platforms**.

---

# Platform Architecture

The platform follows a **layered enterprise data architecture**.

```
Source Systems
      ↓
RAW Layer
      ↓
STAGING Layer
      ↓
MART Layer
```

Supporting platform capabilities:

```
Data Quality Framework
Metadata Governance
Data Contracts
Reliability Monitoring
Operational Observability
```

This layered design enables:

• trusted analytical datasets  
• traceable data lineage  
• enforceable governance rules  
• automated data quality monitoring  

---

# 🚀 Platform Demo (End-to-End Execution)

The entire platform can be executed using the SQL scripts in the repository.

This simulates how enterprise data teams orchestrate:

• data ingestion  
• transformation pipelines  
• validation frameworks  
• governance metadata  
• operational monitoring

---

## Step 1 — Create Platform Infrastructure

Run:

```sql
sql_platform/01_platform_setup/001_create_platform.sql
```

This script creates the **Snowflake platform environment**.

Schemas created:

- RAW
- STAGING
- MART
- DQ
- META
- OPS

---

## Step 2 — Create RAW Data Layer

Execute:

```sql
sql_platform/02_raw_layer/004_create_raw_tables.sql
sql_platform/02_raw_layer/005_load_raw_data.sql
```

This loads source datasets into the **RAW schema**.

Example datasets:

- customers
- orders
- order_items
- payments
- sellers

The RAW layer preserves **source-of-truth data** without transformation.

---

## Step 3 — Run STAGING Transformations

Execute:

```sql
sql_platform/03_staging_layer/006_stg_customers_validation.sql
```

The staging layer performs:

• schema normalization  
• column standardization  
• basic validation rules  
• transformation preparation

---

## Step 4 — Execute dbt Transformation Models

Run dbt models:

```bash
cd edp_dbt
dbt run
```

This generates analytics-ready datasets in the **MART schema**.

dbt provides:

• modular SQL transformations  
• dependency management  
• pipeline reproducibility  
• model lineage tracking

---

## Step 5 — Run Data Quality Framework

Execute:

```sql
sql_platform/04_data_quality/007_data_quality_validation.sql
sql_platform/04_data_quality/036_data_quality_rule_engine.sql
sql_platform/04_data_quality/043_metadata_driven_dq_rule_engine.sql
```

The framework executes automated validation rules and logs failures.

---

## Step 6 — Populate Metadata Governance Layer

Execute scripts in:

```
sql_platform/05_metadata/
```

This builds governance metadata including:

• data dictionary  
• data ownership  
• lineage mapping  
• data contracts  
• pipeline SLA tracking

---

## Step 7 — Run Monitoring Layer

Execute monitoring views in:

```
sql_platform/07_monitoring/
```

This generates operational monitoring dashboards.

---

## Optional — Run Full Platform Execution

Run:

```sql
sql_platform/000_run_full_platform.sql
```

Execution flow:

```
RAW → STAGING → dbt → Data Quality → Metadata Governance → Monitoring
```

---

# Platform Schemas

The platform is organized into logical schemas representing each responsibility.

| Schema | Purpose |
|------|------|
| RAW | Raw ingestion layer |
| STAGING | Data standardization |
| MART | Analytics-ready datasets |
| DQ | Data quality monitoring |
| META | Metadata governance |
| OPS | Platform observability |

---

# Snowflake Platform Schemas

![Snowflake Schemas](screenshots/09_snowflake_schemas.png)

---

# Data Ingestion Layer

Source datasets are loaded into the **RAW schema**.

![RAW Layer](screenshots/01_raw_layer_tables.png)

Example tables:

- customers
- orders
- order_items
- payments

The RAW layer maintains **unaltered source data**.

---

# Transformation Layer

The **STAGING schema** prepares datasets for analytical modeling.

![STAGING Layer](screenshots/02_staging_layer_tables.png)

Key responsibilities:

• schema normalization  
• field standardization  
• transformation preparation  

---

# Analytical Models (dbt)

dbt models generate analytics-ready datasets in the **MART schema**.

![dbt Models](screenshots/03_dbt_models.png)

Example models:

- customer lifetime metrics
- order aggregates
- retention KPIs
- anomaly detection datasets

---

# Data Quality Framework

A dedicated **DQ schema** manages validation and monitoring.

![DQ Tables](screenshots/04_dq_tables.png)

Framework components:

• rule execution engine  
• exception tracking  
• anomaly logging  
• validation results storage

---

# Metadata-Driven Data Quality Rules

The platform implements a **metadata-driven data quality rule engine**.

Rules are stored in governance tables and dynamically executed.

Example rules include:

• NOT NULL validation  
• duplicate detection  
• business rule enforcement

![Metadata Rules](screenshots/10_metadata_dq_rules.png)

---

# Data Quality Scorecards

The platform generates **automated reliability scorecards**.

![DQ Scorecard](screenshots/05_dq_scorecard_results.png)

Metrics tracked:

• tests executed  
• failed tests  
• row-level failures  
• exception counts  
• pipeline run status  

---

# Metadata Governance Layer

The **META schema** stores governance metadata.

![Metadata Tables](screenshots/06_metadata_tables.png)

Governance tables include:

| Table | Purpose |
|------|------|
| DATA_DICTIONARY | Business definitions |
| DATA_OWNERSHIP | Data ownership tracking |
| LINEAGE_MAP | Dataset lineage |
| DATA_CONTRACTS | Schema validation |
| DATA_PIPELINE_SLA | SLA monitoring |
| DATA_QUALITY_RULES | Validation rules |

---

# Platform Monitoring

Operational monitoring is implemented using the **OPS schema**.

![Monitoring Views](screenshots/07_ops_monitoring_views.png)

Monitoring capabilities include:

• pipeline health monitoring  
• SLA breach detection  
• anomaly alerts  
• reliability metrics

---

# Platform Object Distribution

The following query summarizes platform objects across layers.

![Platform Summary](screenshots/08_platform_layer_summary.png)

This illustrates the separation of ingestion, transformation, governance, and monitoring responsibilities.

---

# Data Lineage Example

Example lineage flow:

```
RAW_CUSTOMERS
      ↓
STAGING_CUSTOMERS
      ↓
MART_CUSTOMER_METRICS
      ↓
DQ_SCORECARD
      ↓
OPS_MONITORING_VIEWS
```

Lineage tracking enables:

• traceability  
• root cause analysis  
• governance enforcement

---

# Enterprise Data Platform Principles

This project demonstrates key architectural principles.

### Separation of Concerns

Each platform responsibility is isolated.

| Layer | Responsibility |
|------|------|
| RAW | ingestion |
| STAGING | transformation |
| MART | analytics |
| DQ | validation |
| META | governance |
| OPS | monitoring |

---

### Metadata Driven Governance

Governance rules are stored as metadata.

Examples:

```
META.DATA_DICTIONARY
META.DATA_OWNERSHIP
META.LINEAGE_MAP
META.DATA_CONTRACTS
META.DATA_PIPELINE_SLA
META.DATA_QUALITY_RULES
```

---

### Data Quality as a Platform Capability

Data validation is implemented as a **platform service**, not ad-hoc queries.

Capabilities include:

• automated rule execution  
• exception tracking  
• reliability scorecards  
• anomaly detection

---

# Platform Metrics

Current platform scale:

| Component | Count |
|------|------|
| Snowflake Schemas | 6 |
| SQL Scripts | 40+ |
| dbt Models | 25+ |
| Governance Tables | 6 |
| Monitoring Views | 10+ |
| Data Quality Rules | multiple |

---

# Technology Stack

| Technology | Purpose |
|------|------|
| Snowflake | Data warehouse |
| dbt | Transformations |
| SQL | Data modeling |
| GitHub | Version control |
| Data Quality Framework | Validation & monitoring |

---

# Repository Structure

```
enterprise-data-platform
│
├── architecture
│   ├── enterprise_data_platform_architecture.png
│   └── platform_architecture.mmd
│
├── docs
│   └── governance_framework.md
│
├── edp_dbt
│   ├── models
│   ├── macros
│   ├── tests
│   └── dbt_project.yml
│
├── sql_platform
│   └── 000_run_full_platform.sql
│
├── screenshots
│   ├── 01_raw_layer_tables.png
│   ├── 02_staging_layer_tables.png
│   ├── 03_dbt_models.png
│   ├── 04_dq_tables.png
│   ├── 05_dq_scorecard_results.png
│   ├── 06_metadata_tables.png
│   ├── 07_ops_monitoring_views.png
│   └── 08_platform_layer_summary.png
│
└── README.md
```

---

# Target Roles

This project demonstrates skills relevant to:

• Data Quality Engineer  
• Data Governance Engineer  
• Data Steward  
• Metadata Engineer  
• Analytics Engineer  
• Data Platform Engineer  
• Data Reliability Engineer  

---

# Future Enhancements

Possible improvements include:

• integration with enterprise data catalogs (Collibra / Alation)  
• automated lineage visualization  
• CI/CD pipeline validation  
• real-time observability dashboards  
• automated SLA alerting  

---

# Author

Sreyas Lankala  

Data Quality • Governance • Metadata • Data Reliability  

LinkedIn  
https://www.linkedin.com/in/sreyas-lankala/

GitHub  
https://github.com/sreyas-lankala