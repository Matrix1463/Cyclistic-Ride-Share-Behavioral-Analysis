-- ============================================================
-- Cyclistic Ride-Share Behavioral Analysis
-- Author: Chinedu Okafor
-- Tool: Google BigQuery (GoogleSQL)
-- Description: Combines Q1 2021 monthly trip tables, cleans
--              the data, and engineers features for analysis
--              in Python and Tableau.
-- ============================================================
 
 
-- ============================================================
-- QUERY 1: Build cleaned and feature-engineered analysis table
-- ============================================================
-- Creates a single table from three monthly sources with:
--   - Ride duration in minutes
--   - Hour of day extracted from start time
--   - Day of week extracted from start time
--   - Filtered to remove nulls and invalid ride durations
 
CREATE OR REPLACE TABLE `rugged-shell-453319-f6.divvy_trip_data.q1_2021_trips_clean_prepped` AS
 
SELECT
  *,
 
  -- Ride duration in minutes (key metric for behavioral comparison)
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_duration,
 
  -- Hour of day (0–23) for time-of-day analysis
  EXTRACT(HOUR FROM started_at) AS hour,
 
  -- Full day name (e.g., Monday) for weekday vs weekend analysis
  FORMAT_TIMESTAMP('%A', started_at) AS day_of_week
 
FROM (
 
  -- Combine January, February, and March 2021 trip data
  SELECT *, 'Jan' AS month
  FROM `rugged-shell-453319-f6.divvy_trip_data.202101-divvy-tripdata`
 
  UNION ALL
 
  SELECT *, 'Feb' AS month
  FROM `rugged-shell-453319-f6.divvy_trip_data.202102-divvy-tripdata`
 
  UNION ALL
 
  SELECT *, 'Mar' AS month
  FROM `rugged-shell-453319-f6.divvy_trip_data.202103-divvy-tripdata`
 
)
 
WHERE
  -- Remove rows with missing timestamps (required for duration calculation)
  started_at IS NOT NULL
  AND ended_at IS NOT NULL
 
  -- Remove rows with missing user type (required for member vs casual comparison)
  AND member_casual IS NOT NULL
 
  -- Remove invalid rides with zero or negative duration (data entry errors)
  AND TIMESTAMP_DIFF(ended_at, started_at, MINUTE) > 0
 
  -- Remove extreme outliers over 24 hours (likely unreturned or improperly docked bikes)
  AND TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1440;
 
 
-- ============================================================
-- QUERY 2: Ride frequency by hour of day and user type
-- ============================================================
-- Used to identify commute peaks (members) vs midday leisure
-- patterns (casual riders)
 
SELECT
  member_casual,
  EXTRACT(HOUR FROM started_at) AS hour,
  COUNT(*) AS ride_count
FROM `rugged-shell-453319-f6.divvy_trip_data.q1_2021_trips_clean_prepped`
GROUP BY member_casual, hour
ORDER BY hour;
 
 
-- ============================================================
-- QUERY 3: Average ride duration by user type
-- ============================================================
-- Used to validate Python findings on ride duration differences
-- between casual riders and annual members
 
SELECT
  member_casual,
  AVG(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS avg_ride_duration
FROM `rugged-shell-453319-f6.divvy_trip_data.q1_2021_trips_clean_prepped`
GROUP BY member_casual;
 
 
-- ============================================================
-- QUERY 4: Ride frequency by day of week and user type
-- ============================================================
-- Used to identify weekend concentration among casual riders
-- vs consistent weekday usage among annual members
 
SELECT
  member_casual,
  FORMAT_TIMESTAMP('%A', started_at) AS day_of_week,
  COUNT(*) AS ride_count
FROM `rugged-shell-453319-f6.divvy_trip_data.q1_2021_trips_clean_prepped`
GROUP BY member_casual, day_of_week
ORDER BY day_of_week;