-------------------------------- preperation --------------------------------

-- create external table
CREATE OR REPLACE EXTERNAL TABLE `playground-martin.homework_3.external_yellow_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://playground-martin-bucket-homework-3/yellow_tripdata_2024-*.parquet']
);


-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE playground-martin.homework_3.yellow_tripdata_non_partitoned AS
SELECT * FROM playground-martin.homework_3.external_yellow_tripdata;




-------------------------------- homework --------------------------------

-- number of records
SELECT COUNT(1)
FROM `playground-martin.homework_3.yellow_tripdata_non_partitoned`;

-- number of distinct PULocationIDs on external table
SELECT COUNT(DISTINCT PULocationID)
FROM `playground-martin.homework_3.external_yellow_tripdata`;

-- number of distinct PULocationIDs on non partitioned table
SELECT COUNT(DISTINCT PULocationID)
FROM `playground-martin.homework_3.yellow_tripdata_non_partitoned`;


-- selecting one or different columns
SELECT PULocationID
FROM `playground-martin.homework_3.yellow_tripdata_non_partitoned`;

SELECT PULocationID, DOLocationID
FROM `playground-martin.homework_3.yellow_tripdata_non_partitoned`;



-- number of records with fare_amount = 0
SELECT COUNT(1)
FROM `playground-martin.homework_3.yellow_tripdata_non_partitoned`
WHERE fare_amount = 0;


-- create a new clustered and partitioned table 
CREATE OR REPLACE TABLE playground-martin.homework_3.yellow_tripdata_partitoned_clustered
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM playground-martin.homework_3.yellow_tripdata_non_partitoned ;


-- retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)
SELECT DISTINCT VendorID 
FROM `playground-martin.homework_3.yellow_tripdata_non_partitoned` 
WHERE tpep_dropoff_datetime BETWEEN TIMESTAMP('2024-03-01') AND TIMESTAMP('2024-03-15');

SELECT DISTINCT VendorID
FROM playground-martin.homework_3.yellow_tripdata_partitoned_clustered
WHERE tpep_dropoff_datetime BETWEEN TIMESTAMP('2024-03-01') AND TIMESTAMP('2024-03-15');




