USE prisondatabase;

CREATE VIEW ChronicalDesaeses AS
SELECT prison.prison_id, `name`, health_status.chronical_disease
FROM prison, health_status
WHERE prison.prison_id = health_status.prison_id and health_status.chronical_disease != 'NO';

CREATE VIEW remainingDays AS
SELECT j.prison_id, prison.`name`, DATEDIFF(prison.release_date, CURDATE()) 
FROM judgement j, prison
WHERE prison.prison_id = j.prison_id
ORDER BY  prison.prison_id