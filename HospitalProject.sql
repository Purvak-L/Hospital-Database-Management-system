CREATE DATABASE Hospital_Management;

USE Hospital_Management;


CREATE TABLE Staff (
    Staff_id INT,
    Fname VARCHAR(30) NOT NULL,
    Mname VARCHAR(30) NOT NULL,
    Lname VARCHAR(30) NOT NULL,
    Salary INT NOT NULL,
    DOB DATE,
    Address VARCHAR(40),
    Shifts INT,
    Join_date DATE,
    PRIMARY KEY (Staff_id)
);

CREATE TABLE S_Phone_N0 (
    Staff_id INT,
    S_phone_no INT,
    PRIMARY KEY (S_phone_no , Staff_id),
    FOREIGN KEY (Staff_id)
        REFERENCES Staff (Staff_id)
);

SELECT 
    *
FROM
    S_phone_n0;

CREATE TABLE Doctor (
    Staff_id INT,
    AoS VARCHAR(20),
    Desg VARCHAR(20),
    PRIMARY KEY (Staff_id)
);




CREATE TABLE Patient (
    PID INT,
    Pfname VARCHAR(25),
    Pmname VARCHAR(25),
    Plname VARCHAR(25),
    Doc_incharge VARCHAR(20),
    DOB DATE,
    admit_date DATE,
    Address VARCHAR(40),
    Lab_id INT,
    Ro_No INT,
    PRIMARY KEY (PID)
);

CREATE TABLE Treats (
    PID INT,
    Staff_id INT,
    PRIMARY KEY (PID , Staff_id),
    FOREIGN KEY (PID)
        REFERENCES Patient (PID),
    FOREIGN KEY (Staff_id)
        REFERENCES Doctor (Staff_id)
);


SELECT 
    *
FROM
    treats;

CREATE TABLE Medicine (
    Med_name VARCHAR(25) UNIQUE,
    DOE DATE,
    DOM DATE,
    Doc_id INT,
    Pat_id INT,
    PRIMARY KEY (Med_name),
    FOREIGN KEY (Doc_id)
        REFERENCES Doctor (Staff_id),
    FOREIGN KEY (Pat_id)
        REFERENCES Patient (PID)
);

SELECT 
    *
FROM
    Medicine;

CREATE TABLE Receptionist (
    Staff_id INT,
    PRIMARY KEY (Staff_id)
);

SELECT 
    *
FROM
    Receptionist;


CREATE TABLE ROOM (
    Room_no INT,
    Room_incharge VARCHAR(25),
    Rec_id INT,
    PRIMARY KEY (Room_no),
    FOREIGN KEY (Rec_id)
        REFERENCES Receptionist (Staff_id)
);



SELECT 
    *
FROM
    ROOM;


CREATE TABLE Record (
    Record_No INT,
    Rec_of_pat INT,
    DOF DATE,
    Re_id INT,
    PRIMARY KEY (Record_No),
    FOREIGN KEY (Re_id)
        REFERENCES Receptionist (Staff_id),
    FOREIGN KEY (Rec_of_pat)
        REFERENCES Patient (PID)
);

CREATE TABLE Accountant (
    Staff_id INT PRIMARY KEY
);

SELECT 
    *
FROM
    Accountant;

CREATE TABLE transactions (
    TID INT PRIMARY KEY,
    DOT DATE,
    type VARCHAR(20)
);


Alter table transactions 
add accno int ;

Alter table transactions 
add currbal int ;

CREATE TABLE trigger_time (
    exec_time DATETIME
);

CREATE TRIGGER upd_check BEFORE insert ON transactions
FOR EACH ROW
INSERT INTO trigger_time values(NOW());


SELECT 
    *
FROM
    trigger_time;

SELECT 
    *
FROM
    Transactions;

CREATE TABLE staff_audit (
    staff_id INT,
    fname VARCHAR(40),
    changedate DATETIME
);

DELIMITER $$
CREATE TRIGGER before_staff_update3 
    Before UPDATE ON staff
    FOR EACH ROW 
BEGIN
    INSERT INTO staff_audit
     VALUES(OLD.staff_id,OLD.fname,NOW() );
END$$
DELIMITER ;


CREATE TRIGGER inss_check BEFORE insert ON staff
FOR EACH ROW
INSERT INTO staff_audit values(New.staff_id,New.fname,NOW());



delete from staff
where staff_id=120;

update staff 
set salary =10000
where staff_id=102;


select * from inss_check;


select * from staff_audit;

drop trigger before_staff_update;

Update Staff 
Set  shifts = 10
where staff_id =110;
select * from staff where staff_id =110;






DELIMITER $$

CREATE PROCEDURE sp8 (x VARCHAR(10))
BEGIN
 declare varaccno int default 701;
  DECLARE  vartamt int default 1500;
  DEclare varcurrbal int;
 START TRANSACTION ;
  savepoint withd;

  update Transactions set currbal = currbal + vartamt
  where tid = varaccno;  
  select currbal into varcurrbal from transactions where tid = varaccno;
  if varcurrbal > 500000 then
  rollback to savepoint withd;
  else
  commit;
  end if;


END;
$$

DELIMITER ;

call sp8('trans');

SELECT 
    *
FROM
    transactions;



CREATE TABLE Handles (
    Staff_id INT,
    TID INT,
    PRIMARY KEY (Staff_id , TID),
    FOREIGN KEY (Staff_id)
        REFERENCES Accountant (Staff_id),
    FOREIGN KEY (TID)
        REFERENCES Transactions (TID)
);


SELECT 
    *
FROM
    handles;

CREATE TABLE Laboratorist (
    Staff_id INT,
    PRIMARY KEY (Staff_id),
    FOREIGN KEY (Staff_id)
        REFERENCES Staff (Staff_id)
);


SELECT 
    *
FROM
    Laboratorist;

CREATE TABLE Laboratory (
    Lab_id INT PRIMARY KEY,
    labor_id INT,
    FOREIGN KEY (labor_id)
        REFERENCES Laboratorist (Staff_id)
);


SELECT 
    *
FROM
    LAboratory;

CREATE TABLE Nurse (
    Staff_id INT,
    Room_n INT,
    PRIMARY KEY (Staff_id),
    FOREIGN KEY (Staff_id)
        REFERENCES Staff (Staff_id)
);


SELECT 
    *
FROM
    Nurse;

CREATE TABLE P_Phoneno (
    PID INT,
    P_phone_no INT,
    PRIMARY KEY (PID , P_phone_no)
);
SELECT 
    *
FROM
    p_phoneno;


CREATE TABLE Patient (
    PID INT,
    Pfname VARCHAR(25),
    Pmname VARCHAR(25),
    Plname VARCHAR(25),
    Doc_incharge VARCHAR(20),
    DOB DATE,
    admit_date DATE,
    Address VARCHAR(40),
    Lab_id INT,
    Ro_No INT,
    PRIMARY KEY (PID)
);

CREATE VIEW Shift_9 AS
    SELECT 
        staff_id, fname, Lname
    FROM
        staff
    WHERE
        shifts = 9;

SELECT 
    *
FROM
    shift_9;

CREATE VIEW REC_PAT AS
    SELECT 
        r.record_no, p.pfname, p.plname
    FROM
        patient AS p,
        record AS r
    WHERE
        r.rec_of_pat = p.pid;
    
SELECT 
    *
FROM
    rec_pat;   

insert into patient values(200,'Bob','Joseph','Marley','Arunima','1980-02-01','2010-03-10','SanFrans',400,500);
insert into patient values(201,'Hanna','tom','Marley','Simoni','1982-03-01','2014-03-10','Boston',401,501);
insert into patient values(202,'Spencer','Jon','Hastings','Simoni','1983-04-01','2012-03-10','NewYork',400,502);
insert into patient values(203,'Frank','Joe','Underwood','Purvak','1981-05-11','2013-03-10','New Jersey',400,503);
insert into patient values(204,'Joey','Aston','Tribiani','Purvak','1982-06-21','2012-03-10','London',401,500);
insert into patient values(205,'Chandler','Muriel','Bing','Sai','1984-02-06','2016-03-10','Manchester',401,501);
insert into patient values(206,'Rachel','Mark','Geller','Arunima','1985-09-01','2009-03-10','Madrid',400,502);
insert into patient values(207,'Cameron','Tyler','Woss','Sai','1985-02-11','2009-03-10','Valencia',401,503);
insert into patient values(208,'Mark','harold','Zuckenburg','Purvak','1986-11-10','2010-03-10','Texas',400,501);
insert into patient values(209,'Aria','Bryon','Mont','Simoni','1981-02-21','2015-03-10','Wolchester',400,500);




insert into Staff values(100,'Simoni','Manoj','Jain',500000,'1992-05-07','Malabar hill, Mumbai',9,'2015-06-01');
insert into Staff values(101,'Arunima','Angshu','Mukhopadhyay',450000,'1988-03-14','Park Street, Kolkata',10,'2014-01-23');
insert into Staff values(102,'Purvak','Miten','Lapsiya',600000,'1990-08-18','M.G.Street, Jalgaon',9,'2012-04-14');
insert into Staff values(103,'Sai','Subhasree','Pakina',400000,'1992-04-14','Harbor road, Hyderabad',9,'2015-10-27');
insert into Staff values(104,'Viren','Manoj','Parmar',450000,'1989-06-28','Nehru road, Orissa',10,'2011-11-19');
insert into Staff values(105,'Sambit','Sudhanshu','Mohapatra',450000,'1989-03-11','Hill road, Mumbai',11,'2011-11-19');
insert into Staff values(106,'Hardik','Sanjay','Shah',450000,'1989-06-28','Gandhi road, Orissa',12,'2011-11-19');
insert into Staff values(107,'Ashok','Mohan','Patel',550000,'1989-06-01','Adarsh marg, Jaipur',1,'2010-06-10');
insert into Staff values(108,'Avish','Manoj','Jain',150000,'1982-07-28',' Koregaon, Pune',1,'2012-03-11');
insert into Staff values(109,'Forum','Pratap','Bhanushali',250000,'1983-07-27','FC road, Jodhpur',4,'2013-02-12');
insert into Staff values(110,'Menaka','Ravi','Narayan',350000,'1984-08-23','Deccan, Surat',7,'2012-11-13');
insert into Staff values(111,'Yash','Suresh','Pasar',450000,'1985-03-22','Chandni Chowk, Delhi',8,'2010-12-14');
insert into Staff values(112,'Pranali','Viren','Awasekar',450000,'1986-04-21','Pearl road, Chennai',12,'2010-08-11');
insert into Staff values(113,'Dhruv','Amit','Mehra',650000,'1989-05-12','Carter road, Mumbai',10,'2011-03-09');
insert into Staff values(114,'Kalp','Vimal','Malhotra',850000,'1988-01-11','Napean sea road, Mumbai',1,'2012-05-09');
insert into Staff values(115,'Shreyans','Amit','Kotak',250000,'1987-02-10','Walkeshwar, Mumbai',10,'2015-02-09');
insert into Staff values(116,'Lesha','Rajesh','Munot',250000,'1986-12-22','Greater Kailash, Chennai',9,'2015-01-05');
insert into Staff values(117,'Yashvi','Nitin','Patel',450000,'1990-11-18','N.M. marg, Banglore',10,'2014-03-06');
insert into Staff values(118,'Akshat','Shailesh','Bohra',350000,'1991-10-27','Cannought palace, Delhi',11,'2014-12-01');
insert into Staff values(119,'Rhythm','Vikram','Jain',750000,'1991-09-18','Bada Bazaar road, Jaipur',12,'2011-11-01');
insert into Staff values(120,'Riddhi','Manish','Siroya',650000,'1992-08-28',' Shivaji Road, Pune',10,'2010-10-19');
insert into Staff values(122,'Rohan','Manish','Siroya',650000,'1992-08-28',' Shivaji Road, Pune',10,'2010-10-19');


insert into Doctor values(100,'cardiologist','chief');
insert into Doctor values(101,'neurologist','resident');
insert into Doctor values(102,'orthologist','resident');
insert into Doctor values(103,'pediatrician','chief');
insert into Doctor values(105,'general','resident');


insert into Record values(600,200,'2010-02-08',109);
insert into Record values(601,205,'2010-03-08',110);
insert into Record values(602,206,'2010-04-08',111);
insert into Record values(603,203,'2010-05-08',109);
insert into Record values(604,202,'2010-06-08',110);
insert into Record values(605,201,'2010-07-08',111);


insert into Receptionist values(109);
insert into Receptionist values(110);
insert into Receptionist values(111);

insert into Accountant values(113);
insert into Accountant values(114);
insert into Accountant values(112);
insert into Accountant values(115);

insert into Medicine values('Cardace','2017-12-15','2015-12-15',101,200);
insert into Medicine values('Cardae','2017-12-15','2015-12-15',101,206);
insert into Medicine values('Aztor 250','2018-10-01','2016-04-01',100,201);
insert into Medicine values('Contiflo','2020-01-10','2016-01-10',100,202);
insert into Medicine values('Levocet','2018-08-15','2015-08-15',100,209);
insert into Medicine values('Levocet 12','2018-08-15','2015-08-15',102,203);
insert into Medicine values('Aztor 25','2018-10-01','2016-04-01',102,204);
insert into Medicine values('Contiflo','2020-01-10','2016-01-10',102,208);
insert into Medicine values('Combiflam 10','2017-10-15','2015-10-15',103,205);
insert into Medicine values('Combiflam','2017-10-15','2015-10-15',103,207);


insert into ROOM values(500,'Lesha',109);
insert into ROOM values(501,'Yashvi',110);
insert into ROOM values(502,'Lesha',111);
insert into ROOM values(503,'Yashvi',109);
insert into ROOM values(504,'Yashvi',110);


insert into Nurse values(118,500);
insert into Nurse values(119,501);

insert into Handles values(112,700);
insert into Handles values(113,701);
insert into Handles values(114,702);

Insert into Laboratory values(400,106);
Insert into Laboratory values(401,107);

insert into Transactions values(700,'2010-02-05','');
insert into Transactions values(701,'2011-03-05','');
insert into Transactions values(702,'2012-05-05','');
insert into Transactions values(703,'2012-05-05','',4,20000);

insert into Laboratorist values (106);
insert into Laboratorist values(107);


Insert into Treats Values(201,100);
Insert into Treats Values(202,100);
Insert into Treats Values(209,100);
Insert into Treats Values(200,101);
Insert into Treats Values(206,101);
Insert into Treats Values(203,102);
Insert into Treats Values(204,102);
Insert into Treats Values(208,102);
Insert into Treats Values(205,103);
Insert into Treats Values(207,103);

    
SELECT 
    *
FROM
    staff
WHERE
    salary > 400000;

SELECT 
    *
FROM
    staff
WHERE
    salary > 440000 AND shifts = 9;


SELECT DISTINCT
    salary
FROM
    staff;

SELECT 
    *
FROM
    staff
WHERE
    fname LIKE 'S%';

alter 
 
 alter table staff drop column mname;


SELECT 
    staff_id, desg
FROM
    Doctor
GROUP BY desg;

SELECT 
    fname, salary, shifts
FROM
    staff
HAVING salary > (SELECT 
        AVG(salary)
    FROM
        staff);
    

SELECT 
    shifts, COUNT(*)
FROM
    staff
GROUP BY shifts;

SELECT 
    FNAME, Lname, address
FROM
    staff
WHERE
    STAFF_ID IN (SELECT 
            staff_id
        FROM
            doctor AS d
        WHERE
            d.staff_id = staff_id);

SELECT 
    fname, lname, salary
FROM
    staff
ORDER BY salary DESC;

SELECT 
    staff_id, fname, lname
FROM
    staff
WHERE
    EXISTS( SELECT 
            staff_id
        FROM
            doctor
        WHERE
            s.staff_id = d.staff_id);

SELECT 
    pid, pfname, plname
FROM
    patient
WHERE
    ro_no IN (501);

SELECT 
    pid, pfname, plname
FROM
    patient
WHERE
    ro_no NOT IN (501);

SELECT 
    *
FROM
    staff
        INNER JOIN
    patient ON fname = doc_incharge;
 
 
SELECT 
    p.pid, p.pfname, p.plname, r.room_no, r.room_incharge
FROM
    patient AS p
        RIGHT OUTER JOIN
    room AS r ON p.ro_no = r.room_no;

SELECT 
    *
FROM
    medicine
        LEFT OUTER JOIN
    doctor ON doc_id = staff_id;
/*
 select * from patient  outer join medicine
    on pid = pat_id;
*/
 
UPDATE staff 

SET 
    salary = 600000
WHERE
    staff_id = 100;   

select * from Patient;


ALTER TABLE Medicine 
ADD Batch_no int ;    

DELETE FROM S_phone_n0
where staff_id = 104;

select * from s_phone_n0;