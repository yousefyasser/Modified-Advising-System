using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Advising_Team.Advisor
{
    public partial class Delete_GradPlan_Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect if the session is closed
            if (Session["user"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
                return;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    int advisorId = (int)Session["user"];

                    // Validate Student ID
                    if (!int.TryParse(txtStudentID.Text, out int studentID) || studentID <= 0)
                    {
                        ShowErrorMessage("Invalid Student ID.");
                        return;
                    }

                    // Validate Semester Code
                    if (string.IsNullOrWhiteSpace(txtSemesterCode.Text))
                    {
                        ShowErrorMessage("Semester Code is required.");
                        return;
                    }
                    string semesterCode = txtSemesterCode.Text;

                    // Validate Course ID
                    if (!int.TryParse(txtCourseID.Text, out int courseID) || courseID <= 0)
                    {
                        ShowErrorMessage("Invalid Course ID.");
                        return;
                    }

                    // Validate that the student belongs to the advisor
                    if (!IsStudentBelongsToAdvisor(conn, advisorId, studentID))
                    {
                        ShowErrorMessage("The provided Student ID does not belong to your Advisor ID.");
                        return;
                    }
                    // Validate that Semester Code is correct
                    if (!IsSemesterCodeValid(conn, semesterCode))
                    {
                        ShowErrorMessage("The provided Semester Code is not valid.");
                        return;
                    }

                    // Validate that the course is valid and belongs to the Course table
                    if (!IsCourseValid(conn, courseID))
                    {
                        ShowErrorMessage("The provided Course ID is not valid.");
                        return;
                    }

                    // Validate if the student has a record in the Graduation_Plan table
                    if (!HasGraduationPlanRecord(conn, studentID, semesterCode))
                    {
                        ShowErrorMessage("The specified student does not have a record in the Graduation Plan table.");
                        return;
                    }

                    // Validate if the student has the specified course in the GradPlan_Course table
                    if (!HasCourseInGradPlan(conn, studentID, semesterCode, courseID))
                    {
                        ShowErrorMessage("The specified student does not have the specified course in their Graduation Plan.");
                        return;
                    }

                    // Perform the deletion using the stored procedure
                    using (SqlCommand deleteProc = new SqlCommand("Procedures_AdvisorDeleteFromGP", conn))
                    {
                        deleteProc.CommandType = CommandType.StoredProcedure;

                        deleteProc.Parameters.Add(new SqlParameter("@studentID", studentID));
                        deleteProc.Parameters.Add(new SqlParameter("@sem_code", semesterCode));
                        deleteProc.Parameters.Add(new SqlParameter("@courseID", courseID));

                        deleteProc.ExecuteNonQuery();
                    }

                    // Display success message
                    ShowSuccessMessage("Course deleted from Graduation Plan successfully.");
                }
                catch (Exception ex)
                {
                    ShowErrorMessage("An error occurred: " + ex.Message);
                }
            }
        }

        private bool HasCourseInGradPlan(SqlConnection conn, int studentID, string semesterCode, int courseID)
        {
            using (SqlCommand checkCourseInGradPlan = new SqlCommand(
                "SELECT COUNT(*) FROM GradPlan_Course " +
                "WHERE plan_id IN (SELECT plan_id FROM Graduation_Plan WHERE student_id = @studentId AND semester_code = @semesterCode) " +
                "AND semester_code = @semesterCode " +
                "AND course_id = @courseID",
                conn))
            {
                checkCourseInGradPlan.Parameters.AddWithValue("@studentId", studentID);
                checkCourseInGradPlan.Parameters.AddWithValue("@semesterCode", semesterCode);
                checkCourseInGradPlan.Parameters.AddWithValue("@courseID", courseID);

                int count = (int)checkCourseInGradPlan.ExecuteScalar();

                return count > 0;
            }
        }

        private bool IsCourseValid(SqlConnection conn, int courseID)
        {
            using (SqlCommand validateCourse = new SqlCommand("SELECT COUNT(*) FROM Course WHERE course_id = @courseID", conn))
            {
                validateCourse.Parameters.AddWithValue("@courseID", courseID);

                int count = (int)validateCourse.ExecuteScalar();

                // If count is greater than 0, the course is valid
                return count > 0;
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

        private bool HasGraduationPlanRecord(SqlConnection conn, int studentId, string semesterCode)
        {
            using (SqlCommand checkGraduationPlan = new SqlCommand("SELECT COUNT(*) FROM Graduation_Plan WHERE student_id = @studentId AND semester_code = @semesterCode", conn))
            {
                checkGraduationPlan.Parameters.AddWithValue("@studentId", studentId);
                checkGraduationPlan.Parameters.AddWithValue("@semesterCode", semesterCode);

                int count = (int)checkGraduationPlan.ExecuteScalar();

                return count > 0;
            }
        }

        private bool IsStudentBelongsToAdvisor(SqlConnection conn, int advisorId, int studentId)
        {
            using (SqlCommand checkStudentAdvisor = new SqlCommand("SELECT COUNT(*) FROM Student WHERE advisor_id = @advisorId AND student_id = @studentId", conn))
            {
                checkStudentAdvisor.Parameters.Add(new SqlParameter("@advisorId", advisorId));
                checkStudentAdvisor.Parameters.Add(new SqlParameter("@studentId", studentId));

                int count = (int)checkStudentAdvisor.ExecuteScalar();

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
