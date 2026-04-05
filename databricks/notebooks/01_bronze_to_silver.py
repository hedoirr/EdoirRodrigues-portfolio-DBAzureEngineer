from pyspark.sql import functions as F
from pyspark.sql.window import Window

load_date = dbutils.widgets.get("load_date") if 'dbutils' in globals() else "2026-04-05"

storage_account = "<storage-account>"
bronze_path = f"abfss://bronze@{storage_account}.dfs.core.windows.net/sales/"
silver_path = f"abfss://silver@{storage_account}.dfs.core.windows.net/sales/"
gold_path = f"abfss://gold@{storage_account}.dfs.core.windows.net/sales/"


# Bronze to Silver
df = spark.read.format("csv").option("header", "true").load(bronze_path)

df_silver = (
    df
    .dropDuplicates()
    .withColumn("amount", F.col("amount").cast("double"))
    .withColumn("sale_date", F.to_date("sale_date"))
    .filter(F.col("amount").isNotNull() & (F.col("amount") > 0))
    .withColumn("ingestion_date", F.lit(load_date))
)

(df_silver.write
    .format("delta")
    .mode("overwrite")
    .save(silver_path))