USE prisondatabase;

CREATE VIEW ChronicalDesaeses AS
SELECT prison.prison_id, `name`, health_status.chronical_disease
FROM prison, health_status
WHERE prison.prison_id = health_status.prison_id and health_status.chronical_disease != 'NO';

CREATE VIEW SeePrisonJudgement AS
SELECT prison.prison_id, `name`,  DATEDIFF(prison.release_date, CURDATE()) AS remaining_days, judgement.criminal_type,
		health_status.age
FROM prison, judgement, health_status
WHERE prison.prison_id = judgement.prison_id and health_status.prison_id = prison.prison_id;

CREATE VIEW remainingDays AS
SELECT prison.`name`, DATEDIFF(prison.release_date, CURDATE()) AS remaining_days
FROM prison
ORDER BY  prison.prison_id;

CREATE VIEW jailers_ward AS
SELECT jailer.worker_id, jailer.`name`,  on_duty.ward_no as ward
FROM on_duty , jailer
WHERE jailer.worker_id = on_duty.jailer_id
ORDER BY jailer.worker_id;

CREATE VIEW doctorsCapacity AS
SELECT doctor.worker_id, doctor.`name`, department.department_name, 
		(department.capacity - doctor.appointment_count) as remaining_capacity
FROM doctor, department
WHERE doctor.department_id = department.department_id
ORDER BY (department.capacity - doctor.appointment_count);

CREATE VIEW seeAllAppointments AS
SELECT p.prison_id, p.`name`, a.doctor_id, a.created_date
FROM prison AS p
JOIN appointment AS a
ON p.prison_id = a.prison_id
ORDER BY a.created_date;

CREATE VIEW seeAllPrisonsAndVisitors AS
SELECT prison.prison_id, prison.`name`, visit.visitor_tc, visit.visit_date
FROM visit 
RIGHT OUTER JOIN prison
ON prison.prison_id = visit.prison_id ;


CREATE VIEW seeAllPrisonsAppointments AS
SELECT p.prison_id, p.`name`, a.doctor_id, a.created_date
FROM prison AS p
LEFT OUTER JOIN appointment AS a
ON p.prison_id = a.prison_id ;

CREATE VIEW seeWards AS
SELECT p.prison_id, p.`name`, p.ward_id
FROM prison AS p
LEFT OUTER JOIN ward
ON p.ward_id = ward.ward_id 
UNION
SELECT p.prison_id, p.`name`, p.ward_id
FROM prison AS p
RIGHT OUTER JOIN ward
ON p.ward_id = ward.ward_id



