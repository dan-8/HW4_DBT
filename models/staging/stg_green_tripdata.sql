{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *,
    row_number() over(partition by vendor_id, pickup_datetime) as rn
  from {{ source('staging','green_tripdata') }}
  where vendor_id is not null 
)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['vendor_id', 'pickup_datetime']) }} as tripid,
    cast(vendor_id as integer) as vendorid,
    CAST(
        REGEXP_REPLACE(CAST(rate_code AS STRING), r'\.0', '') AS INT64
    ) AS ratecodeid,
    cast(pickup_location_id as integer) as pickup_locationid,
    cast(pickup_location_id as integer) as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    store_and_fwd_flag,
    cast(passenger_count as integer) as passenger_count,
    cast(trip_distance as numeric) as trip_distance,
    CAST(
        CASE
            WHEN REGEXP_CONTAINS(CAST(trip_type AS STRING), r'\.\d+') THEN NULL
            ELSE CAST(trip_type AS INT64)
        END AS INT64
    ) AS trip_type,
    
    -- payment info
    cast(fare_amount as numeric) as fare_amount,
    cast(extra as numeric) as extra,
    cast(mta_tax as numeric) as mta_tax,
    cast(tip_amount as numeric) as tip_amount,
    cast(tolls_amount as numeric) as tolls_amount,
    cast(0 as numeric) as ehail_fee,
    cast(imp_surcharge as numeric) as improvement_surcharge,
    cast(total_amount as numeric) as total_amount,
    CAST(REPLACE(payment_type, '.0', '') AS INTEGER) as payment_type,
    {{ get_payment_type_description('payment_type') }} as payment_type_description, 
    cast(0 as numeric) as congestion_surcharge
from tripdata
where rn = 1


-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}