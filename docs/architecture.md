# Architecture

```mermaid
flowchart LR
    A[Source CSV / API / SQL] --> B[Azure Data Factory]
    B --> C[ADLS Bronze]
    C --> D[Databricks Silver]
    D --> E[Databricks Gold]
    E --> F[Azure SQL DW]
    F --> G[Power BI]
    B --> H[Azure Monitor / Logs]
    D --> I[Quality Checks]
    F --> I
```

## Design principles
- Incremental ingestion
- Separation of storage and compute
- Medallion architecture
- Reusable orchestration
- Production readiness through monitoring and quality controls