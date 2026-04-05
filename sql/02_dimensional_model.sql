CREATE SCHEMA IF NOT EXISTS dw;
GO

CREATE TABLE dw.dim_date (
    date_id            INT PRIMARY KEY,
    calendar_date      DATE,
    year_num           INT,
    month_num          INT,
    month_name         VARCHAR(20)
);
GO

CREATE TABLE dw.dim_customer (
    customer_key       INT IDENTITY(1,1) PRIMARY KEY,
    customer_id        VARCHAR(100) UNIQUE
);
GO

CREATE TABLE dw.dim_product (
    product_key        INT IDENTITY(1,1) PRIMARY KEY,
    product_id         VARCHAR(100) UNIQUE
);
GO

CREATE TABLE dw.fact_sales (
    sales_key          BIGINT IDENTITY(1,1) PRIMARY KEY,
    date_id            INT,
    customer_key       INT,
    product_key        INT,
    country            VARCHAR(100),
    amount             DECIMAL(18,2),
    transaction_count  INT,
    CONSTRAINT FK_fact_sales_date FOREIGN KEY (date_id) REFERENCES dw.dim_date(date_id),
    CONSTRAINT FK_fact_sales_customer FOREIGN KEY (customer_key) REFERENCES dw.dim_customer(customer_key),
    CONSTRAINT FK_fact_sales_product FOREIGN KEY (product_key) REFERENCES dw.dim_product(product_key)
);
GO