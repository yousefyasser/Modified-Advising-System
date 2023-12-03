USE master
GO

CREATE DATABASE Advising_Team_27;
GO

USE Advising_Team_27;
GO

--------------------------- 2.1 ----------------------------------------

CREATE FUNCTION checkStudentStatus (@student_id INT)
RETURNS BIT

AS
	BEGIN
		DECLARE @result BIT

		IF EXISTS (SELECT * 
			FROM Student s 
			INNER JOIN Payment p on s.student_id = @student_id AND s.student_id = p.student_id 
			INNER JOIN Installment i on p.payment_id = i.payment_id
			AND i.status = 'notPaid' AND i.deadline < CURRENT_TIMESTAMP)
			SET @result = 0
		ELSE 
			SET @result = 1

		RETURN @result
	END
GO

CREATE PROCEDURE CreateAllTables
AS
	CREATE TABLE Advisor(
		advisor_id INT PRIMARY KEY IDENTITY,
		name VARCHAR(40),
		email VARCHAR(40),
		office VARCHAR(40),
		password VARCHAR(40)
	);

	CREATE TABLE Student(
		student_id INT PRIMARY KEY IDENTITY, 
		f_name VARCHAR(40), 
		l_name VARCHAR(40),
		gpa DECIMAL(3, 2) ,
		faculty VARCHAR(40),
		email VARCHAR(40),
		major VARCHAR(40),
		password VARCHAR(40),
		financial_status BIT DEFAULT 1 /* 0 MEANS BLOCKED, 1 MEANS UNBLOCKED */,
		semester INT,
		acquired_hours INT,
		assigned_hours INT, 
		advisor_id INT,
		FOREIGN KEY (advisor_id) REFERENCES Advisor,
		CHECK (financial_status IN (0, 1)),
		CHECK (gpa IS NULL OR (gpa BETWEEN 0.70 AND 5.00)),
		CHECK (assigned_hours IS NULL OR (assigned_hours BETWEEN 0 AND 34)),
		CHECK (acquired_hours IS NULL OR (acquired_hours >= 34))
	);

	CREATE TABLE Student_phone(
		student_id INT,
		phone_number VARCHAR(40),
		CONSTRAINT Pk_Phone PRIMARY KEY(student_id, phone_number),
		FOREIGN KEY (student_id) REFERENCES Student
	);

	CREATE TABLE Course(
		course_id INT PRIMARY KEY IDENTITY,
		name VARCHAR(40),
		major VARCHAR(40),
		is_offered BIT CHECK (is_offered IN (0, 1)) /* 0 MEANS OFFERED, 1 MEANS NOT OFFERED Current Sem */,
		credit_hours INT,
		semester INT
	);

	CREATE TABLE PreqCourse_course(
		prerequisite_course_id INT,
		course_id INT,
		CONSTRAINT preqCourse_course_id PRIMARY KEY (prerequisite_course_id, course_id),
		FOREIGN KEY (prerequisite_course_id) REFERENCES Course,
		FOREIGN KEY (course_id) REFERENCES Course
	);

	CREATE TABLE Instructor(
		instructor_id INT PRIMARY KEY IDENTITY,
		name VARCHAR(40), 
		email VARCHAR(40),
		faculty VARCHAR(40),
		office VARCHAR(40)
	);

	CREATE TABLE Instructor_Course(
		course_id INT,
		instructor_id INT,
		CONSTRAINT Instructor_Course_id PRIMARY KEY (course_id, instructor_id),
		FOREIGN KEY (course_id) REFERENCES Course,
		FOREIGN KEY (instructor_id) REFERENCES Instructor
	);

	CREATE TABLE Semester(
		semester_code VARCHAR(40) PRIMARY KEY,
		start_date date,
		end_date date
	);

	CREATE TABLE Student_Instructor_Course_Take(
		student_id INT,
		course_id  INT,
		instructor_id INT,
		semester_code VARCHAR(40),
		exam_type VARCHAR(40) CHECK (exam_type IN ('Normal', 'First_makeup', 'Second_makeup')) DEFAULT 'Normal',
		grade VARCHAR(40),
		CONSTRAINT Student_Instructor_Course_Take_id PRIMARY KEY (student_id, course_id, semester_code),
		FOREIGN KEY (student_id) REFERENCES Student,
		FOREIGN KEY (course_id) REFERENCES Course,
		FOREIGN KEY (instructor_id) REFERENCES Instructor,
		FOREIGN KEY (semester_code) REFERENCES Semester
	);

	CREATE TABLE Course_Semester(
		course_id INT,
		semester_code VARCHAR(40),
		CONSTRAINT Course_Semester_id PRIMARY KEY (course_id, semester_code),
		FOREIGN KEY (course_id) REFERENCES Course,
		FOREIGN KEY (semester_code) REFERENCES Semester
	);

	CREATE TABLE Slot(
		slot_id INT PRIMARY KEY IDENTITY,
		day VARCHAR(40),
		time VARCHAR(40),
		location VARCHAR(40),
		course_id INT,
		instructor_id INT,
		FOREIGN KEY (course_id) REFERENCES Course,
		FOREIGN KEY (instructor_id) REFERENCES Instructor
	);

	CREATE TABLE Graduation_Plan(
		plan_id INT IDENTITY,
		semester_code VARCHAR(40),
		semester_credit_hours INT,
		expected_grad_date date,
		advisor_id INT,
		student_id INT,
		CONSTRAINT Graduation_plan_id PRIMARY KEY (plan_id, semester_code),
		FOREIGN KEY (advisor_id) REFERENCES Advisor,
		FOREIGN KEY (student_id) REFERENCES Student
	);
	

	CREATE TABLE GradPlan_Course(
		plan_id INT,
		semester_code VARCHAR(40),
		course_id INT,
		CONSTRAINT GradPlan_Course_id PRIMARY KEY (plan_id, semester_code, course_id),
		FOREIGN KEY (plan_id, semester_code) REFERENCES Graduation_Plan,
		FOREIGN KEY (course_id) REFERENCES Course
	);
	

	CREATE TABLE Request(
		request_id INT PRIMARY KEY IDENTITY,
		type VARCHAR(40),
		comment VARCHAR(40),
		status VARCHAR(40) CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',
		credit_hours INT,
		student_id INT FOREIGN KEY REFERENCES Student,
		advisor_id INT FOREIGN KEY REFERENCES Advisor,
		course_id INT FOREIGN KEY REFERENCES Course,
	);

	CREATE TABLE MakeUp_Exam(
		exam_id INT PRIMARY KEY IDENTITY,
		date DATETIME,
		type VARCHAR(40) CHECK (type IN ('First_makeup', 'Second_makeup')) DEFAULT 'First_makeup',
		course_id INT FOREIGN KEY REFERENCES Course,
	);

	CREATE TABLE Exam_Student(
		exam_id INT FOREIGN KEY REFERENCES MakeUp_Exam,
		student_id INT FOREIGN KEY REFERENCES Student,
		course_id INT FOREIGN KEY REFERENCES Course,
		CONSTRAINT Exam_Student_id PRIMARY KEY (exam_id, student_id)
	);

	CREATE TABLE Payment(
		payment_id INT PRIMARY KEY IDENTITY,
		amount INT,
		deadline DATETIME,
		n_installments INT NOT NULL, -- check with both dates
		status VARCHAR(40) CHECK (status IN ('notPaid', 'Paid')) DEFAULT 'notPaid',
		fund_percentage DECIMAL(4,2),
		start_date datetime,
		student_id INT FOREIGN KEY REFERENCES Student,
		semester_code VARCHAR(40) FOREIGN KEY REFERENCES Semester,
	);

	CREATE TABLE Installment(
		payment_id INT FOREIGN KEY REFERENCES Payment,
		deadline datetime,
		amount INT,
		status VARCHAR(40) CHECK (status IN ('notPaid', 'Paid')) DEFAULT 'notPaid',
		startdate datetime,
		CONSTRAINT Pk_installment PRIMARY KEY (payment_id,deadline)
	);

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


CREATE PROCEDURE clearAllTables
AS
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

--------------------------- 2.2 A ----------------------------------------
CREATE VIEW view_Students
AS
SELECT *
FROM Student
WHERE Student.financial_status = 1

GO

--------------------------- 2.2 B ----------------------------------------
CREATE VIEW view_Course_prerequisites AS
SELECT cr.*, pr.prerequisite_course_id
FROM Course cr LEFT OUTER JOIN PreqCourse_course pr
ON cr.course_id = pr.course_id

GO

--------------------------- 2.2 C ----------------------------------------
CREATE VIEW Instructors_AssignedCourses AS
SELECT ic.course_id, i.*
FROM Instructor_course ic, Instructor i
WHERE ic.instructor_id = i.instructor_id

GO

--------------------------- 2.2 D ----------------------------------------
CREATE VIEW Student_Payment AS 
SELECT s.*, p.fund_percentage, p.n_installments, p.amount, p.deadline, p.payment_id, p.status, p.start_date, p.semester_code
FROM Payment p, Student s
WHERE p.student_id = s.student_id

GO

--------------------------- 2.2 E ----------------------------------------
CREATE VIEW Courses_Slots_Instructor  AS
SELECT cr.course_id, cr.name, sl.slot_id, sl.day, sl.time, sl.location, i.name
FROM Course cr, Slot sl, Instructor i
WHERE cr.course_id = sl.course_id AND sl.instructor_id = i.instructor_id

GO

--------------------------- 2.2 F ----------------------------------------
CREATE VIEW Courses_MakeupExams AS
SELECT cr.name, cr.semester, mx.*
FROM Course cr, MakeUp_Exam mx 
WHERE cr.course_id = mx.exam_id

GO

--------------------------- 2.2 G ----------------------------------------
CREATE VIEW Students_Courses_transcript AS
SELECT s.student_id, CONCAT(st.f_name, ' ', st.l_name) AS student_name, s.course_id, co.name, s.exam_type, s.grade, s.semester_code, ins.name
FROM Student_Instructor_Course_Take s, Student st, Course co, Instructor ins
WHERE s.student_id = st.student_id AND s.course_id = co.course_id AND s.instructor_id = ins.instructor_id

GO

--------------------------- 2.2 H ----------------------------------------
CREATE VIEW Semster_offered_Courses AS
SELECT cs.course_id, co.name, cs.semester_code
FROM Course_Semester cs, Course co
WHERE cs.course_id = co.course_id

GO

--------------------------- 2.2 I ----------------------------------------
CREATE VIEW Advisors_Graduation_Plan AS
SELECT gp.plan_id, gp.semester_code, gp.semester_credit_hours, gp.expected_grad_date, gp.student_id, a.advisor_id, a.name
FROM Graduation_Plan gp, Advisor a
WHERE gp.advisor_id = a.advisor_id;

GO

--------------------------- 2.3 A ----------------------------------------
CREATE PROCEDURE Procedures_StudentRegistration
	@first_name VARCHAR(40),
	@last_name VARCHAR(40),
	@password VARCHAR(40),
	@faculty VARCHAR(40),
	@email VARCHAR(40),
	@major VARCHAR(40),
	@semester INT,
	@student_id INT OUTPUT
AS

	INSERT INTO Student (f_name, l_name, faculty, email, major, password, semester)
	VALUES (@first_name, @last_name, @faculty, @email, @major, @password, @semester)

	SELECT @student_id = student_id
	FROM Student
	WHERE f_name = @first_name AND l_name = @last_name AND password = @password AND faculty = @faculty AND email = @email AND major = @major AND semester = @semester
GO

--------------------------- 2.3 B ----------------------------------------

CREATE PROCEDURE Procedures_AdvisorRegistration
	@advisor_name VARCHAR(40),
	@password VARCHAR(40),
	@email VARCHAR(40),
	@office VARCHAR(40),
	@advisor_id INT OUTPUT
AS
	
	INSERT INTO Advisor (name, office, email, password)
	VALUES (@advisor_name, @office, @email, @password)

	SELECT @advisor_id = advisor_id
	FROM Advisor
	WHERE name = @advisor_name AND office = @office AND email = @email AND password = @password

GO

--------------------------- 2.3 C ----------------------------------------

CREATE PROCEDURE Procedures_AdminListStudents

AS

	Select *
    From Student;

GO

--------------------------- 2.3 D ----------------------------------------
CREATE PROCEDURE Procedures_AdminListAdvisors

AS    
    Select *
    From Advisor;

GO

--------------------------- 2.3 E ----------------------------------------
CREATE PROCEDURE AdminListStudentsWithAdvisors

AS    
    Select *
    From Student s, Advisor a
    where s.advisor_id=a.advisor_id

GO

--------------------------- 2.3 F ----------------------------------------
CREATE PROC AdminAddingSemester
	@semester_code VARCHAR(40),
	@start_date DATE,
	@end_date DATE

AS
	INSERT INTO Semester
	VALUES (@semester_code, @start_date, @end_date)

GO

--------------------------- 2.3 G ----------------------------------------
CREATE PROC AdminAddingCourse
	@major VARCHAR(40),
	@semester INT,
	@credit_hrs INT,
	@course_name VARCHAR(40),
	@offered BIT

AS
	INSERT INTO Course (name, major, is_offered, credit_hours, semester)
	VALUES (@course_name, @major, @offered, @credit_hrs, @semester)

GO

--------------------------- 2.3 H ----------------------------------------
CREATE PROCEDURE Procedures_AdminLinkInstructor
    @instructor_id INT,
    @course_id INT,
    @slot_id INT

AS

	UPDATE Slot
	SET course_id = @course_id , instructor_id = @instructor_id
	WHERE slot_id = @slot_id

GO

--------------------------- 2.3 I ----------------------------------------
CREATE PROCEDURE Procedures_AdminLinkStudent
    @instructor_id INT,
    @student_id INT,
    @course_id INT,
    @semester_code VARCHAR(40)

AS

    INSERT INTO Student_Instructor_Course_Take (instructor_id, student_id, course_id, semester_code)
    VALUES (@instructor_id, @student_id, @course_id, @semester_code);

GO

--------------------------- 2.3 J ----------------------------------------
CREATE PROCEDURE Procedures_AdminLinkStudentToAdvisor
	@student_id INT,
	@advisor_id INT
AS
	UPDATE Student
	SET advisor_id = @advisor_id
	WHERE student_id = @student_id
GO

--------------------------- 2.3 K ----------------------------------------
CREATE PROCEDURE Procedures_AdminAddExam
	@type VARCHAR(40),
	@date datetime,
	@course_id INT
AS
	INSERT INTO MakeUp_Exam (date, type, course_id)
	VALUES (@date, @type, @course_id)
GO

--------------------------- 2.3 L ----------------------------------------
CREATE PROC Procedures_AdminIssueInstallment
	@payment_id INT
	AS
		DECLARE	@i	INT
		DECLARE	@payment_amount INT
		DECLARE	@strt_date	DATETIME
		DECLARE	@ddln	DATETIME

		SELECT	
		@i			=	n_installments,
		@payment_amount	=	payment_amount / n_installments,
		@strt_date	=	s_date,
		@ddln		=	payment_deadline

		FROM	Payment
		WHERE	payment_id	=	@payment_id

		WHILE @i <> 0
		BEGIN
			SET @ddln = DATEADD(MONTH, 1, @strt_date)

			INSERT
			INTO	installment (payment_id, deadline, amount, startdate)
			VALUES	(@payment_id, @ddln, @payment_amount, @strt_date)

			SET @strt_date = @ddln
			SET @i = @i - 1;
		END
GO

--------------------------- 2.3 M ----------------------------------------
CREATE PROC Procedures_AdminDeleteCourse
	@course_id INT
	AS
		
		DELETE FROM	Exam_Student
		WHERE	course_id	=	@course_id

		DELETE FROM	Request
		WHERE	course_id	=	@course_id

		DELETE FROM	GradPlan_Course
		WHERE	course_id	=	@course_id

		DELETE FROM	Student_Instructor_Course_Take
		WHERE	course_id	=	@course_id

		DELETE FROM	Slot
		WHERE	course_id	=	@course_id

		DELETE FROM	MakeUp_Exam
		WHERE	course_id	=	@course_id

		DELETE FROM	Course_Semester
		WHERE	course_id	=	@course_id

		DELETE FROM	Instructor_Course
		WHERE	course_id	=	@course_id

		DELETE FROM	PreqCourse_course
		WHERE	course_id	=	@course_id or prerequisite_course_id = @course_id

		DELETE FROM	Course
		WHERE	course_id	=	@course_id
		
GO

--------------------------- 2.3 N ----------------------------------------
CREATE PROCEDURE Procedure_AdminUpdateStudentStatus
	@student_id INT
AS 
IF EXISTS (SELECT * 
			FROM Student s 
			INNER JOIN Payment p on s.student_id = @student_id AND s.student_id = p.student_id 
			INNER JOIN Installment i on p.payment_id = i.payment_id
			AND i.status = 'notPaid' AND i.deadline < CURRENT_TIMESTAMP)
BEGIN
	Update Student
	Set Student.financial_status= 0
	Where student_id= @student_id
END
ELSE
BEGIN 
	UPDATE Student
	SET Student.financial_status = 1
	WHERE student_id= @student_id
END

GO
--------------------------- 2.3 O ----------------------------------------
CREATE VIEW all_Pending_Requests 

AS
	SELECT r.*, CONCAT(s.f_name, ' ', s.l_name) AS student_name, a.name 
	FROM Request r INNER JOIN Student s on s.student_id=r.student_id INNER JOIN Advisor a on a.advisor_id = r.advisor_id
	WHERE req_status='pending'
GO

--------------------------- 2.3 P ----------------------------------------
CREATE PROC Procedures_AdminDeleteSlots
	@current_semester VARCHAR (40)

AS
	DELETE Slot
	FROM Slot sl
	JOIN Course_Semester crs_sem
	ON sl.course_id = crs_sem.course_id AND crs_sem.semester_code <> @current_semester

GO

--------------------------- 2.3 Q ----------------------------------------
CREATE FUNCTION FN_AdvisorLogin (@id INT, @password VARCHAR(40))
RETURNS BIT

AS
	BEGIN
		RETURN IIF (@password = (SELECT password FROM Advisor WHERE advisor_id = @id), 1, 0)
	END

GO

--------------------------- 2.3 R ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorCreateGP
    @semester_code VARCHAR(40),
    @expected_graduation_date DATE,
    @sem_credit_hours INT,
    @advisor_id INT,
    @student_id INT

AS
	IF (EXISTS(SELECT student_id FROM Student WHERE acquired_hours > 157 AND student_id = @student_id))

	INSERT INTO Graduation_Plan (semester_code, semester_credit_hours, expected_grad_date, advisor_id, student_id)
	VALUES (@semester_code, @sem_credit_hours, @expected_graduation_date, @advisor_id, @student_id);

GO

--------------------------- 2.3 S ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorAddCourseGP
@student_id INT,
@semester_code VARCHAR(40),
@course_name VARCHAR(40)

AS

	INSERT INTO GradPlan_Course(plan_id, semester_code, course_id)
	VALUES
	
	(
	(SELECT plan_id FROM Graduation_Plan WHERE student_id = @student_id AND semester_code = @semester_code),
	@semester_code,
	(SELECT course_id FROM Course WHERE name = @course_name)
	)

GO

--------------------------- 2.3 T ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorUpdateGP
	@expected_grad_semster VARCHAR(40),
	@studentID INT 
AS
	UPDATE Graduation_Plan
	SET expected_grad_date = @expected_grad_semster
	WHERE student_id = @studentID
GO

--------------------------- 2.3 U ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorDeleteFromGP
	@student_id INT,
	@semester_code VARCHAR(40),
	@course_id INT
AS
	DECLARE @plan_id INT

	SELECT @plan_id = plan_id
	FROM Graduation_Plan
	WHERE student_id = @student_id AND semester_code = @semester_code

	DELETE FROM GradPlan_Course
	WHERE plan_id = @plan_id AND semester_code = @semester_code AND course_id = @course_id

GO

--------------------------- 2.3 V ----------------------------------------
CREATE FUNCTION FN_Advisors_Requests (@advisor_id INT)
RETURNS TABLE
	AS
	RETURN	SELECT	*
			FROM	Request
			WHERE	advisor_id	=	@advisor_id
GO

--------------------------- 2.3 W ----------------------------------------
CREATE PROC Procedures_AdvisorApproveRejectCHRequest
	@request_id INT,
	@current_semester VARCHAR(40)
AS
DECLARE @credit_hours INT
BEGIN
		(
		SELECT	request_id, credit_hours
		INTO	#temp
		FROM	Request r, Student s
		WHERE	r.student_id	=	s.student_id
		AND		r.request_id = @request_id
		AND		req_type		=	'credit'
		AND		gpa				<=	3.7
		AND		(credit_hours 
				+ assigned_hours) <	34
		)

		SET @credit_hours = (
			SELECT	credit_hours
			FROM	#temp
		)

	UPDATE	Student
	SET		assigned_hours	=	assigned_hours	+	IIF(credit_hours > 3, 3, credit_hours)
	FROM	Students s
	JOIN	Request r
	ON		r.student_id = s.student_id
	WHERE	request_id IN (SELECT request_id FROM #temp)

	IF (@credit_hours IS NOT NULL) 
		BEGIN
		
		UPDATE	Request
		SET		req_status	=	IIF(request_id IN (SELECT request_id FROM #temp), 'accepted', 'rejected')

		UPDATE Payment
		SET payment_amount = payment_amount + 1000 * @credit_hours
		FROM Payment p, Student s
		WHERE p.student_id = s.student_id
		AND  p.semester_code = @current_semester 
	
		UPDATE Installment
		SET amount = amount + 1000 * @credit_hours
		WHERE deadline IN 
						(
						SELECT min(i.deadline) 
						FROM Installment i, Payment p, Student s
						WHERE p.payment_id = i.payment_id 
						AND i.deadline > CURRENT_TIMESTAMP 
						AND i.status = 'notPaid' 
						AND  p.semester_code = @current_semester
						AND p.student_id = s.student_id
						)
		END
	ELSE
		BEGIN
			UPDATE	Request
			SET		req_status	= 'pending'
		
		END
	
END;

GO

--------------------------- 2.3 X ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorViewAssignedStudents
	@advisor_id INT,
	@major VARCHAR(40)
AS    
    Select sct.student_id, CONCAT(s.f_name, ' ', s.l_name) AS student_name, s.major, sct.course_name
    From Students_Courses_transcript sct, Student s 
    where sct.student_id = s.student_id AND s.major = @major AND s.advisor_id = @advisor_id

GO

--------------------------- 2.3 Y ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorApproveRejectCourseRequest
	@requestID INT,
	@current_semester_code VARCHAR(40)
AS
	DECLARE @studentID INT
	DECLARE @reject BIT
	DECLARE @chours INT
	DECLARE @asghours INT
	DECLARE @rcourse_id INT
	DECLARE @radvisor_id INT
	DECLARE @rtype VARCHAR(40)

	SELECT @chours = c.credit_hours, @asghours = s.assigned_hours, @rcourse_Id = r.course_id, @radvisor_id = r.advisor_id, @studentID = r.student_id, @rtype = r.req_type
	FROM Request r INNER JOIN Course c ON r.course_id = c.course_id INNER JOIN Student s ON s.student_id = r.student_id 
	WHERE r.request_id = @requestID AND r.req_type = 'course'

	SET @reject = 0
	IF( EXISTS( (SELECT prerequisite_course_id FROM Request r INNER JOIN PreqCourse_course p ON r.course_id = p.course_id)
		EXCEPT (SELECT course_id AS prerequisite_course_id FROM Student s INNER JOIN Student_Instructor_Course_Take sict ON s.student_id= sict.student_id 
		WHERE s.student_id = @studentID AND sict.grade IS NOT NULL)))
	BEGIN
		SET @reject = 1
	END


	If(@rtype = 'course')	
		BEGIN
			IF (@reject =1 OR @asghours IS NULL OR (@asghours IS NOT NULL AND @chours > @asghours))
			BEGIN
				UPDATE Request 
				SET Request.req_status = 'rejected' WHERE Request.request_id = @RequestID
			END
	ELSE
		BEGIN
			UPDATE Request 
			SET Request.req_status = 'accepted' WHERE Request.request_id = @RequestID
			INSERT INTO Student_Instructor_Course_Take (student_id, course_id, semester_code)
			VALUES (@studentID, @rcourse_id, @current_semester_code)
			UPDATE Student
			SET Student.assigned_hours= @asghours-@chours
			WHERE Student.student_id= @studentID
		END
	END
GO
--------------------------- 2.3 Z ----------------------------------------
CREATE PROC Procedures_AdvisorViewPendingRequests
	@advisor_id INT
AS    
    SELECT *
	FROM Request
	WHERE advisor_id = @advisor_id AND req_status = 'pending'

GO

--------------------------- 2.3 AA ----------------------------------------
CREATE FUNCTION FN_StudentLogin (@id INT, @password VARCHAR(40))
RETURNS BIT

AS
	BEGIN
		RETURN IIF (@password = (SELECT password FROM Student WHERE student_id = @id AND dbo.[checkStudentStatus] (@id) = 1), 1, 0)
	END

GO
--------------------------- 2.3 BB ----------------------------------------
CREATE PROCEDURE Procedures_StudentaddMobile
    @student_id INT,
    @phone_number VARCHAR(40)
AS
    INSERT INTO Student_Phone (student_id, phone_number)
    VALUES (@student_id, @phone_number);
GO

--------------------------- 2.3 CC ----------------------------------------
CREATE FUNCTION FN_SemesterAvailableCourses(@semester_code VARCHAR(40))
RETURNS TABLE
AS
RETURN
    SELECT
        c.course_id,
        c.name,
        c.major,
        c.is_offered,
        c.credit_hours,
		c.semester
    FROM
        Course c
    INNER JOIN
        Course_Semester cs ON c.course_id = cs.course_id
    WHERE
        cs.semester_code = @semester_code
       -- AND c.is_offered = 1
GO

--------------------------- 2.3 DD ----------------------------------------
CREATE PROCEDURE Procedures_StudentSendingCourseRequest
	@type VARCHAR(40),
	@comment VARCHAR(40),
	@student_id INT,
	@course_id INT
AS
	INSERT INTO Request (req_type, comment, student_id, course_id)
	VALUES (@type, @comment, @student_id, @course_id)
GO

--------------------------- 2.3 EE ----------------------------------------
CREATE PROCEDURE Procedures_StudentSendingCHRequest
	@type VARCHAR(40),
	@comment VARCHAR(40),
	@credit_hours INT,
	@student_id INT
AS
	INSERT INTO Request (req_type, comment, student_id, credit_hours)
	VALUES (@type, @comment, @student_id, @credit_hours)
GO

--------------------------- 2.3 FF ----------------------------------------
CREATE FUNCTION FN_StudentViewGP (@student_id INT)
RETURNS TABLE
	AS
	RETURN	(
			SELECT	s.student_id, CONCAT(s.f_name, ' ', s.l_name) AS student_name,
					gradpln_crs.plan_id, gradpln_crs.course_id,
					crs.name,
					gradpln.semester_code, gradpln.expected_grad_date, gradpln.semester_credit_hours, gradpln.advisor_id

			FROM	Student			s,
					GradPlan_Course	gradpln_crs,
					Course			crs,
					Graduation_Plan	gradpln

			WHERE	s.student_id			=	gradpln.student_id
			AND		gradpln.plan_id			=	gradpln_crs.plan_id
			AND		gradpln.semester_code	=	gradpln_crs.semester_code
			AND		gradpln_crs.course_id	=	crs.course_id
			AND		s.student_id			=	@student_id
			)
GO

-------------------------- 2.3 GG ----------------------------------------
CREATE FUNCTION FN_StudentUpcoming_installment (@student_id INT)
RETURNS	DATETIME
	AS
		BEGIN
			RETURN
			(
			SELECT	TOP	1	i.deadline
			FROM	Payment p,
					Installment i

			WHERE	p.student_id	=	@student_id
			AND		p.payment_id	=	i.payment_id
			AND		i.status	=	'notPaid'
			ORDER BY i.deadline
			)
		END
GO
--------------------------- 2.3 HH ----------------------------------------
CREATE FUNCTION FN_StudentViewSlot(@course_id int, @instructor_id int)
RETURNS TABLE
AS
RETURN 
	SELECT 
		s.slot_id,  s.location ,s.time,  s.day, c.name, i.name
	FROM 
		Slot s INNER JOIN Course c on c.course_id = s.course_id
                INNER JOIN Instructor i on s.instructor_id = i.instructor_id
	WHERE 
		s.course_id = @course_id
		AND s.instructor_id= @instructor_id
GO

--------------------------- 2.3 II ----------------------------------------
CREATE PROC Procedures_StudentRegisterFirstMakeup
	@student_id INT,
	@course_id INT,
	@current_semester VARCHAR(40)

	AS
		DECLARE	@is_odd BIT
		DECLARE	@exm_id INT
		DECLARE @curr_year INT
		DECLARE @start_year INT
		DECLARE @end_year INT
		DECLARE @crs_sem VARCHAR(40)
		DECLARE @start_sem VARCHAR(40)
		DECLARE @end_sem VARCHAR(40)
		DECLARE @start_date DATE
		DECLARE @end_date DATE

		IF (EXISTS(
				SELECT	*
				FROM	Student_Instructor_Course_Take
				WHERE	student_id		=	@student_id
				AND		course_id		=	@course_id
				AND		semester_code	=	@current_semester
				AND		exam_type		=	'Normal'
				AND		grade			IN	(NULL, 'F', 'FF')
		)

		AND

			NOT EXISTS(
				SELECT	*
				FROM	Student_Instructor_Course_Take
				WHERE	student_id		=	@student_id
				AND		course_id		=	@course_id
				AND		exam_type		IN 	('First_makeup', 'Second_makeup')
			)
		)	
		BEGIN

			SELECT	@crs_sem = semester_code
			FROM	Student_Instructor_Course_Take
			WHERE	student_id	=	@student_id
			AND		course_id	=	@course_id


				SELECT	@is_odd		=	IIF (LEFT(@crs_sem, 1) = 'W' OR RIGHT(@crs_sem, 2) = 'R1', 1, 0),

						@curr_year	=	CAST (SUBSTRING (@current_semester, 2, 2) AS INT),

						@start_year =	@curr_year + IIF(@current_semester LIKE '%R%', 1, 0),

						@end_year =		@start_year + IIF(@is_odd = 1, 1, 0),

						@start_sem =	IIF(@is_odd = 1, 'W', 'S'),

						@end_sem =		IIF(@is_odd = 1, 'S', 'W')

				SELECT	@start_date = s.end_date
				FROM	Semester s
				WHERE	s.semester_code = CONCAT(@start_sem, @start_year)

				SELECT	@end_date = s.start_date
				FROM	Semester s
				WHERE	s.semester_code = CONCAT(@end_sem, @end_year)


			SELECT	@exm_id = exam_id
			FROM	MakeUp_Exam
			WHERE	course_id		=	@course_id
			AND		type	=	'First_makeup' 
			AND		date	between	@start_date
									AND		@end_date

			INSERT
			INTO	Exam_Student
			VALUES	(@exm_id, @student_id, @course_id)

		END
GO

---------------------------- 2.3 JJ ----------------------------------------
CREATE FUNCTION FN_StudentCheckSMEligibility (@course_id INT, @student_id INT)
RETURNS BIT
	AS
	BEGIN
		DECLARE	@fail_count INT
		DECLARE	@pass_count INT

        SELECT	@fail_count	= COUNT(DISTINCT course_id) - SUM(IIF (grade IS NOT NULL AND grade NOT IN ('F', 'FF'), 1, 0))
        FROM	Student_Instructor_Course_Take
        WHERE	student_id	=	@student_id

        SELECT	@pass_count = SUM(IIF (grade IS NOT NULL AND grade < 'F', 1, 0))
        FROM	Student_Instructor_Course_Take
        WHERE	student_id	=	@student_id
        AND		course_id	=	@course_id
        AND		exam_type	=	'First_makeup'

		RETURN IIF(@fail_count <= 2 AND @pass_count = 0, 1, 0)
	END
GO

--------------------------- 2.3 KK ----------------------------------------
CREATE PROC Procedures_StudentRegisterSecondMakeup
	@student_id INT,
	@course_id INT,
	@current_semester VARCHAR(40)

	AS
		DECLARE	@is_odd BIT
		DECLARE	@exm_id INT
		DECLARE @curr_year INT
		DECLARE @start_year INT
		DECLARE @end_year INT
		DECLARE @crs_sem VARCHAR(40)
		DECLARE @start_sem VARCHAR(40)
		DECLARE @end_sem VARCHAR(40)
		DECLARE @start_date DATE
		DECLARE @end_date DATE



		SELECT	@crs_sem = semester_code
		FROM	Student_Instructor_Course_Take
		WHERE	student_id	=	@student_id
		AND		course_id	=	@course_id


			SELECT	@is_odd		=	IIF (LEFT(@crs_sem, 1) = 'W' OR RIGHT(@crs_sem, 2) = 'R1', 1, 0),

					@curr_year	=	CAST (SUBSTRING (@current_semester, 2, 2) AS INT),

					@start_year =	@curr_year + IIF(@current_semester LIKE '%R%', 1, 0),

					@end_year =		@start_year + IIF(@is_odd = 1, 1, 0),

					@start_sem =	IIF(@is_odd = 1, 'W', 'S'),

					@end_sem =		IIF(@is_odd = 1, 'S', 'W')

			SELECT	@start_date	=	s.end_date
			FROM	Semester s
			WHERE	s.semester_code	=	CONCAT(@start_sem, @start_year)

			SELECT	@end_date	=	s.start_date
			FROM	Semester s
			WHERE	s.semester_code	=	CONCAT(@end_sem, @end_year)


		SELECT	@exm_id = exam_id
		FROM	MakeUp_Exam,
				Semester
		WHERE	course_id		=	@course_id
		AND		type	=	'Second_makeup' 
		AND		date	between	@start_date
								AND		@end_date

		INSERT
		INTO	Exam_Student
		VALUES	(@exm_id, @student_id, @course_id)
GO

--------------------------- 2.3 LLR ----------------------------------------
CREATE PROC Procedures_ViewRequiredCoursesR
	@student_id INT,
	@current_semester_code VARCHAR(40)
	AS
	BEGIN
		DECLARE @course_id INT;

			(
				SELECT	c1.*

				FROM	Student_Instructor_Course_Take sic1,
						Semester sem1,
						Course c1
				WHERE	sic1.semester_code	=	sem1.semester_code
				AND		student_id			=	@student_id
				AND		grade				IN	('F', 'FF')
				AND		c1.course_id		=	sic1.course_id
				GROUP BY c1.course_id, c1.name, c1.credit_hours, c1.is_offered, c1.major, c1.semester, sic1.semester_code, dbo.FN_StudentCheckSMEligibility (@student_id, c1.course_id)
				HAVING	(
						sic1.semester_code	=	@current_semester_code 
					AND	
						dbo.FN_StudentCheckSMEligibility (@student_id, c1.course_id) = 0
						)
			)
			UNION
			(
				SELECT	c2.*
				FROM	Course c2
				WHERE	
				NOT EXISTS	(
									SELECT	sic2.course_id 
									FROM	Student_Instructor_Course_Take sic2, Student s, Course c2
									WHERE	s.student_id	=	sic2.student_id
									AND		s.major		=	c2.major
									AND		s.semester	>	c2.semester
									AND		sic2.course_id = c2.course_id
							)
				OR EXISTS	(
									SELECT	sic2.course_id 
									FROM	Student_Instructor_Course_Take sic2, Student s, Course c2
									WHERE	s.student_id	=	sic2.student_id
									AND		s.major		=	c2.major
									AND		s.semester	>	c2.semester
									AND		sic2.grade = 'FA'
									AND		sic2.course_id = c2.course_id
							)
			)
			
	END
GO

--------------------------- 2.3 LL ----------------------------------------
CREATE PROCEDURE Procedures_ViewRequiredCourses
	@student_id INT,
	@current_semester_code VARCHAR(40)
	-- see if we need to compare using dates
	AS
	BEGIN
		SELECT c.*
		FROM Course c
		JOIN Student_Instructor_Course_Take sict ON c.course_id = sict.course_id
		WHERE @student_id = sict.student_id
			AND (
				(CAST(RIGHT(@current_semester_code, LEN(@current_semester_code) - 1) AS INT) 
					>= CAST(RIGHT(sict.semester_code, LEN(sict.semester_code) - 1) AS INT) 
						AND sict.grade IN ('F', 'FF')  AND dbo.FN_StudentCheckSMEligiability(@student_id, sict.course_id) = 0) 
				OR
				(CAST(RIGHT(@current_semester_code, LEN(@current_semester_code) - 1) AS INT) 
					> CAST(RIGHT(sict.semester_code, LEN(sict.semester_code) - 1) AS INT) 
						AND sict.grade IS NULL)
			);
	END
	GO

--------------------------- 2.3 MM ----------------------------------------
CREATE PROCEDURE Procedures_ViewOptionalCourse
	@student_id INT,
	@current_semester_code VARCHAR(40)

	AS
	BEGIN

	 DECLARE @currsem_date date
     SELECT @currsem_date = s.start_date 
	 FROM Semester s
     WHERE s.semester_code = @current_semester_code

	 DECLARE @gpc_sem_date date
	 SELECT @gpc_sem_date = s.start_date 
	 FROM Semester s, GradPlan_Course gpc
     WHERE s.semester_code = gpc.semester_code

		--Courses from current semester that are still being taken by the student
		SELECT c.*
		FROM Course c
		JOIN Student_Instructor_Course_Take sict ON c.course_id = sict.course_id
		WHERE @student_id = sict.student_id
			AND @current_semester_code = sict.semester_code
				AND sict.grade IS NULL

		UNION

		--Courses that need to be taken by the student in future to graduate
		SELECT c.*
		FROM Graduation_Plan gp
		JOIN GradPlan_Course gpc ON gp.plan_id = gpc.plan_id
		JOIN Course c ON gpc.course_id = c.course_id
		WHERE @student_id = gp.student_id
			AND (
				@currsem_date < @gpc_sem_date
				);
					
	END
	GO

--------------------------- 2.3 NN ----------------------------------------
CREATE PROC Procedures_ViewMS
	@student_id INT
	AS

		SELECT	course_id
		INTO	#taken
		FROM	Student_Instructor_Course_Take


		SELECT	course_id
		INTO	#takenButNotPass
		FROM	Student_Instructor_Course_Take
		WHERE	grade	IN (NULL, 'F', 'FF', 'FA')


		SELECT	crs.*
		FROM	Course							crs,
				Student							s,
				Student_Instructor_Course_Take	sic

		WHERE	s.student_id	=	@student_id
		AND		s.major			=	crs.major
		AND		s.student_id	=	sic.student_id
		AND		crs.course_id	=	sic.course_id
		AND		(
				crs.course_id	NOT	IN	(SELECT * FROM #taken)
			OR
				crs.course_id		IN	(SELECT * FROM #takenButNotPass)
				)
GO

--------------------------- 2.3 OO ----------------------------------------
CREATE PROCEDURE Procedures_ChooseInstructor
	@student_id INT,
	@instructor_id INT,
	@course_id INT,
	@current_semester_code VARCHAR(40)
AS
		UPDATE	Student_Course_Instructor_Take
		SET		instructor_id	=	@instructor_id
		WHERE	student_id		=	@student_id
		AND		course_id		=	@course_id
		AND		semester_code   =   @current_semester_code
GO
