# Azure Senior Real Project

End-to-end Azure Data Platform project designed to be uploaded to GitHub and used in interviews or portfolio presentations.

## Goal
Build a production-style Azure data platform using:
- Azure Data Factory for ingestion and orchestration
- Azure Data Lake Storage Gen2 for bronze/silver/gold zones
- Azure Databricks for transformations with Delta Lake
- Azure SQL for serving and dimensional modeling
- Power BI for executive dashboards
- Monitoring, quality controls and deployment automation

## Folder structure
- `infrastructure/`: Bicep templates for Azure resources
- `datafactory/`: ADF pipelines, datasets and linked services
- `databricks/`: notebooks for bronze, silver and gold layers
- `sql/`: staging, dimensional model and serving scripts
- `dashboard/`: Power BI-style dashboard assets based on your CSV log
- `docs/`: architecture, roadmap, storytelling and interview notes
- `.github/workflows/`: CI workflow example

## What is ready
- Infrastructure template skeleton in Bicep
- Deployment parameters example
- Azure Data Factory pipeline JSON
- Databricks notebooks in Python
- SQL DDL and transformations
- Power BI-style HTML dashboard and PNG charts
- Storytelling for Eraneos
- GitHub Actions workflow example

## Notes
- A real `.pbix` file is not included because Power BI Desktop project binaries cannot be generated reliably here.
- Instead, this repo includes:
  - `dashboard/powerbi_dashboard_spec.md`
  - `dashboard/azure_dashboard.html`
  - ready-to-use metrics and visuals based on your CSV

## Dataset used for dashboard
Source file: `QueryResult.csv`

## Key metrics from your log
- Period: 2026-04-02 21:28 to 2026-04-04 21:47
- Total events: 1126
- Successful events: 779
- Failed events: 59
- Success rate: 69.2%

## Suggested Git commit sequence
1. `initial project structure`
2. `add bicep infrastructure`
3. `add adf pipeline and datasets`
4. `add databricks bronze silver gold notebooks`
5. `add sql model and serving scripts`
6. `add dashboard assets and storytelling docs`

## Elevator pitch
> I built a production-oriented Azure data platform from infrastructure to analytics. I focused first on deployment stability and validation, then structured the solution to evolve into full ingestion, transformation, data quality and reporting for business users.
