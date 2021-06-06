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
SELECT doctor.worker_id, doctor.`name`, (department.capacity - doctor.appointment_count) as remaining_capacity
FROM doctor, department
WHERE doctor.department_id = department.department_id
ORDER BY (department.capacity - doctor.appointment_count);

CREATE VIEW seeAllAppointments AS
SELECT prison.prison_id, prison.`name`, department.department_name, doctor.`name`as doctor_name
FROM appointment, doctor, prison, department
WHERE prison.prison_id = appointment.prison_id and doctor.worker_id = appointment.doctor_id
	and department.department_id = doctor.department_id
ORDER BY prison.prison_id;
