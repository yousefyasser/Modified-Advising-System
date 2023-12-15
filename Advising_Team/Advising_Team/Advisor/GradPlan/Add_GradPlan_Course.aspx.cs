using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Advising_Team.Advisor.GradPlan
{
    public partial class Add_GradPlan_Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect if the session is closed
            if (Session["user"] == null)
            {
                Response.Redirect("../Advisor_Login.aspx");
                return;
            }
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    int advisorId = (int)Session["user"];

                    // Validate Student ID
                    if (!int.TryParse(txtStudentId.Text, out int studentId) || studentId <= 0)
                    {
                        ShowErrorMessage("Invalid Student ID");
                        return;
                    }

                    // Validate Semester Code
                    if (string.IsNullOrWhiteSpace(txtSemesterCode.Text))
                    {
                        ShowErrorMessage("Semester Code is required.");
                        return;
                    }

                    string courseName = txtCourseName.Text;

                    // Validate Course Name
                    if (string.IsNullOrWhiteSpace(courseName))
                    {
                        ShowErrorMessage("Course Name is required.");
                        return;
                    }

                    // Validate that the student belongs to the advisor
                    if (!IsStudentBelongsToAdvisor(conn, advisorId, studentId))
                    {
                        ShowErrorMessage("The provided Student ID does not belong to your Advisor ID.");
                        return;
                    }

                    string semesterCode = txtSemesterCode.Text;

                    if (!IsSemesterCodeValid(conn, semesterCode))
                    {
                        ShowErrorMessage("The provided Semester Code is not valid.");
                        return;
                    }

                    // Validate that the course is valid and belongs to Course table
                    if (!IsCourseValid(conn, courseName))
                    {
                        ShowErrorMessage("The provided Course Name is not valid.");
                        return;
                    }

                    // Validate that the advisor is not inserting a duplicate row
                    if (IsDuplicateCourse(conn, studentId, semesterCode, courseName))
                    {
                        ShowErrorMessage("This course already exists in the Graduation Plan for the specified student and semester.");
                        return;
                    }

                    using (SqlCommand addCourseProc = new SqlCommand("Procedures_AdvisorAddCourseGP", conn))
                    {
                        addCourseProc.CommandType = CommandType.StoredProcedure;
                        addCourseProc.Parameters.Add(new SqlParameter("@student_id", studentId));
                        addCourseProc.Parameters.Add(new SqlParameter("@Semester_code", semesterCode));
                        addCourseProc.Parameters.Add(new SqlParameter("@course_name", courseName));

                        addCourseProc.ExecuteNonQuery();

                        ShowSuccessMessage("Course added to Graduation Plan successfully.");
                    }
                }
                catch (Exception ex)
                {
                    ShowErrorMessage("An error occurred: " + ex.Message);
                }
            }
        }

        private bool IsSemesterCodeValid(SqlConnection conn, string semesterCode)
        {
            using 
                (SqlCommand validateSemesterCode = new SqlCommand
                (
                "SELECT COUNT(*) FROM Semester " +
                "WHERE semester_Code = @semesterCode", 
                conn
                )
                )
            {
                validateSemesterCode.Parameters.AddWithValue("@semesterCode", semesterCode);

                int count = (int)validateSemesterCode.ExecuteScalar();

                // If count is greater than 0, the semester code is valid
                return count > 0;
            }
        }

        private bool IsStudentBelongsToAdvisor(SqlConnection conn, int advisorId, int studentId)
        {
            using 
                (SqlCommand checkStudentAdvisor = new SqlCommand
                (
                "SELECT COUNT(*) FROM Student WHERE advisor_id = @advisorId " +
                "AND student_id = @studentId", 
                conn
                )
                )
            {
                checkStudentAdvisor.Parameters.Add(new SqlParameter("@advisorId", advisorId));
                checkStudentAdvisor.Parameters.Add(new SqlParameter("@studentId", studentId));

                int count = (int)checkStudentAdvisor.ExecuteScalar();

                return count > 0;
            }
        }

        private bool IsCourseValid(SqlConnection conn, string courseName)
        {
            using 
                (SqlCommand validateCourse = new SqlCommand
                (
                "SELECT COUNT(*) FROM Course WHERE course_id = " +
                "(SELECT course_id FROM Course WHERE name = @courseName)", 
                conn
                )
                )
            {
                validateCourse.Parameters.AddWithValue("@courseName", courseName);

                int count = (int)validateCourse.ExecuteScalar();

                // If count is greater than 0, the course is valid
                return count > 0;
            }
        }

        private bool IsDuplicateCourse(SqlConnection conn, int studentId, string semesterCode, string courseName)
        {
            using 
                (SqlCommand checkDuplicateCourse = new SqlCommand
                (
                "SELECT COUNT(*) FROM GradPlan_Course gpc WHERE gpc.semester_code = @semesterCode " +
                "AND gpc.course_id = (SELECT course_id FROM Course WHERE name = @courseName) " +
                "AND gpc.plan_id IN (SELECT plan_id FROM Graduation_Plan " +
                "WHERE student_id = @studentId AND semester_code = @semesterCode)", 
                conn
                )
                )

            {
                checkDuplicateCourse.Parameters.AddWithValue("@studentId", studentId);
                checkDuplicateCourse.Parameters.AddWithValue("@semesterCode", semesterCode);
                checkDuplicateCourse.Parameters.AddWithValue("@courseName", courseName);

                int count = (int)checkDuplicateCourse.ExecuteScalar();

                return count > 0;
            }
        }

        private void ShowSuccessMessage(string message)
        {
            successMessage.Text = message;
            successMessage.Visible = true;
            errorMessage.Visible = false;
        }

        private void ShowErrorMessage(string message)
        {
            errorMessage.Text = message;
            errorMessage.Visible = true;
            successMessage.Visible = false;
        }
    }
}
