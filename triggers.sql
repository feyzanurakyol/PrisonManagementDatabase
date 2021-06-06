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
CREATE TRIGGER prison_added BEFORE INSERT
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
    values(OLD.prison_id, OLD.chronical_disease, 
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
	UPDATE doctor SET doctor.size = doctor.size + 1
    WHERE NEW.doctor_id = doctor.worker_id;
END//
DELIMITER ;


1-Mahkum gelince ward capacity i düşür
2-Doktor her health statusu değiştiriğinde ettiğinde kayıt oluştur
3-HealthStatus her değiştidiğinde doktora bilgi veren bi tablo, geçmiş recordları görebilir.
4-Bi mahkumun ward ı değiştirilirse, gerekli kapasite güncellemeleri yapılmalı
5-Judgement eklenirse, release date i güncelle