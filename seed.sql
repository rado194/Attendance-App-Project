CREATE DATABASE  attendance_app;

DROP TABLE IF EXISTS student_attendance;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS attendance_status;
DROP TABLE IF EXISTS courses;

CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  start_date DATE,
  end_date DATE,
  course_type VARCHAR(15)
);

CREATE TABLE attendance_status (
  attendance_status_id SERIAL PRIMARY KEY,
  status VARCHAR(30),
  colour_code VARCHAR(15)
);

CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  course_id INT,
  FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

CREATE TABLE student_attendance (
  student_attendance_id SERIAL PRIMARY KEY,
  attendance_date DATE default now(),
  student_id INT,
  FOREIGN KEY(student_id) REFERENCES students(student_id),
  attendance_status_id INT, FOREIGN KEY(attendance_status_id) REFERENCES attendance_status(attendance_status_id),
  description VARCHAR(100)
);


INSERT INTO courses(name, start_date, end_date, course_type) VALUES ('Needs assignment','2019/05/13','2019/10/04','Unassigned');
INSERT INTO courses(name, start_date, end_date, course_type) VALUES ('Eng-30','2019/04/01', '2019/06/28','Engineering');
INSERT INTO courses(name, start_date, end_date, course_type) VALUES ('Busi-26','2019/05/13','2019/07/05','Business');



INSERT INTO attendance_status(status, colour_code) VALUES ('On Time', 'forestgreen');
INSERT INTO attendance_status(status, colour_code) VALUES ('Less than 5 mins late', '#ffff59');
INSERT INTO attendance_status(status, colour_code) VALUES ('More than 5 mins late', '#ffc04d');
INSERT INTO attendance_status(status, colour_code) VALUES ('Absent', 'red');
INSERT INTO attendance_status(status, colour_code) VALUES ('Authorised Absence', '#b3dbff');

INSERT INTO students(first_name, last_name, course_id) VALUES ('Joel','Mcnamara','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Matthew','Murphy','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Patrick','Daneshyar','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Radoslav','Shtarkov','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Isharq','Hussain','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Jake','Brown','2');

INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Bob','3');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Steve','3');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Phil','3');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Ryan','3');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Terrance','3');



INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','1','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','2','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','3','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','4','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','5','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','6','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','7','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','8','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','9','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','10','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','11','1','');

INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','1','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','2','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','3','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','4','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','5','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','6','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','7','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','8','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','9','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','10','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','11','2','');

INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','1','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','2','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','3','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','4','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','5','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','6','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','7','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','8','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','9','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','10','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/15','11','2','');
