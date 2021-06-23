USE prisondatabase;

DELIMITER //
CREATE TRIGGER judgement_added AFTER INSERT
ON judgement
FOR EACH ROW
BEGIN
	UPDATE prison SET release_date = date_add(release_date, INTERVAL NEW.conviction_time DAY)
    WHERE NEW.prison_id = prison.prison_id;
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER prison_added AFTER INSERT
ON prison
FOR EACH ROW
BEGIN
	UPDATE ward SET ward.size = ward.size - 1
    WHERE NEW.ward_id = ward.ward_id;
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER health_status_changes AFTER UPDATE
ON health_status
FOR EACH ROW
BEGIN
	INSERT INTO health_status_changes 
    VALUES(CURDATE(), HOUR(NOW()),OLD.prison_id, OLD.chronical_disease, 
		   OLD.blood_type, OLD.age, OLD.disability_status);
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER prison_ward_changes AFTER UPDATE
ON prison
FOR EACH ROW
BEGIN
	UPDATE ward SET ward.size = ward.size - 1
    WHERE NEW.ward_id = ward.ward_id;
    
    UPDATE ward SET ward.size = ward.size + 1
    WHERE OLD.ward_id = ward.ward_id;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER appointment_added AFTER INSERT
ON appointment
FOR EACH ROW
BEGIN
	UPDATE doctor SET doctor.appointment_count = doctor.appointment_count + 1
    WHERE NEW.doctor_id = doctor.worker_id;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER appointment_deleted BEFORE DELETE
ON appointment
FOR EACH ROW
BEGIN
	UPDATE doctor SET doctor.appointment_count = doctor.appointment_count - 1
    WHERE OLD.doctor_id = doctor.worker_id;
    
    INSERT INTO appointment_done VALUES(CURDATE(), HOUR(NOW()),OLD.prison_id, 
								  OLD.doctor_id, OLD.created_date, OLD.created_time);
END//
DELIMITER ;
