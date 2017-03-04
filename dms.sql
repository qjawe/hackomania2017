--  Sample employee database 
--  See changelog table for details
--  Copyright (C) 2007,2008, MySQL AB
--  
--  Original data created by Fusheng Wang and Carlo Zaniolo
--  http://www.cs.aau.dk/TimeCenter/software.htm
--  http://www.cs.aau.dk/TimeCenter/Data/employeeTemporalDataSet.zip
-- 
--  Current schema by Giuseppe Maxia 
--  Data conversion from XML to relational by Patrick Crews
-- 
-- This work is licensed under the 
-- Creative Commons Attribution-Share Alike 3.0 Unported License. 
-- To view a copy of this license, visit 
-- http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to 
-- Creative Commons, 171 Second Street, Suite 300, San Francisco, 
-- California, 94105, USA.
-- 
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.
-- 

DROP DATABASE IF EXISTS employees;
CREATE DATABASE IF NOT EXISTS employees;
USE employees;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

   set storage_engine = InnoDB;
-- set storage_engine = MyISAM;
-- set storage_engine = Falcon;
-- set storage_engine = PBXT;
-- set storage_engine = Maria;

select CONCAT('storage engine: ', @@storage_engine) as INFO;

CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   dept_no      CHAR(4)         NOT NULL,
   emp_no       INT             NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   KEY         (emp_no),
   KEY         (dept_no),
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    KEY         (emp_no),
    KEY         (dept_no),
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    KEY         (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
); 

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    KEY         (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
); 


/* 
--  Data dump for Bala's cloud deployment session
*/

/*
-- Query: SELECT * FROM employees.departments
-- Date: 2017-03-02 15:35
*/
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d009','Customer Service5');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d005','Development');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d002','Finance');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d003','Human Resources');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d001','Marketing');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d004','Production');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d006','Quality Management');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d008','Research');
INSERT INTO `departments` (`dept_no`,`dept_name`) VALUES ('d007','Sales2');

/*
-- Query: SELECT * FROM employees.employees where emp_no = "110022" OR emp_no = "110039" OR emp_no = "110085" OR emp_no = "110114" OR emp_no = "10006" OR emp_no = "10007" OR emp_no = "10032"
-- Date: 2017-03-02 16:33
*/
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (10032,'1960-08-09','Jeong','Reistad','F','1990-06-20');
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (110022,'1956-09-12','Margareta','Markovitch','M','1985-01-01');
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (110039,'1963-06-21','Vishwani','Minakawa','M','1986-04-12');
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (110085,'1959-10-28','Ebru','Alpin','M','1985-01-01');
INSERT INTO `employees` (`emp_no`,`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`) VALUES (110114,'1957-03-28','Isamu','Legleitner','F','1985-01-14');



/*
-- Query: SELECT * FROM employees.salaries where emp_no = "110022" OR emp_no = "110039" OR emp_no = "110085" OR emp_no = "110114" OR emp_no = "10006" OR emp_no = "10007" OR emp_no = "10032"
-- Date: 2017-03-02 16:37
*/
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,40000,'1990-08-05','1991-08-05');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,42085,'1991-08-05','1992-08-04');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,42629,'1992-08-04','1993-08-04');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,45844,'1993-08-04','1994-08-04');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,47518,'1994-08-04','1995-08-04');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,47917,'1995-08-04','1996-08-03');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,52255,'1996-08-03','1997-08-03');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,53747,'1997-08-03','1998-08-03');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,56032,'1998-08-03','1999-08-03');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,58299,'1999-08-03','2000-08-02');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,60098,'2000-08-02','2001-08-02');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10006,59755,'2001-08-02','9999-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,56724,'1989-02-10','1990-02-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,60740,'1990-02-10','1991-02-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,62745,'1991-02-10','1992-02-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,63475,'1992-02-10','1993-02-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,63208,'1993-02-09','1994-02-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,64563,'1994-02-09','1995-02-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,68833,'1995-02-09','1996-02-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,70220,'1996-02-09','1997-02-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,73362,'1997-02-08','1998-02-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,75582,'1998-02-08','1999-02-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,79513,'1999-02-08','2000-02-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,80083,'2000-02-08','2001-02-07');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,84456,'2001-02-07','2002-02-07');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10007,88070,'2002-02-07','9999-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,48426,'1990-06-20','1991-06-20');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,49389,'1991-06-20','1992-06-19');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,52000,'1992-06-19','1993-06-19');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,53038,'1993-06-19','1994-06-19');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,54336,'1994-06-19','1995-06-19');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,53978,'1995-06-19','1996-06-18');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,55090,'1996-06-18','1997-06-18');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,57110,'1997-06-18','1998-06-18');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,57926,'1998-06-18','1999-06-18');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,57876,'1999-06-18','2000-06-17');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,61709,'2000-06-17','2001-06-17');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,65820,'2001-06-17','2002-06-17');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (10032,69539,'2002-06-17','9999-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,71166,'1985-01-01','1986-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,71820,'1986-01-01','1987-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,72970,'1987-01-01','1988-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,76211,'1988-01-01','1988-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,78443,'1988-12-31','1989-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,81784,'1989-12-31','1990-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,82871,'1990-12-31','1991-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,86797,'1991-12-31','1992-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,89204,'1992-12-30','1993-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,92165,'1993-12-30','1994-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,94286,'1994-12-30','1995-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,96647,'1995-12-30','1996-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,97604,'1996-12-29','1997-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,98843,'1997-12-29','1998-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,100014,'1998-12-29','1999-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,100592,'1999-12-29','2000-12-28');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,104485,'2000-12-28','2001-12-28');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110022,108407,'2001-12-28','9999-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,69941,'1986-04-12','1987-04-12');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,71574,'1987-04-12','1988-04-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,73553,'1988-04-11','1989-04-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,75124,'1989-04-11','1990-04-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,78405,'1990-04-11','1991-04-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,81872,'1991-04-11','1992-04-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,83722,'1992-04-10','1993-04-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,85016,'1993-04-10','1994-04-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,85421,'1994-04-10','1995-04-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,88503,'1995-04-10','1996-04-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,92469,'1996-04-09','1997-04-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,94250,'1997-04-09','1998-04-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,95993,'1998-04-09','1999-04-09');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,100350,'1999-04-09','2000-04-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,101901,'2000-04-08','2001-04-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,104115,'2001-04-08','2002-04-08');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110039,106491,'2002-04-08','9999-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,60026,'1985-01-01','1986-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,61808,'1986-01-01','1987-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,62003,'1987-01-01','1988-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,64775,'1988-01-01','1988-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,65105,'1988-12-31','1989-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,66790,'1989-12-31','1990-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,67827,'1990-12-31','1991-12-31');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,68195,'1991-12-31','1992-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,70253,'1992-12-30','1993-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,72727,'1993-12-30','1994-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,72335,'1994-12-30','1995-12-30');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,75173,'1995-12-30','1996-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,79066,'1996-12-29','1997-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,79152,'1997-12-29','1998-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,83440,'1998-12-29','1999-12-29');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,85394,'1999-12-29','2000-12-28');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,88298,'2000-12-28','2001-12-28');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110085,88443,'2001-12-28','9999-01-01');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,52070,'1985-01-14','1986-01-14');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,55297,'1986-01-14','1987-01-14');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,55767,'1987-01-14','1988-01-14');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,58800,'1988-01-14','1989-01-13');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,62669,'1989-01-13','1990-01-13');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,62593,'1990-01-13','1991-01-13');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,63447,'1991-01-13','1992-01-13');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,67322,'1992-01-13','1993-01-12');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,67761,'1993-01-12','1994-01-12');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,68166,'1994-01-12','1995-01-12');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,71652,'1995-01-12','1996-01-12');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,71375,'1996-01-12','1997-01-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,75708,'1997-01-11','1998-01-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,79782,'1998-01-11','1999-01-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,79679,'1999-01-11','2000-01-11');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,80423,'2000-01-11','2001-01-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,82594,'2001-01-10','2002-01-10');
INSERT INTO `salaries` (`emp_no`,`salary`,`from_date`,`to_date`) VALUES (110114,83457,'2002-01-10','9999-01-01');


/*
-- Query: SELECT * FROM employees.titles where emp_no = "110022" OR emp_no = "110039" OR emp_no = "110085" OR emp_no = "110114" OR emp_no = "10006" OR emp_no = "10007" OR emp_no = "10032"
-- Date: 2017-03-02 16:37
*/
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (10006,'Senior Engineer','1990-08-05','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (10007,'Senior Staff','1996-02-11','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (10007,'Staff','1989-02-10','1996-02-11');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (10032,'Engineer','1990-06-20','1995-06-20');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (10032,'Senior Engineer','1995-06-20','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110022,'Manager','1985-01-01','1991-10-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110022,'Senior Staff','1991-10-01','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110039,'Manager','1991-10-01','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110039,'Senior Staff','1986-04-12','1991-10-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110085,'Manager','1985-01-01','1989-12-17');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110085,'Senior Staff','1989-12-17','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110114,'Manager','1989-12-17','9999-01-01');
INSERT INTO `titles` (`emp_no`,`title`,`from_date`,`to_date`) VALUES (110114,'Senior Staff','1985-01-14','1989-12-17');


/*
-- Query: SELECT * FROM employees.dept_emp where emp_no = "110022" OR emp_no = "110039" OR emp_no = "110085" OR emp_no = "110114" OR emp_no = "10006" OR emp_no = "10007" OR emp_no = "10032"
-- Date: 2017-03-02 16:35
*/
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (10006,'d005','1990-08-05','9999-01-01');
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (10007,'d008','1989-02-10','9999-01-01');
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (10032,'d004','1990-06-20','9999-01-01');
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110022,'d001','1985-01-01','9999-01-01');
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110039,'d001','1986-04-12','9999-01-01');
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110085,'d002','1985-01-01','9999-01-01');
INSERT INTO `dept_emp` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110114,'d002','1985-01-14','9999-01-01');


/*
-- Query: SELECT * FROM employees.dept_manager
-- Date: 2017-03-02 15:34
*/
INSERT INTO `dept_manager` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110022,'d001','1985-01-01','1991-10-01');
INSERT INTO `dept_manager` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110039,'d001','1991-10-01','9999-01-01');
INSERT INTO `dept_manager` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110085,'d002','1985-01-01','1989-12-17');
INSERT INTO `dept_manager` (`emp_no`,`dept_no`,`from_date`,`to_date`) VALUES (110114,'d002','1989-12-17','9999-01-01');
