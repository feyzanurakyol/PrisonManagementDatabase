SELECT p.prison_id, p.`name`, a.doctor_id, a.created_date
FROM prison AS p
LEFT OUTER JOIN appointment AS a
ON p.prison_id = a.prison_id ;


SELECT prison.prison_id, prison.`name`, visit.visitor_tc, visit.visit_date
FROM visit 
RIGHT OUTER JOIN prison
ON prison.prison_id = visit.prison_id ;

SELECT prison.prison_id, prison.`name`, visit.visitor_tc, visit.visit_date
FROM visit 
JOIN prison
ON prison.prison_id = visit.prison_id ;


