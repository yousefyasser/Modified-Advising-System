USE master
DROP DATABASE Advising_Team_27;
CREATE DATABASE Advising_Team_27;

USE Advising_Team_27;

--------------------------- 2.1 ----------------------------------------

GO

CREATE PROCEDURE CreateAllTables
AS
	CREATE TABLE Advisor(
		advisor_id VARCHAR(40) PRIMARY KEY,
		advisor_name VARCHAR(40) NOT NULL,
		email VARCHAR(40) NOT NULL,
		office VARCHAR(40) NOT NULL,
		pass VARCHAR(40) NOT NULL
	);

	CREATE TABLE Student(
		student_id VARCHAR(40) PRIMARY KEY, 
		f_name VARCHAR(40) NOT NULL, 
		l_name VARCHAR(40) NOT NULL,
		gpa DECIMAL(3, 2) NOT NULL,
		faculty VARCHAR(40) NOT NULL,
		email VARCHAR(40) NOT NULL,
		major VARCHAR(40) NOT NULL,
		pass VARCHAR(40) NOT NULL,
		financial_status BIT NOT NULL /* 0 MEANS BLOCKED, 1 MEANS UNBLOCKED */,
		semester INT NOT NULL,
		acquired_hours INT NOT NULL,
		assigned_hours INT NOT NULL,
		advisor_id VARCHAR(40) NOT NULL,
		FOREIGN KEY (advisor_id) REFERENCES Advisor ON DELETE CASCADE
	);

	CREATE TABLE Student_phone(
		student_id VARCHAR(40) NOT NULL,
		phone_number VARCHAR(40) NOT NULL,
		CONSTRAINT phone_id PRIMARY KEY(student_id, phone_number),
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE
	);

	CREATE TABLE Course(
		course_id VARCHAR(40) PRIMARY KEY,
		course_name VARCHAR(40) NOT NULL,
		major VARCHAR(40) NOT NULL,
		is_offered BIT NOT NULL,
		credit_hours INT NOT NULL,
		semester INT NOT NULL
	);

	CREATE TABLE preqCourse_course(
		prerequisite_course_id VARCHAR(40) NOT NULL,
		course_id VARCHAR(40) NOT NULL,
		CONSTRAINT preqCourse_course_id PRIMARY KEY (prerequisite_course_id, course_id),
		FOREIGN KEY (prerequisite_course_id) REFERENCES Course,
		FOREIGN KEY (course_id) REFERENCES Course
	);

	CREATE TABLE Instructor(
		instructor_id VARCHAR(40) PRIMARY KEY,
		instructor_name VARCHAR(40) NOT NULL, 
		email VARCHAR(40) NOT NULL,
		faculty VARCHAR(40) NOT NULL,
		office VARCHAR(40) NOT NULL
	);

	CREATE TABLE Instructor_Course(
		course_id VARCHAR(40) NOT NULL,
		instructor_id VARCHAR(40) NOT NULL,
		CONSTRAINT Instructor_Course_id PRIMARY KEY (course_id, instructor_id),
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE
	);

	CREATE TABLE Student_Instructor_Course_Take(
		student_id VARCHAR(40) NOT NULL,
		course_id  VARCHAR(40) NOT NULL,
		instructor_id VARCHAR(40) NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		exam_type VARCHAR(40)  CHECK (exam_type IN ('Normal', 'First_makeup', 'Second_makeup')) DEFAULT 'Normal',
		grade VARCHAR(40),
		CONSTRAINT Student_Instructor_Course_Take_id PRIMARY KEY (student_id, course_id, instructor_id),
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE
	);

	CREATE TABLE Semester(
		semester_code VARCHAR(40) PRIMARY KEY,
		s_date date NOT NULL,
		end_date date NOT NULL
	);

	CREATE TABLE Course_Semester(
		course_id VARCHAR(40) NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		CONSTRAINT Course_Semester_id PRIMARY KEY (course_id, semester_code),
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (semester_code) REFERENCES Semester ON DELETE CASCADE
	);

	CREATE TABLE Slot(
		slot_id VARCHAR(40) PRIMARY KEY,
		slot_day VARCHAR(40) NOT NULL,
		slot_time datetime NOT NULL,
		slot_location VARCHAR(40) NOT NULL,
		course_id VARCHAR(40) NOT NULL,
		instructor_id VARCHAR(40) NOT NULL,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE
	);

	CREATE TABLE Graduation_Plan(
		plan_id VARCHAR(40) NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		semester_credit_hours INT NOT NULL,
		expected_grad_semester INT NOT NULL,
		advisor_id VARCHAR(40) NOT NULL,
		student_id VARCHAR(40) NOT NULL,
		CONSTRAINT Graduation_plan_id PRIMARY KEY (plan_id, semester_code),
		FOREIGN KEY (advisor_id) REFERENCES Advisor,
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE
	);

	CREATE TABLE GradPlan_Course(
		plan_id VARCHAR(40) NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		course_id VARCHAR(40) NOT NULL,
		CONSTRAINT GradPlan_Course_id PRIMARY KEY (plan_id, semester_code, course_id),
		FOREIGN KEY (plan_id, semester_code) REFERENCES Graduation_Plan ON DELETE CASCADE,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE
	);

	CREATE TABLE Request(
		request_id VARCHAR(40) PRIMARY KEY,
		req_type VARCHAR(40) NOT NULL,
		comment VARCHAR(40) NOT NULL,
		req_status VARCHAR(40) NOT NULL CHECK (req_status IN ('pending', 'accepted', 'rejected')) DEFAULT 'pending',
		credit_hours INT NOT NULL,
		student_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		advisor_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Advisor,
		course_id VARCHAR(40) NOT NULL,
	);

	CREATE TABLE MakeUp_Exam(
		exam_id VARCHAR(40) PRIMARY KEY,
		mk_exam_date date NOT NULL,
		mk_exam_type VARCHAR(40) NOT NULL,
		course_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Course ON DELETE CASCADE,
	);

	CREATE TABLE Exam_Student(
		exam_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES MakeUp_Exam ON DELETE CASCADE,
		student_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		course_id VARCHAR(40) NOT NULL,
		CONSTRAINT Exam_Student_id PRIMARY KEY (exam_id, student_id)
	);

	CREATE TABLE Payment(
		payment_id VARCHAR(40) PRIMARY KEY,
		payment_amount INT NOT NULL,
		payment_deadline date NOT NULL,
		n_installments INT NOT NULL,
		payment_status BIT CHECK (payment_status IN ('notPaid', 'Paid')) DEFAULT 'notPaid',
		fund_percentage DECIMAL(3,2) NOT NULL,
		student_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		semester_code VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Semester ON DELETE CASCADE,
		s_date date NOT NULL,

	);

	CREATE TABLE Installment(
		payment_id VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Payment ON DELETE CASCADE,
		deadline date NOT NULL,
		inst_amount INT NOT NULL,
		inst_status BIT NOT NULL,
		inst_date date NOT NULL,
		CONSTRAINT Pk_installment PRIMARY KEY (payment_id,deadline)
	);

GO

EXEC CreateAllTables;

GO

CREATE PROCEDURE DropAllTables 
AS 
	DROP TABLE  Installment
	DROP TABLE  Payment
	DROP TABLE  Exam_Student
	DROP TABLE  Request
	DROP TABLE  GradPlan_Course
	DROP TABLE  Graduation_Plan
	DROP TABLE  Student_Instructor_Course_Take
	DROP TABLE  Student_phone
	DROP TABLE  Student
	DROP TABLE  Advisor
	DROP TABLE  Slot
	DROP TABLE  MakeUp_Exam
	DROP TABLE  Course_Semester
	DROP TABLE  Instructor_Course
	DROP TABLE  PreqCourse_course
	DROP TABLE  Course
	DROP TABLE  Instructor
	DROP TABLE  Semester

GO

EXEC DropAllTables;

GO

CREATE PROCEDURE clearAllTables
AS
	DELETE FROM Installment
	DELETE FROM Payment
	DELETE FROM Installment
	DELETE FROM Payment
	DELETE FROM Exam_Student
	DELETE FROM Request
	DELETE FROM GradPlan_Course
	DELETE FROM Graduation_Plan
	DELETE FROM Student_Instructor_Course_Take
	DELETE FROM Student_phone
	DELETE FROM Student
	DELETE FROM Advisor
	DELETE FROM Slot
	DELETE FROM MakeUp_Exam
	DELETE FROM Course_Semester
	DELETE FROM Instructor_Course
	DELETE FROM PreqCourse_course
	DELETE FROM Course
	DELETE FROM Instructor
	DELETE FROM Semester

GO

EXEC clearAllTables;

--------------------------- 2.2 I ----------------------------------------

GO

CREATE VIEW Advisors_Graduation_Plan AS
SELECT gp.*, a.advisor_name
FROM Graduation_Plan gp, Advisor a
WHERE gp.advisor_id = a.advisor_id;

GO

--------------------------- dummy data ---------------------------------

INSERT INTO Advisor (advisor_id, advisor_name, email, office, pASs) VALUES
('A001', 'John Smith', 'john@example.com', 'Office1', 'password1'),
('A002', 'Sarah Adams', 'sarah@example.com', 'Office2', 'password2'),
('A003', 'Lisa Johnson', 'lisa@example.com', 'Office3', 'password3'),
('A004', 'James Brown', 'james@example.com', 'Office4', 'password4'),
('A005', 'Emily Davis', 'emily@example.com', 'Office5', 'password5'),
('A006', 'Michael Lee', 'michael@example.com', 'Office6', 'password6');

INSERT INTO Course (course_id, course_name, major, is_offered, credit_hours, semester)
VALUES 
    ('CSCI101', 'Introduction to Computer Science', 'Computer Science', 1, 3, 1),
    ('MATH202', 'Calculus II', 'Mathematics', 0, 4, 2),
    ('ENG101', 'English Composition', 'English', 1, 3, 1),
    ('CHEM201', 'Organic Chemistry', 'Chemistry', 1, 4, 3),
    ('PHYS101', 'Physics I', 'Physics', 1, 4, 1);

INSERT INTO preqCourse_course (prerequisite_course_id, course_id)
VALUES ('CSC101', 'CSC201'),
       ('MATH101', 'MATH201'),
       ('PHY101', 'PHY201'),
       ('CHEM101', 'CHEM201');

INSERT INTO Student (student_id, f_name, l_name, gpa, faculty, email, major, pass, financial_status, semester, acquired_hours, assigned_hours, advisor_id)
VALUES 
('S001', 'John', 'Doe', 3.75, 'Science', 'johndoe@example.com', 'Biology', 'password123', 1, 2, 12, 12, 'A001'),
('S002', 'Jane', 'Smith', 3.95, 'Arts', 'janesmith@example.com', 'History', 'pass123', 0, 2, 15, 12, 'A002'),
('S003', 'Robert', 'Johnson', 3.25, 'Engineering', 'robertjohnson@example.com', 'Computer Science', 'test123', 1, 3, 18, 12, 'A002'),
('S004', 'Emily', 'Davis', 3.85, 'Business', 'emilydavis@example.com', 'Finance', 'dummy123', 0, 3, 20, 12, 'A001');

INSERT INTO Student_phone (student_id, phone_number)
VALUES ('S001', '1234567890'),
       ('S002', '9876543210'),
       ('S003', '5555555555'),
       ('S004', '9999999999');

INSERT INTO Instructor (instructor_id, instructor_name, email, faculty, office) VALUES
('I001', 'John Smith', 'john.smith@example.com', 'Computer Science', 'Building A, Office 101'),
('I002', 'Emily Johnson', 'emily.johnson@example.com', 'Mathematics', 'Building B, Office 202'),
('I003', 'Michael Davis', 'michael.davis@example.com', 'English Literature', 'Building C, Office 303'),
('I004', 'Sarah Wilson', 'sarah.wilson@example.com', 'Physics', 'Building D, Office 404'),
('I005', 'David Brown', 'david.brown@example.com', 'Chemistry', 'Building E, Office 505');

INSERT INTO Instructor_Course (course_id, instructor_id)
VALUES 
  ('C001', 'I001'),
  ('C002', 'I001'),
  ('C003', 'I002'),
  ('C004', 'I003'),
  ('C005', 'I002');