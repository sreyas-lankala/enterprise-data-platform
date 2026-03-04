# dbt Transformation Layer

This directory contains the **dbt project used to build transformation models** for the Enterprise Data Platform.

dbt is used to transform cleaned staging datasets into **analytics-ready models** used for reporting and monitoring.

---

# dbt Project Structure

```
models/
macros/
tests/
snapshots/
seeds/
```

---

# Transformation Layers

The dbt project builds analytical datasets from the **STAGING schema**.

Example transformation flow:

```
RAW → STAGING → dbt models → MART
```

---

# Example Models

Examples of models built in this project include:

- customer metrics
- order aggregates
- retention KPIs
- anomaly detection datasets

---

# Running dbt

To run transformations:

```
dbt run
```

To run tests:

```
dbt test
```

---

# dbt Benefits

Using dbt provides:

- modular SQL transformations
- dependency tracking
- version-controlled data pipelines
- automated testing