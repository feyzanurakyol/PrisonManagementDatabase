DROP DATABASE IF EXISTS `PrisonDatabase`;
CREATE DATABASE `PrisonDatabase`;
USE `PrisonDatabase`;

CREATE TABLE jailer (
	`worker_id` int NOT NULL,
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `address` varchar(300),
	
    PRIMARY KEY (`worker_id`)
 );
 
 INSERT INTO jailer VALUES(1,1234567889,'Tuba Göçer','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(2,1234567889,'Ali Göçer','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(3,1234567889,'Veli Göçer','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(4,1234567889,'Ali Semiz','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(5,1234567889,'Gamze Seder','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(6,1234567889,'Yaren Hali','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(7,1234567889,'Sedar Nakit','1986-01-01',54432452,'İstanbul');
 INSERT INTO jailer VALUES(8,1234567889,'Batuhan Bal','1986-01-01',54432452,'İstanbul');


CREATE TABLE ward (
	`ward_id` int NOT NULL,
    `size` int NOT NULL,
    `capacity` int NOT NULL,
	`floor no` varchar(30) NOT NULL,    

    PRIMARY KEY (`ward_id`)
);

INSERT INTO ward VALUES(1,30,30,1);
INSERT INTO ward VALUES(2,30,30,1);
INSERT INTO ward VALUES(3,30,30,1);
INSERT INTO ward VALUES(4,30,30,1);
INSERT INTO ward VALUES(5,30,30,1);
INSERT INTO ward VALUES(6,30,30,2);
INSERT INTO ward VALUES(7,30,30,2);
INSERT INTO ward VALUES(8,30,30,2);
INSERT INTO ward VALUES(9,30,30,2);
INSERT INTO ward VALUES(10,30,30,2);
INSERT INTO ward VALUES(11,30,30,3);
INSERT INTO ward VALUES(12,30,30,3);
INSERT INTO ward VALUES(13,30,30,3);

CREATE TABLE on_duty (
	`jailer_id` int,
    `ward_no` int,
    
    CONSTRAINT FK_Jailer FOREIGN KEY(jailer_id) REFERENCES jailer(worker_id),
    CONSTRAINT FK_Ward FOREIGN KEY(ward_no) REFERENCES ward(ward_id),
    PRIMARY KEY(jailer_id,ward_no)
);

INSERT INTO on_duty VALUES (1,1);
INSERT INTO on_duty VALUES (1,2);
INSERT INTO on_duty VALUES (1,3);
INSERT INTO on_duty VALUES (2,1);
INSERT INTO on_duty VALUES (2,2);
INSERT INTO on_duty VALUES (2,3);
INSERT INTO on_duty VALUES (3,1);
INSERT INTO on_duty VALUES (3,2);
INSERT INTO on_duty VALUES (3,3);

CREATE TABLE prison (
	`prison_id` int NOT NULL,
	`ward_id` int,
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `address` varchar(300),
	
    PRIMARY KEY (`prison_id`),
    CONSTRAINT FK_WardID FOREIGN KEY (ward_id) REFERENCES ward(ward_id)
);

INSERT INTO prison VALUES (1,1,1111111111,'FEYZA NUR AKYOL', '1998-11-18', 544837322,'Kocaeli');
INSERT INTO prison VALUES (2,1,1111111141,'ABDÜLHAKİM MUAZ DURAN', '1996-8-22', 528123232,'Istanbul');
INSERT INTO prison VALUES (3,1,1111111131,'ESRA NUR ARICAN', '1997-7-22', 544837322,'Istanbul');
INSERT INTO prison VALUES (4,1,1111111411,'FATİH SELİM YAKAR', '1998-9-18', 544823232,'Istanbul');
INSERT INTO prison VALUES (5,1,1111111122,'AHSEN KUTBAY', '1998-10-7', 544834232,'Kocaeli');
INSERT INTO prison VALUES (6,1,1111111122,'HÜSNANUR TAŞTAN', '1998-10-7', 534834232,'Kocaeli');
INSERT INTO prison VALUES (7,1,1111111122,'BİRGUL IŞITAN', '1998-10-7', 544234232,'Kocaeli');
INSERT INTO prison VALUES (8,1,1111111122,'İSMİNUR ÖZBEK', '1998-10-7', 544734232,'Kocaeli');

CREATE TABLE judgement (
	prison_id int,
	criminal_type varchar(100),
    arrest_date date,
    release_date date,
    
    CONSTRAINT FK_PrisonId FOREIGN KEY (prison_id) REFERENCES prison(prison_id),
    PRIMARY KEY(prison_id,criminal_type)
);

INSERT INTO judgement VALUES(1,'Attempt to kill three lecturers.', '2021-08-08','2024-08-08');
INSERT INTO judgement VALUES(1,'Setting fire to the Computer Engineering building.', '2021-08-08','2024-08-08');
INSERT INTO judgement VALUES(2,'Attempt to kill three lecturers', '2021-08-08','2024-08-08');
INSERT INTO judgement VALUES(3,'Attempt to kill three lecturers', '2021-08-08','2024-08-08');
INSERT INTO judgement VALUES(4,'Attempt to kill three lecturersla', '2021-08-08','2024-08-08');
INSERT INTO judgement VALUES(2,'Setting fire to the Computer Engineering building.', '2021-08-08','2024-08-08');

CREATE TABLE visitor (
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `address` varchar(300),
    `connection` varchar(10),
	
    PRIMARY KEY (`tc`)
);

INSERT INTO visitor VALUES(89736402,'FADİME AKYOL','1975-10-06',544234232,'KOCAELİ','Mother');
INSERT INTO visitor VALUES(39736402,'FATİH AKYOL','1975-10-06',544234232,'KOCAELİ','FATHER');
INSERT INTO visitor VALUES(53736402,'SEDAT DURAN','1975-10-06',544234232,'KOCAELİ','FATHER');
INSERT INTO visitor VALUES(349736402,'TUĞÇE ARICAN','1998-10-06',544234232,'KOCAELİ','SISTER');
INSERT INTO visitor VALUES(229736402,'HUMEYRA YILMAZ','1975-10-06',544234232,'KOCAELİ','FRIEND');
INSERT INTO visitor VALUES(523489736,'ALİ HALI','1975-10-06',544234232,'KOCAELİ','UNCLE');
INSERT INTO visitor VALUES(567897364,'SELAMİ GURSES','1975-10-06',544234232,'KOCAELİ','MOTHER');

CREATE TABLE visit(
	prison_id int,
    visitor_tc int,
    visit_date date,
    
    CONSTRAINT FK_VisitPrison FOREIGN KEY (prison_id) REFERENCES prison(prison_id),
    CONSTRAINT FK_VisitorTC FOREIGN KEY(visitor_tc) REFERENCES visitor(tc),
    PRIMARY KEY(prison_id,visitor_tc)
);

INSERT INTO visit VALUES(1,89736402,'2021-08-10');
INSERT INTO visit VALUES(1,39736402,'2021-08-10');
INSERT INTO visit VALUES(3,229736402,'2021-08-10');
INSERT INTO visit VALUES(3,349736402,'2021-08-10');
INSERT INTO visit VALUES(4,567897364,'2021-08-10');
INSERT INTO visit VALUES(5,523489736,'2021-08-10');

CREATE TABLE health_status(
	prison_id int,
    chronical_disease varchar(30),
    blood_type varchar(5),
    age int,
    disability_status varchar(30),
    
    CONSTRAINT FK_PrisonHealthId FOREIGN KEY (prison_id) REFERENCES prison(prison_id)
);

INSERT INTO health_status VALUES(1,'NO','0+','22','NO');
INSERT INTO health_status VALUES(2,'NO','A+','24','NO');
INSERT INTO health_status VALUES(3,'NO','A+','22','NO');
INSERT INTO health_status VALUES(4,'NO','A+','22','NO');
INSERT INTO health_status VALUES(5,'NO','A+','22','NO');
INSERT INTO health_status VALUES(6,'Cardiac','A+','22','NO');
INSERT INTO health_status VALUES(7,'NO','A+','22','NO');
INSERT INTO health_status VALUES(8,'Thyroid patient','A+','22','NO');


