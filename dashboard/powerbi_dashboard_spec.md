# Power BI Dashboard Specification

## Page 1 - Executive Overview
Cards:
- Total Events
- Success Rate
- Failed Events
- Period

Charts:
- Activity over time
- Status distribution

## Page 2 - Operations Breakdown
Charts:
- Top operations
- Top resource types

## Page 3 - Skills & Maturity
Measures:
- Foundation maturity
- Engineering maturity
- Analytics maturity

## Page 4 - Quality & Reliability
Measures:
- Success rate
- Failure rate
- Failures by day
- Failed operations by type

## Suggested Power BI visuals
- Cards
- Line chart
- Clustered bar chart
- Matrix
- Decomposition tree
- KPI visual

## Recommended DAX measures
```DAX
Total Events = COUNTROWS(AzureLog)

Successful Events = CALCULATE([Total Events], AzureLog[Status] = "Bem-sucedido")

Failed Events = CALCULATE([Total Events], AzureLog[Status] = "Falha")

Success Rate = DIVIDE([Successful Events], [Total Events], 0)
```