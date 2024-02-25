import os
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

# Define the folder containing Parquet files
parquet_folder = "parquet_HW4"

# List all Parquet files in the folder
parquet_files = [os.path.join(parquet_folder, file_name) for file_name in os.listdir(parquet_folder) if file_name.endswith(".parquet")]

# Read and concatenate Parquet files
dfs = []
for parquet_file in parquet_files:
    table = pq.read_table(parquet_file)
    dfs.append(table.to_pandas())

# Concatenate all DataFrames into a single DataFrame
combined_df = pd.concat(dfs, ignore_index=True)

# Write the combined DataFrame to a new Parquet file
output_parquet_file = "combined_parquet.parquet"
pq.write_table(pa.Table.from_pandas(combined_df), output_parquet_file)

print(f"Combined Parquet file saved as {output_parquet_file}")
