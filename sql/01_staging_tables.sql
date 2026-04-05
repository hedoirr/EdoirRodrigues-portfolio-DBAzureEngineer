CREATE SCHEMA IF NOT EXISTS stg;
GO

CREATE TABLE stg.sales_raw (
    sale_id            VARCHAR(100),
    sale_date          DATE,
    customer_id        VARCHAR(100),
    product_id         VARCHAR(100),
    country            VARCHAR(100),
    amount             DECIMAL(18,2),
    ingestion_date     DATE
);
GO