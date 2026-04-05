from pyspark.sql import functions as F
from pyspark.sql.window import Window

load_date = dbutils.widgets.get("load_date") if 'dbutils' in globals() else "2026-04-05"

storage_account = "<storage-account>"
bronze_path = f"abfss://bronze@{storage_account}.dfs.core.windows.net/sales/"
silver_path = f"abfss://silver@{storage_account}.dfs.core.windows.net/sales/"
gold_path = f"abfss://gold@{storage_account}.dfs.core.windows.net/sales/"


# Silver to Gold
df = spark.read.format("delta").load(silver_path)

df_gold = (
    df
    .groupBy("country", "sale_date")
    .agg(
        F.sum("amount").alias("total_amount"),
        F.count("*").alias("transaction_count")
    )
)

(df_gold.write
    .format("delta")
    .mode("overwrite")
    .save(gold_path))