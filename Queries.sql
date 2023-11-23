USE master
GO

CREATE DATABASE Advising_Team_27;
GO

USE Advising_Team_27;
GO

DROP DATABASE Advising_Team_27;
GO

--------------------------- 2.1 ----------------------------------------

CREATE PROCEDURE CreateAllTables
AS
	CREATE TABLE Advisor(
		advisor_id INT PRIMARY KEY IDENTITY,
		advisor_name VARCHAR(40) NOT NULL,
		email VARCHAR(40) NOT NULL,
		office VARCHAR(40) NOT NULL,
		pass VARCHAR(40) NOT NULL
	);

	CREATE TABLE Student(
		student_id INT PRIMARY KEY IDENTITY, 
		f_name VARCHAR(40) NOT NULL, 
		l_name VARCHAR(40) NOT NULL,
		gpa DECIMAL(3, 2),
		faculty VARCHAR(40) NOT NULL,
		email VARCHAR(40) NOT NULL,
		major VARCHAR(40) NOT NULL,
		pass VARCHAR(40) NOT NULL,
		financial_status BIT CHECK (financial_status IN (0, 1)) /* 0 MEANS BLOCKED, 1 MEANS UNBLOCKED */,
		semester INT NOT NULL,
		acquired_hours INT,
		assigned_hours INT, -- 34 hrs max
		advisor_id INT,
		FOREIGN KEY (advisor_id) REFERENCES Advisor ON DELETE CASCADE
	);

	CREATE TABLE Student_phone(
		student_id INT NOT NULL,
		phone_number VARCHAR(40) NOT NULL,
		CONSTRAINT Pk_Phone PRIMARY KEY(student_id, phone_number),
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE
	);

	CREATE TABLE Course(
		course_id INT PRIMARY KEY IDENTITY,
		course_name VARCHAR(40) NOT NULL,
		major VARCHAR(40) NOT NULL,
		is_offered BIT CHECK (is_offered IN (0, 1)) /* 0 MEANS OFFERED, 1 MEANS NOT OFFERED Current Sem */,
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
		instructor_id INT PRIMARY KEY IDENTITY,
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

	CREATE TABLE Semester(
		semester_code VARCHAR(40) PRIMARY KEY,
		s_date date NOT NULL,
		end_date date NOT NULL
	);

	CREATE TABLE Student_Instructor_Course_Take(
		student_id INT NOT NULL,
		course_id  INT NOT NULL,
		instructor_id INT NOT NULL,
		semester_code VARCHAR(40),
		exam_type VARCHAR(40) CHECK (exam_type IN ('Normal', 'First_makeup', 'Second_makeup')) DEFAULT 'Normal',
		grade VARCHAR(40),
		CONSTRAINT Student_Instructor_Course_Take_id PRIMARY KEY (student_id, course_id, semester_code),
		FOREIGN KEY (student_id) REFERENCES Student ON DELETE CASCADE,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE,
		FOREIGN KEY (semester_code) REFERENCES Semester ON DELETE CASCADE
	);

	CREATE TABLE Course_Semester(
		course_id INT NOT NULL,
		semester_code VARCHAR(40) NOT NULL,
		CONSTRAINT Course_Semester_id PRIMARY KEY (course_id, semester_code),
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (semester_code) REFERENCES Semester ON DELETE CASCADE
	);

	CREATE TABLE Slot(
		slot_id INT PRIMARY KEY IDENTITY,
		slot_day VARCHAR(40),
		slot_time VARCHAR(40),
		slot_location VARCHAR(40),
		course_id INT NOT NULL,
		instructor_id INT NOT NULL,
		FOREIGN KEY (course_id) REFERENCES Course ON DELETE CASCADE,
		FOREIGN KEY (instructor_id) REFERENCES Instructor ON DELETE CASCADE
	);

	CREATE TABLE Graduation_Plan(
		plan_id INT,
		semester_code VARCHAR(40) NOT NULL,
		semester_credit_hours INT NOT NULL,
		expected_grad_date date NOT NULL,
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
		request_id INT PRIMARY KEY IDENTITY,
		req_type VARCHAR(40) NOT NULL,
		comment VARCHAR(40) NOT NULL,
		req_status VARCHAR(40) CHECK (req_status IN ('pending', 'accepted', 'rejected')) DEFAULT 'pending',
		credit_hours INT,
		student_id INT NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		advisor_id INT FOREIGN KEY REFERENCES Advisor,
		course_id INT NOT NULL FOREIGN KEY REFERENCES Course ON DELETE CASCADE,
	);

	CREATE TABLE MakeUp_Exam(
		exam_id INT PRIMARY KEY IDENTITY,
		mk_exam_date datetime NOT NULL,
		mk_exam_type VARCHAR(40) CHECK (mk_exam_type IN ('First_makeup', 'Second_makeup')) DEFAULT 'First_makeup',
		course_id INT NOT NULL FOREIGN KEY REFERENCES Course ON DELETE CASCADE,
	);

	CREATE TABLE Exam_Student(
		exam_id INT NOT NULL FOREIGN KEY REFERENCES MakeUp_Exam ON DELETE CASCADE,
		student_id INT NOT NULL FOREIGN KEY REFERENCES Student ON DELETE CASCADE,
		course_id INT NOT NULL FOREIGN KEY REFERENCES Course,
		CONSTRAINT Exam_Student_id PRIMARY KEY (exam_id, student_id)
	);

	CREATE TABLE Payment(
		payment_id INT PRIMARY KEY IDENTITY,
		payment_amount INT NOT NULL,
		payment_deadline datetime NOT NULL,
		n_installments INT NOT NULL, -- check with both dates
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
		inst_status VARCHAR(40) CHECK (inst_status IN ('notPaid', 'Paid')) DEFAULT 'notPaid' NOT NULL,
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
FROM Course cr LEFT OUTER JOIN preqCourse_course pr
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
SELECT s.*, p.fund_percentage, p.n_installments, p.payment_amount, p.payment_deadline, p.payment_id, p.payment_status, p.s_date, p.semester_code
FROM Payment p, Student s
WHERE p.student_id = s.student_id

GO

--------------------------- 2.2 E ----------------------------------------
CREATE VIEW Courses_Slots_Instructor  AS
SELECT i.instructor_name, cr.course_name, sl.*
FROM Course cr, Slot sl, Instructor i
WHERE cr.course_id = sl.course_id AND sl.instructor_id = i.instructor_id

GO

--------------------------- 2.2 F ----------------------------------------
CREATE VIEW Courses_MakeupExams AS
SELECT cr.course_name, cr.semester, mx.*
FROM Course cr, MakeUp_Exam mx 
WHERE cr.course_id = mx.exam_id

GO

--------------------------- 2.2 G ----------------------------------------
CREATE VIEW Students_Courses_transcript AS
SELECT s.student_id, st.f_name, st.l_name, s.course_id, co.course_name, s.exam_type, s.grade, s.semester_code, ins.instructor_name
FROM Student_Instructor_Course_Take s, Student st, Course co, Instructor ins
WHERE s.student_id = st.student_id AND s.course_id = co.course_id AND s.instructor_id = ins.instructor_id

GO

--------------------------- 2.2 H ----------------------------------------
CREATE VIEW Semster_offered_Courses AS
SELECT cs.course_id, co.course_name, cs.semester_code
FROM Course_Semester cs, Course co
WHERE cs.course_id = co.course_id

GO

--------------------------- 2.2 I ----------------------------------------
CREATE VIEW Advisors_Graduation_Plan AS
SELECT gp.*, a.advisor_name
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

	INSERT INTO Student (f_name, l_name, faculty, email, major, pass, semester)
	VALUES (@first_name, @last_name, @faculty, @email, @major, @password, @semester)

	SELECT @student_id = student_id
	FROM Student
	WHERE f_name = @first_name AND l_name = @last_name AND pass = @password AND faculty = @faculty AND email = @email AND major = @major AND semester = @semester
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
	INSERT INTO Course (course_name, major, is_offered, credit_hours, semester)
	VALUES (@course_name, @major, @offered, @credit_hrs, @semester)

GO

--------------------------- 2.3 H ----------------------------------------
CREATE PROCEDURE Procedures_AdminLinkInstructor
    @instructor_id INT,
    @course_id INT,
    @slot_id INT

AS

INSERT INTO Slot (slot_id, course_id, instructor_id)
VALUES (@slot_id, @course_id, @instructor_id )

GO

EXEC Procedures_AdminLinkInstructor 1234, 123, 12

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
	INSERT INTO MakeUp_Exam (mk_exam_date, mk_exam_type, course_id)
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

		FROM	Student_Payment
		WHERE	payment_id	=	@payment_id

		WHILE @i <> 0
		BEGIN
			SET @ddln = DATEADD(MONTH, 1, @strt_date)

			INSERT
			INTO	installment (payment_id, deadline, inst_amount, inst_start_date)
			VALUES	(@payment_id, @ddln, @payment_amount, @strt_date)

			SET @strt_date = @ddln
			SET @i = @i - 1;
		END
GO

--------------------------- 2.3 M ----------------------------------------
CREATE PROC Procedures_AdminDeleteCourse
	@course_id INT
	AS
		DELETE
		FROM	Course
		WHERE	course_id	=	@course_id

		DELETE
		FROM	Slot
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
			AND i.inst_status = 'notPaid' AND i.deadline < CURRENT_TIMESTAMP)
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
	SELECT r.*, s.f_name, s.l_name, a.advisor_name 
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
		RETURN IIF (@password = (SELECT pass FROM Advisor WHERE advisor_id = @id), 1, 0)
	END

GO

--------------------------- 2.3 R ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorCreateGP
    @semester_code VARCHAR(40),
    @expected_graduation_date DATE,
    @sem_credit_hours INT,
    @student_id INT,
    @advisor_id INT

AS

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
	(SELECT course_id FROM Course WHERE course_name = @course_name)
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
BEGIN

	
		(
		SELECT	request_id
		INTO	#temp
		FROM	Request r, Student s
		WHERE	r.student_id	=	s.student_id
		AND		req_type		=	'credit'
		AND		gpa				<=	3.7
		AND		(credit_hours 
				+ assigned_hours) <	34
		)

	UPDATE	Request
	SET		req_status	=	IIF(request_id IN (SELECT request_id FROM #temp), 'accepted', 'rejected')

	UPDATE	Student
	SET		assigned_hours	=	assigned_hours	+	IIF(credit_hours > 3, 3, credit_hours)
	FROM	Students s
	JOIN	Request r
	ON		r.student_id = s.student_id
	WHERE	request_id IN (SELECT request_id FROM #temp)
END;

GO

--------------------------- 2.3 X ----------------------------------------
CREATE PROCEDURE Procedures_AdvisorViewAssignedStudents
	@advisor_id INT,
	@major VARCHAR(40)
AS    
    Select sct.student_id, sct.f_name, sct.l_name, s.major, sct.course_name
    From Students_Courses_transcript sct, Student s 
    where sct.student_id = s.student_id AND s.major = @major AND s.advisor_id = @advisor_id

GO

EXEC Procedures_AdvisorViewAssignedStudents 1234, 'CSEN'

GO

--------------------------- 2.3 Y ----------------------------------------
Create Procedure Procedures_AdvisorApproveRejectCourseRequest
	@requestID int,
	@studentID int,
	@advisorID int 
AS
	Declare @reject bit
	Declare @chours int
	Declare @asghours int
	Declare @rcourse_id int
	Declare @sem_code varchar(40)
	Declare @radvisor_id int

	Select @chours=c.credit_hours, @asghours=s.assigned_hours, @rcourse_Id=r.course_id, @radvisor_id=r.advisor_id
	from Request r Inner Join Course c on r.course_id=c.course_id Inner Join Student s on s.student_id=r.student_id 
	where r.request_id= @requestID and s.student_id=@studentID

	set @reject=0
		If( exists( (Select prerequisite_course_id from Request r Inner Join preqCourse_course p on r.course_id = p.course_id)
		Except (Select course_id as prerequisite_course_id from Student s Inner Join Student_Instructor_Course_Take sict on s.student_id= sict.student_id 
		Where s.student_id = @studentID and sict.grade is not null)))
		begin
		set @reject =1
		end

	Select @sem_code = max(semester_code) from
			Course_Semester c where c.course_id = @rcourse_id

	IF (@reject =1 OR @chours>@asghours OR @radvisor_id <> @advisorID)
	Begin
		update Request 
		Set Request.req_status = 'rejected' where Request.request_id = @RequestID
	End
	Else
	Begin
		update Request 
		Set Request.req_status = 'accepted' where Request.request_id = @RequestID
		INSERT INTO Student_Instructor_Course_Take (student_id, course_id, semester_code)
    VALUES (@studentID, @rcourse_id, @sem_code);
	End

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
		RETURN IIF (@password = (SELECT pass FROM Student WHERE student_id = @id), 1, 0)
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
        c.course_name,
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
        AND c.is_offered = 1
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
			AND		i.inst_status	=	'notPaid'
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
		s.slot_id,  s.slot_location ,s.slot_time,  s.slot_day, c.course_name, i.instructor_name
	FROM 
		Slot s Inner Join Course c on c.course_id = s.course_id
                Inner Join Instructor i on s.instructor_id= i.instructor_id
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

			SELECT	@end_date = s.s_date
			FROM	Semester s
			WHERE	s.semester_code = CONCAT(@end_sem, @end_year)


		SELECT	@exm_id = exam_id
		FROM	MakeUp_Exam, Semester
		WHERE	course_id		=	@course_id
		AND		mk_exam_type	=	'First_makeup' 
		AND		mk_exam_date	between	@start_date
								AND		@end_date

		INSERT
		INTO	Exam_Student
		VALUES	(@exm_id, @student_id, @course_id)
GO

---------------------------- 2.3 JJ ----------------------------------------
CREATE FUNCTION FN_StudentCheckSMEligibility (@student_id INT, @course_id INT)
RETURNS BIT
	AS
	BEGIN
		DECLARE	@fail_count INT
		DECLARE	@pass_count INT

        SELECT	@fail_count	= COUNT(*) - SUM(IIF (grade IS NOT NULL AND grade < 'F', 1, 0))
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

			SELECT	@end_date	=	s.s_date
			FROM	Semester s
			WHERE	s.semester_code	=	CONCAT(@end_sem, @end_year)


		SELECT	@exm_id = exam_id
		FROM	MakeUp_Exam,
				Semester
		WHERE	course_id		=	@course_id
		AND		mk_exam_type	=	'Second_makeup' 
		AND		mk_exam_date	between	@start_date
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
			SELECT	c1.*,
					master.FN_StudentCheckSMEligibility (@student_id, course_id)

			FROM	Student_Instructor_Course_Take sic1,
					Semester sem1,
					Course c1
			WHERE	sic1.semester_code	=	sem1.semester_code
			AND		student_id			=	@student_id
			AND		grade				=	'F'
			GROUP BY sic1.semester_code
			HAVING	(
					sic1.semester_code	=	@current_semester_code 
				AND	
					master.FN_StudentCheckSMEligibility (@student_id, course_id) = 0
					)
			)
			UNION
			(
			SELECT	c2.*
			FROM	Student s,
					Course c1
			WHERE	s.major		=	c.major
			AND		s.semester	>	c.semester
			AND NOT EXIST IN	(
								SELECT	course_id 
								FROM	Student_Instructor_Course_Take sic2
								WHERE	s.student_id	=	sic2.student_id
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
						AND sict.grade = 'F' AND dbo.FN_StudentCheckSMEligiability(@student_id, sict.course_id) = 0) 
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
     SELECT @currsem_date = s.s_date 
	 FROM Semester s
     WHERE s.semester_code = @current_semester_code

	 DECLARE @gpc_sem_date date
	 SELECT @gpc_sem_date = s.s_date 
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
CREATE PROCEDURE Procedures_ViewMS
	@student_id INT
AS
	(SELECT c.*
	FROM Graduation_plan gp, GradPlan_Course gpc, Course c
	WHERE gp.plan_id = gpc.plan_id AND gpc.course_id = c.course_id AND gp.student_id = @student_id)

	EXCEPT

	(SELECT c.*
	FROM Student_Instructor_Course_Take s, Course c
	WHERE s.course_id = c.course_id AND s.student_id = @student_id)
GO

--------------------------- 2.3 OO ----------------------------------------
CREATE PROCEDURE Procedures_ChooseInstructor
	@student_id INT,
	@instructor_id INT,
	@course_id INT
AS
		UPDATE	Student_Course_Instractor_Take
		SET		instructor_id	=	@instructor_id
		WHERE	student_id		=	@student_id
		AND		course_id		=	@course_id
GO
--