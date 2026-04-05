CREATE OR ALTER VIEW dbo.vw_sales_country_daily AS
SELECT
    d.calendar_date,
    f.country,
    SUM(f.amount) AS total_amount,
    SUM(f.transaction_count) AS transaction_count
FROM dw.fact_sales f
JOIN dw.dim_date d
  ON f.date_id = d.date_id
GROUP BY d.calendar_date, f.country;
GO

CREATE OR ALTER PROCEDURE dbo.usp_load_serving_tables
AS
BEGIN
    SET NOCOUNT ON;

    -- Example placeholder. Replace with MERGE statements from curated Delta exports.
    PRINT 'Load serving tables from curated layer';
END
GO