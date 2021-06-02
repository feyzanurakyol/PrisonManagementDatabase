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

1-Mahkum gelince ward capacity i düşür
2-Doktor her muayene ettiğinde kayıt oluştur
3-HealthStatus her değiştidiğinde doktora bilgi veren bi tablo, geçmiş recordları görebilir.
4-Bi mahkumun ward ı değiştirilirse, gerekli kapasite güncellemeleri yapılmalı
5-Judgement eklenirse, release date i güncelle