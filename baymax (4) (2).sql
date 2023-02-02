-- Active: 1665107027958@@127.0.0.1@3306@Baymax
CREATE DATABASE baymax;
USE baymax;

CREATE TABLE LOCATION(
	pincode int,
    city varchar(15),
    primary key(pincode)
);
CREATE TABLE PATIENT(
	id int AUTO_INCREMENT,
    dob date,
    fName varchar(20),
    lName varchar(20),
    phno varchar(15),
    gender varchar(7),
    height decimal(3,2),
    weight decimal(5,2),
    uname varchar(20) unique,
    pwd varchar(260),
    bloodType varchar(4),
    ban bool,
    apartmentNo varchar(10),
    streetName varchar(15),
    pincode int,
    state varchar(10),
    primary key (id),
    foreign key(pincode) references location(pincode)
);

CREATE TABLE DOCTOR(
	id int AUTO_INCREMENT,
    fName varchar(20),
    lName varchar(20),
    phno varchar(15),
    uname varchar(20) unique,
    gender varchar(7),
    availability time,
    specId varchar(10),
    pwd varchar(260),
    rating double,
    primary key(id)
);

CREATE TABLE ADMIN(
	id int AUTO_INCREMENT,
    fName varchar(20),
    lName varchar(20),
    gender varchar(7),
    uname varchar(20) unique,
    pwd varchar(260),
    primary key (id)
);

CREATE TABLE SERVICES(
	specId int AUTO_INCREMENT,
    specName varchar(15),
    doctorId int,
    price int,
    primary key(specId),
    foreign key(doctorId) references doctor(id)
);

CREATE TABLE RESERVATIONS(
	appointmentId int AUTO_INCREMENT,
    patientId int,
    doctorId int,
    slotId int,
    reservationDesc varchar(40),
    appointmentDate date,
    primary key(appointmentId),
    foreign key(patientId) references patient(id),
    foreign key(doctorId) references doctor(id),
	CONSTRAINT chk_slotId CHECK (slotId IN (9,10,11,12,13,14,15,16,17,18))
);

CREATE TABLE MEDICINES(
	id int AUTO_INCREMENT,
    mName varchar(15),
    mPrice int,
    mQuantity int,
    primary key(id)
);

CREATE TABLE PAYMENT(
	id int AUTO_INCREMENT,
    doctorId int,
    patientID int,
    appointmentId int,
    appointmentDate date,
    payDate date,
    consultationFee int,
    slotId int,
    verifiedBy int,
	payStatus int,
    primary key (id),
    foreign key(verifiedBy) references admin(id),
    foreign key(doctorId) references doctor(id),
    foreign key(patientId) references patient(id),
    CONSTRAINT check_slotId CHECK (slotId IN (9,10,11,12,13,14,15,16,17,18))

);

CREATE TABLE MEDORDER(
    medicineId int,
    paymentId int,
    medOrderedQuantity int,
    orderDate date,
    verifiedBy int,
    primary key(medicineId, paymentId),
    foreign key(verifiedBy) references admin(id),
    foreign key(medicineId) references medicines(id),
    foreign key(paymentId) references payment(id)
);

INSERT INTO LOCATION VALUES (79936, "El Paso"), (75080, "Dallas"), (77494, "Katy"), (75035, "Frisco"), (77083, "Houston");

INSERT INTO PATIENT(dob,fName,lName,phno,gender,height,weight,uname,pwd,bloodType,ban,apartmentNo,streetName,pincode,state) VALUES 
('1946-04-06',"Edward","Newgate",9452579082,"Male",6,112.8,"edward@gmail.com","25cce4f0b1635ec1a7d68733a48b70660a708936ec3d79cff7336a66ef92c57f","A+",false,"120","Ace Ln",75080,"Texas"),
('1993-02-06',"Robin","Nico",9454389467,"Female",5.9,56.3,"robin@gmail.com","d75fe64107a8e981228b495399a70d2d71e44c0db0a7a65062abb6427c69af6f","O-",false,"101","Lata Pl",79936,"Texas"),
('1990-09-02',"Hancock","Boa",9450953567,"Female",5.9,64.8,"hancock@gmail.com","500f95e20540b955c419d6a8366777fcceb3c4eb4db52ec7c852db61ce3583be","B-",false,"1820","Primrose Lane",75035,"Texas"),
('1998-01-01',"Ace","Portgas",9458643560,"Male",5.8,77.1,"ace@gmail.com","1c4fce9b5136ff66d6f44262427a7fa5497316b5e91590c65a943cd93b1649e5","O+",false,"800A","Kirby Drive",77083,"Texas");

INSERT INTO PATIENT(dob,fName,lName,phno,gender,height,weight,uname,pwd,apartmentNo,streetName,pincode,state,ban) VALUES
('2001-05-05',"Luffy","Monkey",9450753796,"Male",5.4,54.4,"luffy@gmail.com","f68b4caa5e282a2f5d43923313ccf581f5470d51d98a4ad356ae6301a9a9e2c2","1819","Primrose Lane",75035,"Texas",false);

INSERT INTO DOCTOR (fName,lName,phno,uname,gender,availability,specId,pwd,rating) VALUES
("Zoro","Roronoa",9452983092,"zoro@gmail.com","Male","09:00:00","1","b697990bf06c931545e631265227ecbbcfdc67f501c88508fa9697bb9e018fb7",4.7),
("Sanji","Vinsmoke",9450983527,"sanji@gmail.com","Male","09:00:00","2","add828f9040e999372a9c1f58ed43248eed5cdff98beac22b9245995c32041f3",4.5),
("Law","Trafalgar",9453658379,"law@gmail.com","Male","09:30:00","3","b89eca5c7f980a0720de1dd27e57a63e0666b3608bacecaf01bf554d0df47ace",4.8),
("Mihawk","Dracule",9459829390,"mihawk@gmail.com","Male","09:00:00","1","79ff1977d1274bba937a670dfd20098cce6070583de342205640a689a7da6470",4.7),
("Linlin","Charlotte",9452983092,"linlin@gmail.com","Female","09:00:00","3","0e41b77c3af9cf8850665ae27edf45c6c5d8b6107c5e884e0f2ed063d74c6650",4.6);

INSERT INTO ADMIN (fName,lName,gender,uname,pwd) VALUES
("Sai Priya","Palamari","Female","priya@gmail.com","e8b013e170e47c60ea9f565f961f76b7faa73c9916c22ee28362a76d026e8e21"),
("Sashank","Visweshwaran","Male","sashank@gmail.com","d96260159afac24215591596dd4b694c98dee2b13f4513bcd8003eb3def7e4e7"),
("Vishal","Kovoru","Male","vishal@gmail.com","825833208711df9eb1a8064e8568198daf63fe3c57bed1980b1d7d63cf5107cf"),
("Akhila","Gunjari","Female","akhila@gmail.com","2aabeede82b9c37e70c9369bda88a8994da2460eb2c9d5a1904c622c1620e408"),
("Mahith","Garlapati","Male","mahith@gmail.com","0f06c4af87ff07f3d3915c5f6233377e7ad573046eff567140f7833c3e2a0448");


INSERT INTO SERVICES (specName,doctorId,price) VALUES
("General",1,100),
("Counseling",2,100),
("Therapy",3,100),
("General",4,100),
("Therapy",5,120);

INSERT INTO RESERVATIONS (patientId,doctorId,slotId,reservationDesc,appointmentDate) VALUES
(1,2,9,"stomachache","2022-11-29"),
(2,2,10,"Counseling","2022-11-29"),
(3,2,11,"Counseling","2022-11-29"),
(4,5,12,"Therapy","2022-11-29"),
(5,3,13,"Therapy","2022-11-29"),
(1,2,18,"general","2022-12-3"),
(1,2,10,"general","2022-12-4"),
(2,2,18,"general","2022-12-4"),
(4,2,11,"general","2022-12-4"),
(5,2,12,"general","2022-12-4");

INSERT INTO PAYMENT (doctorId,patientID,appointmentId,appointmentDate,payDate,consultationFee,slotId,payStatus) VALUES
(2,1,1,"2022-12-31","2022-12-31",50,13,0),
(2,2,2,"2022-12-31","2022-12-31",50,14,0);

INSERT INTO PAYMENT (doctorId,patientID,appointmentId,appointmentDate,payDate,consultationFee,slotId,verifiedBy,payStatus) VALUES
(2,1,1,"2022-11-29","2022-11-29",50,14,1,1),
(2,2,2,"2022-11-29","2022-11-29",50,15,1,1),
(2,3,3,"2022-11-29","2022-11-29",50,16,2,1),
(5,4,4,"2022-11-29","2022-11-29",50,17,1,1),
(3,5,5,"2022-11-29","2022-11-29",50,18,1,1);


INSERT INTO MEDICINES (mName,mPrice,mQuantity) VALUES
("Fluoxetine",10,80),
("Citalopram",29,80),
("Sertraline",18,80),
("Paroxetine",23,80),
("Escitalopram",41,80);


INSERT INTO MEDORDER (medicineId,paymentId,medOrderedQuantity,orderDate) VALUES
(1,1,2,"2022-11-29"),
(1,2,2,"2022-11-29"),
(1,3,2,"2022-11-29"),
(2,5,4,"2022-11-29"),
(2,1,2,"2022-11-29");

-- reservationDesc in RESERVATIONS
-- consultationFee in PAYMENT
-- specId in DOCTOR



-- Total quantity sold for each medicince
SELECT b.mName, SUM(a.medOrderedQuantity) as TotalQuantSold
FROM MEDORDER a , MEDICINES b
WHERE a.medicineId = b.id
GROUP BY a.medicineId
ORDER BY SUM(a.medOrderedQuantity);

-- Total amount paid by the Patient for all the medicines

SELECT p.fName, p.lName, t1.TotalMedCost
FROM PATIENT p, PAYMENT pa, RESERVATIONS r,
(SELECT t.paymentId, SUM(t.cost) as TotalMedCost
FROM (
SELECT a.paymentId, a.medOrderedQuantity * b.mPrice AS cost
FROM MEDORDER a , MEDICINES b
WHERE a.medicineId = b.id) t
GROUP BY t.paymentId) t1
WHERE p.id = r.patientId AND r.appointmentId = pa.appointmentId AND pa.id = t1.paymentId;

-- All payments that haven't verified, can be used to show it to admin so that he doesnt miss out verifying them */
CREATE VIEW Verified_Payments AS
SELECT * FROM PAYMENT
WHERE verifiedBy is NOT NULL;

-- Showing all general doctors to the user's who cant decide which doctor they have to visit */
CREATE VIEW General_Doctors AS
SELECT * FROM DOCTOR
WHERE specId = 1;

-- All medicines whose stock is empty */
CREATE VIEW Empty_Medicines AS
SELECT * FROM MEDICINES
WHERE mQuantity = 0;

CREATE VIEW alerts AS
SELECT P.id, p.fName, p.lName, SUM(case when pa.payStatus = 0 then 1 else 0 end) AS noOfPaymentsYetToBePaid,SUM(case when pa.verifiedBy is NULL then 1 else 0 end) AS noOfPaymentsYetToBeVerified
FROM PATIENT p, PAYMENT pa, RESERVATIONS r
WHERE p.id = r.patientId AND r.appointmentId = pa.appointmentId
GROUP BY P.id;

SELECT * from alerts;

create view ongoingappointments as 
select p.id as patientId, p.fName as patientName, d.id as doctorId, d.fName as doctorName, d.rating, r.appointmentId, r.reservationDesc as reason, r.slotId, r.appointmentDate, s.specName from reservations r, doctor d, patient p, services s 
where slotId = hour(now()) and r.patientId = p.id and d.id = r.doctorId and d.specId = s.specId and date(now()) = date(r.appointmentDate);

create view upcomingappointments as select p.id, p.fName as patientName, r.appointmentId, r.appointmentDate, r.slotId, d.id as doctorId, d.fName, d.rating, r.reservationDesc as reason, s.specName from reservations r, doctor d, patient p, services s where slotId > hour(now()) and r.patientId = p.id and d.id = r.doctorId and d.specId = s.specId and date(r.appointmentDate) = date(now());
-- upcoming
-- p.id, p.height, p.weight, p.bloodType, p.uname, pay.appointmentDate, pay.slotId, pay.doctorId, d.fName, r.reservationDesc as reason, r.appointmentId
-- ongoing
-- p.id as patientId,d.id as doctorId, d.fName as doctorName, d.rating, pay.id as payId, pay.slotId, pay.appointmentDate, r.reservationDesc as reason, r.specId, s.price

SELECT * from upcomingAppointments;

SELECT * from ongoingAppointments;

CREATE TABLE SLOT(
	slotId int,
    primary key(slotId)
);

INSERT INTO SLOT VALUES (9),(10),(11),(12),(13),(14),(15),(16),(17),(18);

CREATE VIEW med_details AS
SELECT mo.medicineId, mo.paymentId, mo.medOrderedQuantity, m.mName, m.mPrice,mo.verifiedBy
FROM MEDORDER mo
LEFT JOIN MEDICINES m
ON mo.medicineId=m.id;

-- drop view med_details;

SELECT * FROM SLOT WHERE slotId NOT IN (SELECT pay.slotId FROM PAYMENT pay, DOCTOR d WHERE d.id=pay.doctorId and d.id=2 and date(pay.appointmentDate) = date(now())) AND slotId > hour(now());
select * from payment where verifiedBy = NULL or payStatus = 0;

-- PresentDayFreeSlots(From that hour)
SELECT * FROM SLOT WHERE slotId > hour(now()) and slotId NOT IN (SELECT r.slotId FROM reservations r, payment pay, DOCTOR d WHERE d.id=r.doctorId and d.id=2 and date(r.appointmentDate) = date(now()) AND r.slotId > hour(now()));
-- NextDaysFreeSlots
SELECT * FROM SLOT WHERE slotId NOT IN (SELECT r.slotId FROM reservations r, DOCTOR d WHERE r.doctorId=1 and date(r.appointmentDate) = date(DATE_ADD(now(), INTERVAL 1 DAY)));

select slotId from reservations r where date(r.appointmentDate)  = date(DATE_ADD(now(), INTERVAL 1 DAY));

CREATE VIEW payment_unverified_unpaid AS
SELECT DISTINCT id FROM PAYMENT WHERE verifiedBy IS NULL OR payStatus=0
UNION
SELECT DISTINCT paymentId FROM MEDORDER WHERE verifiedBy IS NULL;

select * from payment_unverified_unpaid;

select * from payment where id in (select * from payment_unverified_unpaid);

select * from payment where patientId = 2 and appointmentDate < now() order by appointmentDate ASC
-- DROP DATABASE baymax;