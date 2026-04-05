# Deployment Guide

## Prerequisites
- Azure subscription
- Resource group created
- Azure CLI authenticated
- Databricks and Data Factory permissions
- SQL admin password stored securely (Key Vault recommended)

## Example deployment
```bash
az group create --name rg-ed-portfolio-dev --location westeurope

az deployment group create   --resource-group rg-ed-portfolio-dev   --template-file infrastructure/bicep/main.bicep   --parameters @infrastructure/bicep/main.parameters.example.json   --parameters sqlAdminPassword='<your-secret>'
```

## Post-deployment
1. Assign Storage Blob Data Contributor to ADF managed identity.
2. Create Databricks access connector or service principal if required.
3. Publish ADF objects from `datafactory/`.
4. Import Databricks notebooks from `databricks/notebooks/`.
5. Run SQL scripts in order:
   - `sql/01_staging_tables.sql`
   - `sql/02_dimensional_model.sql`
   - `sql/03_serving_views.sql`