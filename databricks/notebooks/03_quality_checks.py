from pyspark.sql import functions as F
from pyspark.sql.window import Window

load_date = dbutils.widgets.get("load_date") if 'dbutils' in globals() else "2026-04-05"

storage_account = "<storage-account>"
bronze_path = f"abfss://bronze@{storage_account}.dfs.core.windows.net/sales/"
silver_path = f"abfss://silver@{storage_account}.dfs.core.windows.net/sales/"
gold_path = f"abfss://gold@{storage_account}.dfs.core.windows.net/sales/"


# Data quality checks
df = spark.read.format("delta").load(silver_path)

quality_metrics = {
    "row_count": df.count(),
    "null_amount_rows": df.filter(F.col("amount").isNull()).count(),
    "duplicate_business_keys": df.groupBy("sale_id").count().filter("count > 1").count()
}

print(quality_metrics)