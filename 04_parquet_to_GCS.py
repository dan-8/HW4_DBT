import os
from google.cloud import storage

# Set up your GCS credentials
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/home/Dan/robust-episode-412509-59db8343fdef.json"

# Create a GCS client
client = storage.Client()

# Define your new GCS bucket name
new_bucket_name = "dtc_data_lake_ny-rides-dan_us"

# Path to your local Parquet file
local_parquet_file = "combined_parquet.parquet"

# Define the destination path and filename in the new GCS bucket
new_destination_blob_name = "HW4_DBT_US/combined_parquet.parquet"

# Upload the local file to the new GCS bucket
new_bucket = client.bucket(new_bucket_name)
new_blob = new_bucket.blob(new_destination_blob_name)
new_blob.upload_from_filename(local_parquet_file)

print(f"File {local_parquet_file} uploaded to {new_destination_blob_name} in bucket {new_bucket_name}")
