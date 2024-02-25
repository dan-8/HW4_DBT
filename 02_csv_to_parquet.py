import os
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

# Define the folder containing CSV files
csv_folder = "HW4"

# Create a folder to store the Parquet files if it doesn't exist
parquet_folder = "parquet_HW4"
if not os.path.exists(parquet_folder):
    os.makedirs(parquet_folder)

# Convert each CSV file to Parquet
for file_name in os.listdir(csv_folder):
    if file_name.endswith(".csv.gz"):
        csv_file = os.path.join(csv_folder, file_name)
        print(f"Converting {file_name} to Parquet...")
        
        # Read CSV file
        df = pd.read_csv(csv_file, compression='gzip')
        
        # Define the name for the Parquet file
        parquet_file = os.path.join(parquet_folder, file_name[:-7] + ".parquet")
        
        # Write DataFrame to Parquet
        table = pa.Table.from_pandas(df)
        pq.write_table(table, parquet_file)
        
        print(f"Converted {file_name} to Parquet file {parquet_file}")
