CREATE TABLE `robust-episode-412509.trips_data_all_us.green_tripdata` AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`

INSERT INTO `robust-episode-412509.trips_data_all_us.green_tripdata`
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`

CREATE TABLE `robust-episode-412509.trips_data_all_us.yellow_tripdata` AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`

INSERT INTO `robust-episode-412509.trips_data_all_us.yellow_tripdata`
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`

CREATE TABLE `robust-episode-412509.trips_data_all_us.fhv_2019` AS
SELECT * FROM `robust-episode-412509.trips_data_all_us.fhx_2019`

DROP TABLE `robust-episode-412509.trips_data_all_us.fhx_2019`