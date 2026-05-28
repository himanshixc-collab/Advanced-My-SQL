CREATE DATABASE assignH;
USE assignH;

CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
course VARCHAR(50),
fees_paid DECIMAL(10,2),
status VARCHAR(20)
);

CREATE TABLE student_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
action VARCHAR(50),
log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE deleted_students_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
name VARCHAR(50),
course VARCHAR(50),
deleted_at DATETIME
);

INSERT INTO students (name, course, fees_paid, status) VALUES
('Aarav', 'BCA', 45000.00, 'Active'),
('Sneha', 'MBA', 75000.00, 'Active'),
('Rohan', 'BBA', 38000.00, 'Inactive'),
('Priya', 'MCA', 55000.00, 'Active'),
('Karan', 'BSc', 30000.00, 'Inactive');

#1 trigger to log insert activity after a new student is added

DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
INSERT INTO student_log (student_id, action, log_time)
VALUES (NEW.student_id, 'INSERT', NOW());
END //
DELIMITER ;

INSERT INTO students (name, course, fees_paid, status)
VALUES ('Meera', 'BCA', 42000.00, 'Active');

SELECT * FROM student_log;

#2 trigger to log update activity when fees are updated

DELIMITER //
CREATE TRIGGER after_fees_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
IF OLD.fees_paid <> NEW.fees_paid
THEN
INSERT INTO student_log (student_id, action, log_time)
VALUES (OLD.student_id, 'Fees Updated', NOW());
END IF;
END //
DELIMITER ;

UPDATE students SET fees_paid = 50000.00 WHERE student_id = 1;

SELECT * FROM student_log;

#3 trigger to save deleted student details into deleted_students_log

DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
INSERT INTO deleted_students_log (student_id, name, course, deleted_at)
VALUES (OLD.student_id, OLD.name, OLD.course, NOW());
END //
DELIMITER ;

DELETE FROM students WHERE student_id = 3;

SELECT * FROM deleted_students_log;

#4 trigger to automatically increase fees by 10% before inserting a new student

DELIMITER //
CREATE TRIGGER fees_inc
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
SET NEW.fees_paid = NEW.fees_paid * 1.10;
END //
DELIMITER ;

INSERT INTO students (name, course, fees_paid, status)
VALUES ('Anjali', 'MBA', 75000.00, 'Active');

SELECT * FROM students;

#5 trigger to log status update when student status is changed

DELIMITER //
CREATE TRIGGER after_status_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
IF OLD.status <> NEW.status
THEN
INSERT INTO student_log (student_id, action, log_time)
VALUES (OLD.student_id, 'Status Updated', NOW());
END IF;
END //
DELIMITER ;

UPDATE students SET status = 'Inactive' WHERE student_id = 2;

SELECT * FROM student_log;

#6 trigger to log delete activity into student_log after a student is deleted

DELIMITER //
CREATE TRIGGER log_student_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
INSERT INTO student_log (student_id, action, log_time)
VALUES (OLD.student_id, 'Student Deleted', NOW());
END //
DELIMITER ;

DELETE FROM students WHERE student_id = 5;

SELECT * FROM student_log;

#7 show triggers and drop a trigger

SHOW TRIGGERS;

DROP TRIGGER after_student_insert;

#8 trigger to log new admission after insert

DELIMITER //
CREATE TRIGGER log_new_admission
AFTER INSERT ON students
FOR EACH ROW
BEGIN
INSERT INTO student_log (student_id, action, log_time)
VALUES (NEW.student_id, 'New Admission', NOW());
END //
DELIMITER ;

INSERT INTO students (name, course, fees_paid, status)
VALUES ('Rahul', 'BSc', 32000.00, 'Active');

SELECT * FROM student_log;

#9 trigger to prevent inserting negative fees

DELIMITER //
CREATE TRIGGER check_fees_before_insert
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
IF NEW.fees_paid < 0
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Fees cannot be negative!';
END IF;
END //
DELIMITER ;

INSERT INTO students (name, course, fees_paid, status)
VALUES ('Test', 'BCA', -5000.00, 'Active');

SELECT * FROM students;

#10 trigger to automatically set status as Active if left empty before insert

DELIMITER //
CREATE TRIGGER set_default_status
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
IF NEW.status IS NULL OR NEW.status = ''
THEN
SET NEW.status = 'Active';
END IF;
END //
DELIMITER ;

INSERT INTO students (name, course, fees_paid, status)
VALUES ('Simran', 'BBA', 38000.00, '');

SELECT * FROM students;

#11 trigger to prevent fees from being decreased on update

DELIMITER //
CREATE TRIGGER prevent_fees_decrease
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
IF NEW.fees_paid < OLD.fees_paid
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Fees cannot be decreased!';
END IF;
END //
DELIMITER ;

UPDATE students SET fees_paid = 10000.00 WHERE student_id = 1;

SELECT * FROM students;

#12 trigger to log when a student is added as new admission into premium log

CREATE TABLE premium_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
new_course VARCHAR(50),
upgraded_at DATETIME
);

DELIMITER //
CREATE TRIGGER log_premium_upgrade
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
IF NEW.course = 'MBA' AND OLD.course <> 'MBA'
THEN
INSERT INTO premium_log (student_id, new_course, upgraded_at)
VALUES (NEW.student_id, NEW.course, NOW());
END IF;
END //
DELIMITER ;

UPDATE students SET course = 'MBA' WHERE student_id = 1;

SELECT * FROM premium_log;

#13 trigger to log update when student name is changed

DELIMITER //
CREATE TRIGGER after_name_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
IF OLD.name <> NEW.name
THEN
INSERT INTO student_log (student_id, action, log_time)
VALUES (OLD.student_id, 'Name Updated', NOW());
END IF;
END //
DELIMITER ;

UPDATE students SET name = 'Aara' WHERE student_id = 1;

SELECT * FROM student_log;

#14 trigger to log update when student course is changed

DELIMITER //
CREATE TRIGGER after_course_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
IF OLD.course <> NEW.course
THEN
INSERT INTO student_log (student_id, action, log_time)
VALUES (OLD.student_id, 'Course Updated', NOW());
END IF;
END //
DELIMITER ;

UPDATE students SET course = 'BBA' WHERE student_id = 2;

SELECT * FROM student_log;

#15 trigger to log delete activity into student_log after student is removed

DELIMITER //
CREATE TRIGGER after_student_delete2
AFTER DELETE ON students
FOR EACH ROW
BEGIN
INSERT INTO student_log (student_id, action, log_time)
VALUES (OLD.student_id, 'Student Removed', NOW());
END //
DELIMITER ;

DELETE FROM students WHERE student_id = 4;

SELECT * FROM student_log;

SELECT * FROM students;