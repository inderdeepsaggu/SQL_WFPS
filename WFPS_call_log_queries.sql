-- Most common incident type

SELECT incident_type, COUNT(*) AS incident_count
FROM call_logs
GROUP BY incident_type
ORDER BY incident_count DESC;

-- The ward that had the lowest average call closing time

SELECT ward, AVG(call_closed - call_time) AS average_time
FROM call_logs
GROUP BY ward
ORDER BY average_time;

-- Analyze difference between call changes over time, by hour, day, month, or year. 
-- In this query below I was looking for when most medical emergency calls came in during which hour of the day

SELECT EXTRACT(HOUR FROM call_time) AS time_of_day, COUNT(*) call_count
FROM call_logs
WHERE incident_type = 'Medical Emergency' OR incident_type = 'Medical Response'
GROUP BY time_of_day
ORDER BY call_count DESC;

-- Which neighbourhood had the highest number of incidents in the data set

SELECT neighbourhood, COUNT(*) AS num_of_incidents
FROM call_logs
GROUP BY neighbourhood
ORDER BY num_of_incidents DESC;

-- Number of incidents during holidays per year (Between December 20 to December 31), which incident type it was, and if it was a motor vehicle incident

WITH holiday_range AS (
	SELECT incident_number, incident_type, call_time, motor_vehicle_incident
	FROM call_logs
	WHERE EXTRACT(MONTH FROM call_time) = 12
	AND EXTRACT(DAY FROM call_time) BETWEEN 20 AND 31
)
SELECT incident_type, COUNT(*) AS num_of_incidents
FROM holiday_range
WHERE motor_vehicle_incident = 'YES'
GROUP BY incident_type
ORDER BY num_of_incidents DESC;

-- Checking which incident had the longest closing time (ASC for shortest)
-- EPOCH used for seconds but in the dataset I used timestamps for call_time and call_closed

SELECT incident_number, call_time, call_closed, call_closed - call_time AS time_diff
FROM call_logs
ORDER BY time_diff DESC;


SELECT incident_number, call_time, call_closed, EXTRACT(EPOCH FROM (call_closed - call_time))/3600 as time_diff
FROM call_logs
ORDER BY time_diff DESC;

-- Longest average closing time per neighbourhood

SELECT neighbourhood, AVG(call_closed - call_time) AS average_closing_time
FROM call_logs
GROUP BY neighbourhood
ORDER BY average_closing_time DESC;

-- Highest number of motor vehicle incidents in each neighbourhood, most to least

SELECT neighbourhood, COUNT(*) AS incidents
FROM call_logs
WHERE motor_vehicle_incident = 'YES'
GROUP BY neighbourhood
ORDER BY incidents DESC;

-- Highest number of motor vehicle incidents in each year, most to least

SELECT EXTRACT(YEAR FROM call_time) AS year_of_call, COUNT(*) call_count
FROM call_logs
WHERE motor_vehicle_incident = 'YES'
GROUP BY year_of_call
ORDER BY call_count DESC;