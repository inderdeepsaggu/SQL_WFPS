CREATE TABLE call_logs(
	incident_number bigint,
	incident_type varchar(40),
	call_time timestamp,
	call_closed timestamp,
	motor_vehicle_incident varchar(5),
	neighbourhood varchar(50),
	ward varchar(50)
);