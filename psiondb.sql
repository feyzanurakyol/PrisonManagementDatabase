DROP DATABASE IF EXISTS `PrisonDatabase`;
CREATE DATABASE `PrisonDatabase`;
USE `PrisonDatabase`;

CREATE TABLE jailer (
	`worker_id` int NOT NULL,
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `country` varchar(300),
	
    PRIMARY KEY (`worker_id`)
 );
 
 CREATE TABLE ward (
	`ward_id` int NOT NULL,
    `size` int NOT NULL,
    `capacity` int NOT NULL,
	`floor no` varchar(30) NOT NULL,    

    PRIMARY KEY (`ward_id`)
);

CREATE TABLE on_duty (
	`jailer_id` int,
    `ward_no` int,
    
    CONSTRAINT FK_Jailer FOREIGN KEY(jailer_id) REFERENCES jailer(worker_id),
    CONSTRAINT FK_Ward FOREIGN KEY(ward_no) REFERENCES ward(ward_id),
    PRIMARY KEY(jailer_id,ward_no)
);

CREATE TABLE prison (
	`prison_id` int NOT NULL,
	`ward_id` int,
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `country` varchar(300),
    arrest_date date,
    release_date date,
	
    PRIMARY KEY (`prison_id`),
    CONSTRAINT FK_WardID FOREIGN KEY (ward_id) REFERENCES ward(ward_id)
);

CREATE TABLE judgement (
	prison_id int,
	criminal_type varchar(100),
    conviction_time int,
    
    CONSTRAINT FK_PrisonId FOREIGN KEY (prison_id) REFERENCES prison(prison_id),
    PRIMARY KEY(prison_id,criminal_type)
);


CREATE TABLE visitor (
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `address` varchar(300),
    `connection` varchar(10),
	
    PRIMARY KEY (`tc`)
);

CREATE TABLE visit(
	prison_id int,
    visitor_tc int,
    visit_date date,
    
    CONSTRAINT FK_VisitPrison FOREIGN KEY (prison_id) REFERENCES prison(prison_id),
    CONSTRAINT FK_VisitorTC FOREIGN KEY(visitor_tc) REFERENCES visitor(tc),
    PRIMARY KEY(prison_id,visitor_tc)
);

CREATE TABLE doctor (
	`worker_id` int NOT NULL,
    `tc` int NOT NULL,
	`name` varchar(30) NOT NULL,
    `birth_date` date NOT NULL,
    `phone` int,
    `country` varchar(300),
    department varchar(20),
    
    PRIMARY KEY(worker_id)
);

CREATE TABLE health_status(
	prison_id int,
    chronical_disease varchar(30),
    blood_type varchar(5),
    age int,
    disability_status varchar(30),
    doctor_id int,
    
    CONSTRAINT FK_PrisonHealthId FOREIGN KEY (prison_id) REFERENCES prison(prison_id),
    CONSTRAINT FK_DoctorId FOREIGN KEY (doctor_id) REFERENCES doctor(worker_id)
);


CREATE TABLE appointment(
	prison_id int,
    doctor_id int,
    
	CONSTRAINT FK_PrisonHealthId FOREIGN KEY (prison_id) REFERENCES prison(prison_id),
    CONSTRAINT FK_DoctorId FOREIGN KEY (doctor_id) REFERENCES doctor(worker_id)
);
