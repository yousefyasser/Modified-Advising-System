--------------------------- DUMMY DATA ----------------------------------------

--------------------------- 2.2 A Procedures_StudentRegistration ----------------------------------------
INSERT INTO Student (f_name, l_name, faculty, email, major, pass, semester)
VALUES ('John', 'Doe', 'Computer Science', 'john.doe@email.com', 'Computer Science', 'password123', 5);


INSERT INTO Student (f_name, l_name, faculty, email, major, pass, semester)
VALUES ('Jane', 'Smith', 'Electrical Engineering', 'jane.smith@email.com', 'Electrical Engineering', 'securepass456', 10);

INSERT INTO Student (f_name, l_name, faculty, email, major, pass, semester)
VALUES ('Alex', 'Johnson', 'Biology', 'alex.johnson@email.com', 'Biology', 'pass1234', 3);


INSERT INTO Course ( course_name, major, is_offered, credit_hours, semester)
VALUES 
    ( 'Introduction to Computer Science', 'Computer Science', 1, 3, 1),
        ( 'Introduction to Computer Science', 'Computer Science', 1, 3, 1),
            ( 'Calculus I', 'Mathematics', 0, 4, 2),

    ( 'Calculus II', 'Mathematics', 0, 4, 2),
    ( 'English Composition', 'English', 1, 3, 1),
    ( 'Organic Chemistry', 'Chemistry', 1, 4, 3),
    ( 'Physics I', 'Physics', 1, 4, 1),
    ( 'Physics II', 'Physics', 1, 4, 1);


INSERT INTO preqCourse_course (prerequisite_course_id, course_id)
VALUES (1, 2),
       (3, 4),
       (7, 8)


INSERT INTO Instructor ( instructor_name, email, faculty, office) VALUES
( 'John Smith', 'john.smith@example.com', 'Computer Science', 'Building A, Office 101'),
('Emily Johnson', 'emily.johnson@example.com', 'Mathematics', 'Building B, Office 202'),
( 'Michael Davis', 'michael.davis@example.com', 'English Literature', 'Building C, Office 303'),
( 'Sarah Wilson', 'sarah.wilson@example.com', 'Physics', 'Building D, Office 404'),
( 'David Brown', 'david.brown@example.com', 'Chemistry', 'Building E, Office 505');


INSERT INTO Instructor_Course (course_id, instructor_id)
VALUES 
  (2, 1),
  (1, 1),
  (3, 2),
  (4, 3),
  (5,2);

 INSERT INTO Payment (payment_amount, payment_deadline, n_installments, payment_status, fund_percentage, s_date, student_id, semester_code)
VALUES
(4500, '2023-04-28', 3, 'notPaid', 0.4, '2023-01-20', 3, 'W23'),
(2800, '2023-12-15', 2, 'notPaid', 0.25, '2023-10-01', 2, 'S23'),
(6000, '2023-07-31', 4, 'notPaid', 0.6, '2023-03-01', 1, 'W23')
---(3200, '2023-11-30', 2, 'notPaid', 0.35, '2023-11-01', 6, '2023Fall'),
--(5500, '2023-04-30', 3, 'notPaid', 0.45, '2023-04-01', 7, '2023Spring'),
--(4000, '2023-12-15', 2, 'notPaid', 0.3, '2023-12-01', 8, '2023Fall'),
--(4800, '2023-05-15', 3, 'notPaid', 0.5, '2023-05-01', 9, '2023Spring'),
--(3000, '2023-12-31', 2, 'notPaid', 0.2, '2023-12-01', 10, '2023Fall');




INSERT INTO Slot (slot_day, slot_time, slot_location, course_id, instructor_id)
VALUES
('Wednesday', '02:00 PM - 04:00 PM', 'Room B', 2,1),
('Tuesday', '09:00 AM - 11:00 AM', 'Room C', 3, 2),
('Thursday', '01:00 PM - 03:00 PM', 'Room D', 4, 3),
('Friday', '03:00 PM - 05:00 PM', 'Room E', 5, 2)






INSERT INTO Semester (semester_code, s_date, end_date)
VALUES
('W23', '2023-01-15', '2023-05-15'),
('S23', '2023-09-01', '2023-12-20')

INSERT INTO Student_Instructor_Course_Take (student_id, course_id, instructor_id, semester_code, exam_type, grade)
VALUES
(1, 1, 1, 'W23', 'Normal', 'A'),
(2, 2, 2, 'S23', 'Normal', 'B+')
-- ... (8 more records)

INSERT INTO Course_Semester (course_id, semester_code)
VALUES
(1, 'S23'),
(2, 'W23')

Declare @id int
EXEC Procedures_StudentRegistration 'JACK', 'AM', 'Engineering', 'jane.ith@email.com', 'Engineering', 'epas456', 10, @id output;
Print @id

INSERT INTO Advisor ( advisor_name, email, office, pass) VALUES
( 'MOHAMED Smith', 'john@example.com', 'Office1', 'password1'),
('Sarah Adams', 'sarah@example.com', 'Office2', 'password2'),
( 'Lisa Johnson', 'lisa@example.com', 'Office3', 'password3'),
( 'James Brown', 'james@example.com', 'Office4', 'password4'),
( 'Emily Davis', 'emily@example.com', 'Office5', 'password5'),
('Michael Lee', 'michael@example.com', 'Office6', 'password6');






Declare @aid int
exec Procedures_AdvisorRegistration 'Sarah mahmoud', 'sara1h@example.com', 'Office5', 'password10', @aid output
print @aid


exec Procedures_AdminListStudents

exec Procedures_AdminLinkStudentToAdvisor 5,7


exec AdminAddingSemester  'W24', '2024-01-15', '2024-05-15'
exec AdminAddingCourse   'Computer', 8, 3,'Introduction to Computer', 1

exec Procedures_AdminLinkStudent 6,2,6,'W23'
EXEC Procedures_AdminAddExam 'First_makeup', '2023-05-17', 5
exec Procedures_AdminIssueInstallment 4
exec Procedures_AdminDeleteCourse 6
exec Procedure_AdminUpdateStudentStatus 1
exec Procedures_AdminDeleteSlots 'W23'


declare @xoxo bit
set @xoxo = dbo.FN_AdvisorLogin(1,'password1')
print @xoxo

Procedures_AdvisorCreateGP


