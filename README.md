# Enterprise Data Quality & Governance Platform

> **Snowflake · dbt · Apache Airflow · Python · SQL · GitHub Actions**

A full-stack enterprise data platform implementing **metadata-driven data quality engineering**, governance frameworks, and operational observability — built with the modern data stack to demonstrate how organizations achieve trusted, reliable analytics

[![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)](https://python.org)
[![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat-square&logo=postgresql&logoColor=white)]()
[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat-square&logo=snowflake&logoColor=white)](https://snowflake.com)
[![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat-square&logo=dbt&logoColor=white)](https://getdbt.com)
[![Apache Airflow](https://img.shields.io/badge/Apache_Airflow-017CEE?style=flat-square&logo=apacheairflow&logoColor=white)](https://airflow.apache.org)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white)](https://github.com/features/actions)

---

## 🎯 Overview

This project demonstrates a modern enterprise data platform architecture built with Snowflake and dbt, integrating:

- **Data Quality Monitoring** — metadata-driven rule engine with 65+ validation checks
- **Metadata Governance** — dataset ownership, lineage mapping, data dictionary, SLA tracking
- **Data Contracts** — schema enforcement between producers and consumers
- **Data Lineage** — end-to-end traceability from RAW to MART
- **Operational Observability** — real-time schema drift, freshness, and volume anomaly detection
- **CI/CD Automation** — GitHub Actions pipeline validating every push

The platform simulates how organizations build trusted data systems where pipelines are governed, monitored, and validated to ensure reliable analytics.

---

## 📊 Platform Metrics

| Component | Count |
|-----------|-------|
| Snowflake Schemas | 6 (RAW, STAGING, MART, DQ, META, OPS) |
| SQL Scripts | 40+ |
| dbt Models | 25+ |
| Data Quality Rules | 65+ |
| Governance Tables | 6 |
| Monitoring Views | 10+ |

---

## 📐 Architecture

```
Source Systems
      │
      ▼
┌──────────┐
│  RAW     │  ← Source-of-truth ingestion (customers, orders, payments, sellers)
└────┬─────┘
     │
     ▼
┌──────────┐
│ STAGING  │  ← Schema normalization · validation · transformation prep
└────┬─────┘
     │
     ▼
┌──────────┐
│  MART    │  ← dbt models: customer metrics · order aggregates · retention KPIs
└────┬─────┘
     │
     ├─────────────────────┐
     ▼                     ▼
┌──────────┐         ┌──────────┐
│    DQ    │         │   META   │
│ Quality  │         │Governance│  ← data dictionary · ownership · lineage · contracts
│ Engine   │         └──────────┘
└────┬─────┘
     │
     ▼
┌──────────┐
│   OPS    │  ← Observability: pipeline health · SLA breaches · anomaly alerts
└──────────┘

Orchestration: Apache Airflow DAGs  |  CI/CD: GitHub Actions
```

---

## 🔧 Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Snowflake** | Cloud data warehouse (RAW → STAGING → MART) |
| **dbt** | SQL transformations, lineage tracking, modular models, tests |
| **Apache Airflow** | Pipeline orchestration and scheduling |
| **Python** | Validation scripts, quality rule engine, automation |
| **SQL** | Data modeling, quality checks, governance metadata |
| **GitHub Actions** | CI/CD — validates platform on every push |

---

## 🏗️ Platform Execution

Run the full platform end-to-end:

**Step 1 — Create Platform Infrastructure**
```sql
sql_platform/01_platform_setup/001_create_platform.sql
```
Creates schemas: RAW, STAGING, MART, DQ, META, OPS

**Step 2 — Load RAW Data**
```sql
sql_platform/02_raw_layer/004_create_raw_tables.sql
sql_platform/02_raw_layer/005_load_raw_data.sql
```

**Step 3 — Run STAGING Transformations**
```sql
sql_platform/03_staging_layer/006_stg_customers_validation.sql
```

**Step 4 — Execute dbt Models**
```bash
cd edp_dbt
dbt run
dbt test
```

**Step 5 — Run Data Quality Framework**
```sql
sql_platform/04_data_quality/007_data_quality_validation.sql
sql_platform/04_data_quality/036_data_quality_rule_engine.sql
```

**Step 6 — Populate Metadata Governance Layer**
```sql
sql_platform/05_metadata/   -- data dictionary, ownership, lineage, contracts, SLAs
```

**Step 7 — Run Monitoring Layer**
```sql
sql_platform/07_monitoring/  -- schema drift · freshness · volume anomalies · SLA breaches
```

**Or — Run the full platform in one shot:**
```sql
sql_platform/000_run_full_platform.sql
```

---

## 📁 Repository Structure

```
enterprise-data-platform/
│
├── architecture/
│   ├── enterprise_data_platform_architecture.png
│   └── platform_architecture.mmd
│
├── orchestration/
│   └── airflow_data_platform_dag.py       # Airflow DAG — full pipeline
│
├── edp_dbt/                               # dbt project
│   ├── models/                            # 25+ SQL transformation models
│   ├── macros/
│   ├── tests/                             # dbt data tests
│   └── dbt_project.yml
│
├── sql_platform/
│   ├── 000_run_full_platform.sql          # One-shot full execution
│   ├── 01_platform_setup/
│   ├── 02_raw_layer/
│   ├── 03_staging_layer/
│   ├── 04_data_quality/                   # 65+ quality rules
│   ├── 05_metadata/                       # Governance tables
│   └── 07_monitoring/                     # Observability views
│
├── screenshots/                           # Platform layer screenshots
│   ├── 01_raw_layer_tables.png
│   ├── 02_staging_layer_tables.png
│   ├── 03_dbt_models.png
│   ├── 04_dq_tables.png
│   ├── 05_dq_scorecard_results.png
│   ├── 06_metadata_tables.png
│   ├── 07_ops_monitoring_views.png
│   └── 08_platform_layer_summary.png
│
├── docs/
│   └── governance_framework.md
│
└── .github/workflows/
    └── data_platform_ci.yml               # CI/CD pipeline
```

---

## 🔍 Key Features Deep Dive

### Metadata-Driven Data Quality Rule Engine
The DQ schema stores and executes validation rules dynamically:
- **NOT NULL validation** — ensures critical columns are populated
- **Duplicate detection** — identifies and flags duplicate records
- **Business rule enforcement** — custom rules per dataset
- **Quality scorecards** — tracks tests executed, failures, exception counts, run status

### Metadata Governance Layer (META Schema)
| Table | Purpose |
|-------|---------|
| DATA_DICTIONARY | Business definitions for every column |
| DATA_OWNERSHIP | Dataset steward assignments |
| LINEAGE_MAP | Source-to-target dataset lineage |
| DATA_CONTRACTS | Schema validation between teams |
| DATA_PIPELINE_SLA | SLA definitions and breach tracking |
| DATA_QUALITY_RULES | Rule catalog for the DQ engine |

### Operational Observability (OPS Schema)
- Pipeline health monitoring and alerting
- SLA breach detection with notification hooks
- Schema drift detection (column adds, drops, type changes)
- Record volume anomaly flagging
- Reliability metrics dashboards

---

## 🎯 Target Roles Demonstrated

- **Data Quality Engineer** — rule engine, validation framework, quality scorecards
- **Data Governance Engineer** — metadata catalog, lineage, data contracts, stewardship
- **Analytics Engineer** — dbt modeling, medallion architecture, data marts
- **Data Engineer** — Airflow orchestration, Snowflake pipelines, CI/CD
- **Data Platform Engineer** — end-to-end platform architecture, observability

---

## 👤 Author

**Sreyas Lankala** — Data Quality & Governance Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sreyas-lankala/)
[![Email](https://img.shields.io/badge/Email-D14836?style=flat-square&logo=gmail&logoColor=white)](mailto:sreyaslankala@gmail.com)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/sreyas-lankala)

> 🛂 Authorized to work in the USA on F-1 OPT starting May 27, 2026 (STEM OPT eligible — 3-year authorization)
