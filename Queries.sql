USE master
DROP DATABASE Advising_Team_27;
CREATE DATABASE Advising_Team_27;

USE Advising_Team_27;

--------------------------- 2.1 ----------------------------------------

GO

CREATE PROCEDURE CreateAllTables
AS
	CREATE TABLE Advisor(
		advisor_id INT PRIMARY KEY,
		advisor_name VARCHAR(40) NOT NULL,
		email VARCHAR(40) NOT NULL,
		office VARCHAR(40) NOT NULL,
		pass VARCHAR(40) NOT NULL
	);

	CREATE TABLE Student(
		student_id INT PRIMARY KEY, 
		f_name VARCHAR(40) NOT NULL, 
		l_name VARCHAR(40) NOT NULL,
		gpa DECIMAL(3, 2) NOT NULL,
		faculty VARCHAR(40) NOT NULL,
		email VARCHAR(40) NOT NULL,
		major VARCHAR(40) NOT NULL,
		pass VARCHAR(40) NOT NULL,
		financial_status BIT CHECK (financial_status IN (0, 1)) NOT NULL /* 0 MEANS BLOCKED, 1 MEANS UNBLOCKED */,
		semester INT NOT NULL,
		acquired_hours INT NOT NULL,
		assigned_hours INT NOT NULL,
		advisor_id INT NOT NULL,
		FOREIGN KEY (advisor_id) REFERENCES Advisor ON DELETE CASCADE
	);

	CREATE TABLE Student_phone(
		student_id INT NOT NULL,
		phone_number VARCHAR(40) NOT NULL,
		CONSTRAINT phone_id PRIMARY KEY(student_id, phone_number),
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE
	);

	CREATE TABLE Course(
		course_id INT PRIMARY KEY,
		course_name VARCHAR(40) NOT NULL,
		major VARCHAR(40) NOT NULL,
		is_offered BIT NOT NULL,
		credit_hours INT NOT NULL,
		semester INT NOT NULL
	);

	CREATE TABLE preqCourse_course(
		prerequisite_course_id INT NOT NULL,
		course_id INT NOT NULL,
		CONSTRAINT preqCourse_course_id PRIMARY KEY (prerequisite_course_id, course_id),
		FOREIGN KEY (prerequisite_course_id) REFERENCES Course,
		FOREIGN KEY (course_id) REFERENCES Course
	);

	CREATE TABLE Instructor(
		instructor_id INT PRIMARY KEY,
		instructor_name VARCHAR(40) NOT NULL, 
		email VARCHAR(40) NOT NULL,
		faculty VARCHAR(40) NOT NULL,
		office VARCHAR(40) NOT NULL
	);

	CREATE TABLE Instructor_Course(
		course_id INT NOT NULL,
		instructor_id INT NOT NULL,
		CONSTRAINT Instructor_Course_id PRIMARY KEY (course_id, instructor_id),
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE
	);

	CREATE TABLE Student_Instructor_Course_Take(
		student_id INT NOT NULL,
		course_id  INT NOT NULL,
		instructor_id INT NOT NULL,
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
		course_id INT NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		CONSTRAINT Course_Semester_id PRIMARY KEY (course_id, semester_code),
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (semester_code) REFERENCES Semester ON DELETE CASCADE
	);

	CREATE TABLE Slot(
		slot_id INT PRIMARY KEY,
		slot_day VARCHAR(40) NOT NULL,
		slot_time VARCHAR(40) NOT NULL,
		slot_location VARCHAR(40) NOT NULL,
		course_id INT NOT NULL,
		instructor_id INT NOT NULL,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE
	);

	CREATE TABLE Graduation_Plan(
		plan_id INT NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		semester_credit_hours INT NOT NULL,
		expected_grad_semester VARCHAR(40) NOT NULL,
		advisor_id INT NOT NULL,
		student_id INT NOT NULL,
		CONSTRAINT Graduation_plan_id PRIMARY KEY (plan_id, semester_code),
		FOREIGN KEY (advisor_id) REFERENCES Advisor,
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE
	);

	CREATE TABLE GradPlan_Course(
		plan_id INT NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		course_id INT NOT NULL,
		CONSTRAINT GradPlan_Course_id PRIMARY KEY (plan_id, semester_code, course_id),
		FOREIGN KEY (plan_id, semester_code) REFERENCES Graduation_Plan ON DELETE CASCADE,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE
	);

	CREATE TABLE Request(
		request_id INT PRIMARY KEY,
		req_type VARCHAR(40) NOT NULL,
		comment VARCHAR(40) NOT NULL,
		req_status VARCHAR(40) NOT NULL CHECK (req_status IN ('pending', 'accepted', 'rejected')) DEFAULT 'pending',
		credit_hours INT NOT NULL,
		student_id INT NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		advisor_id INT NOT NULL FOREIGN KEY REFERENCES Advisor,
		course_id INT NOT NULL FOREIGN KEY REFERENCES Course ON DELETE CASCADE,
	);

	CREATE TABLE MakeUp_Exam(
		exam_id INT PRIMARY KEY,
		mk_exam_date date NOT NULL,
		mk_exam_type VARCHAR(40) NOT NULL,
		course_id INT NOT NULL FOREIGN KEY REFERENCES Course ON DELETE CASCADE,
	);

	CREATE TABLE Exam_Student(
		exam_id INT NOT NULL FOREIGN KEY REFERENCES MakeUp_Exam ON DELETE CASCADE,
		student_id INT NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		course_id INT NOT NULL FOREIGN KEY REFERENCES Course,
		CONSTRAINT Exam_Student_id PRIMARY KEY (exam_id, student_id)
	);

	CREATE TABLE Payment(
		payment_id INT PRIMARY KEY,
		payment_amount INT NOT NULL,
		payment_deadline datetime NOT NULL,
		n_installments INT NOT NULL,
		payment_status VARCHAR(40) NOT NULL CHECK (payment_status IN ('notPaid', 'Paid')) DEFAULT 'notPaid',
		fund_percentage DECIMAL(3,2) NOT NULL,
		s_date datetime NOT NULL,
		student_id INT NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		semester_code VARCHAR(40) NOT NULL FOREIGN KEY REFERENCES Semester ON DELETE CASCADE,
	);

	CREATE TABLE Installment(
		payment_id INT NOT NULL FOREIGN KEY REFERENCES Payment ON DELETE CASCADE,
		deadline datetime NOT NULL,
		inst_amount INT NOT NULL,
		inst_status VARCHAR(40) NOT NULL,
		inst_start_date datetime NOT NULL,
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

--------------------------- 2.2 A ----------------------------------------
GO

CREATE VIEW view_Students
AS
SELECT *
FROM Student
WHERE Student.financial_status = 1

--------------------------- 2.2 B ----------------------------------------
GO

CREATE VIEW view_Course_prerequisites AS
SELECT cr.*, pr.prerequisite_course_id
FROM Course cr LEFT OUTER JOIN preqCourse_course pr
ON cr.course_id = pr.course_id

--------------------------- 2.2 C ----------------------------------------
GO

CREATE VIEW Instructors_AssignedCourses AS
SELECT ic.course_id, i.*
FROM Instructor_course ic, Instructor i
WHERE ic.instructor_id = i.instructor_id

--------------------------- 2.2 D ----------------------------------------
GO

CREATE VIEW Student_Payment AS 
SELECT s.*, p.fund_percentage, p.n_installments, p.payment_amount, p.payment_deadline, p.payment_id, p.payment_status, p.s_date, p.semester_code
FROM Payment p, Student s
WHERE p.student_id = s.student_id

--------------------------- 2.2 E ----------------------------------------
GO

CREATE VIEW Courses_Slots_Instructor  AS
SELECT i.instructor_name, cr.course_name, sl.*
FROM Course cr, Slot sl, Instructor i
WHERE cr.course_id = sl.course_id AND sl.instructor_id = i.instructor_id

--------------------------- 2.2 F ----------------------------------------
GO

CREATE VIEW Courses_MakeupExams AS
SELECT cr.course_name, cr.semester, mx.*
FROM Course cr, MakeUp_Exam mx 
WHERE cr.course_id = mx.exam_id

--------------------------- 2.2 G ----------------------------------------
GO

CREATE VIEW Students_Courses_transcript AS
SELECT s.student_id, st.f_name, st.l_name, s.course_id, co.course_name, s.exam_type, s.grade, s.semester_code, ins.instructor_name
FROM Student_Instructor_Course_Take s, Student st, Course co, Instructor ins
WHERE s.student_id = st.student_id AND s.course_id = co.course_id AND s.instructor_id = ins.instructor_id

--------------------------- 2.2 H ----------------------------------------
GO

CREATE VIEW Semster_offered_Courses AS
SELECT cs.course_id, co.course_name, cs.semester_code
FROM Course_Semester cs, Course co
WHERE cs.course_id = co.course_id

--------------------------- 2.2 I ----------------------------------------
GO

CREATE VIEW Advisors_Graduation_Plan AS
SELECT gp.*, a.advisor_name
FROM Graduation_Plan gp, Advisor a
WHERE gp.advisor_id = a.advisor_id;
GO

--------------------------- 2.3 D ----------------------------------------
CREATE PROCEDURE Procedures_AdminListAdvisors

AS    
    Select *
    From Advisor;

GO

EXEC Procedures_AdminListAdvisors

GO
--------------------------- 2.3 E ----------------------------------------
CREATE PROCEDURE AdminListStudentsWithAdvisors

AS    
    Select *
    From Student s, Advisor a
    where s.advisor_id=a.advisor_id

GO

EXEC AdminListStudentsWithAdvisors

GO
--------------------------- 2.3 H ----------------------------------------
GO

CREATE PROCEDURE Procedures_AdminLinkInstructor
    @instructor_id INT,
    @course_id INT,
    @slot_id INT

AS
    INSERT INTO Instructor_Course (instructor_id, course_id)
    SELECT @instructor_id, @course_id
    FROM Courses_Slots_Instructor
    WHERE course_id = @course_id
      AND slot_id = @slot_id
      AND instructor_name = (SELECT instructor_name FROM Instructor WHERE instructor_id = @instructor_id);

GO

EXEC Procedures_AdminLinkInstructor

GO

--------------------------- 2.3 O ----------------------------------------
CREATE VIEW all_Pending_Requests 

AS
	SELECT r.*, s.f_name, s.l_name, a.advisor_name 
	FROM Request r INNER JOIN Student s on s.student_id=r.student_id INNER JOIN Advisor a on a.advisor_id = r.advisor_id
	WHERE req_status='pending'
Go

--------------------------- 2.3 X ----------------------------------------

CREATE PROCEDURE Procedures_AdvisorViewAssignedStudents
@advisor_id int,
@major varchar(40)
AS    
    Select sct.student_id, sct.f_name, sct.l_name, s.major, sct.course_name
    From Students_Courses_transcript sct, Student s 
    where sct.student_id=s.student_id AND s.major=@major AND s.advisor_id=@advisor_id

GO

EXEC Procedures_AdvisorViewAssignedStudents

GO

