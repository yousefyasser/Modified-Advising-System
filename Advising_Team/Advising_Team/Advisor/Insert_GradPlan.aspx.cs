using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Advising_Team.Advisor
{
    public partial class Insert_GradPlan : System.Web.UI.Page
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

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    int advisorId = (int)Session["user"];

                    // Validate Semester Code
                    if (string.IsNullOrWhiteSpace(txtSemesterCode.Text))
                    {
                        errorMessage.Text = "Semester Code is required.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }
                    string semesterCode = txtSemesterCode.Text;

                    if (!IsSemesterCodeValid(conn, semesterCode))
                    {
                        errorMessage.Text = "The provided Semester Code is not valid.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }

                    // Validate Expected Graduation Date
                    if (string.IsNullOrWhiteSpace(txtExpectedGradDate.Text))
                    {
                        errorMessage.Text = "Expected Graduation Date is required.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }

                    // Validate Advisor ID
                    if (!int.TryParse(txtAdvisorId.Text, out advisorId) || advisorId <= 0)
                    {
                        errorMessage.Text = "Invalid Advisor ID.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }

                    // Validate Student ID
                    if (!int.TryParse(txtStudentId.Text, out int studentId) || studentId <= 0)
                    {
                        errorMessage.Text = "Invalid Student ID.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }

                    // Validate that the student belongs to the advisor
                    if (!IsStudentBelongsToAdvisor(conn, advisorId, studentId))
                    {
                        errorMessage.Text = "The provided Student ID does not belong to the specified Advisor ID.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }

                    // Validate expected grad date
                    DateTime selectedDate;
                    if (!DateTime.TryParse(txtExpectedGradDate.Text, out selectedDate) || selectedDate < DateTime.Now.Date)
                    {
                        errorMessage.Text = "Invalid Expected Graduation Date. Please select a valid future date.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }
                    // Validate if there is a duplicate grad plan 
                    if (IsGraduationPlanDuplicate(conn, semesterCode, advisorId, studentId))
                    {
                        errorMessage.Text = "The provided Graduation Plan already exists for the specified Advisor and Student.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }
                    // Validate that the student has enough acquired hours 
                    if (!HasEnoughAcquiredHours(conn, studentId))
                    {
                        errorMessage.Text = "The student does not have enough acquired hours (>=157) to create a Graduation Plan.";
                        errorMessage.Visible = true;
                        return;
                    }

                    // Perform the insertion using the stored procedure
                    using (SqlCommand insertProc = new SqlCommand("Procedures_AdvisorCreateGP", conn))
                    {
                        insertProc.CommandType = CommandType.StoredProcedure;

                        insertProc.Parameters.Add(new SqlParameter("@Semester_code", txtSemesterCode.Text));
                        insertProc.Parameters.Add(new SqlParameter("@expected_graduation_date", DateTime.Parse(txtExpectedGradDate.Text)));
                        insertProc.Parameters.Add(new SqlParameter("@sem_credit_hours", int.Parse(txtSemCreditHours.Text)));
                        insertProc.Parameters.Add(new SqlParameter("@advisor_id", advisorId));
                        insertProc.Parameters.Add(new SqlParameter("@student_id", studentId));

                        insertProc.ExecuteNonQuery();
                    }

                    // Display success message
                    successMessage.Text = "Graduation Plan inserted successfully.";
                    successMessage.Visible = true;
                    errorMessage.Visible = false;

                    // You can redirect or perform additional actions after a successful insertion
                }
                catch (Exception ex)
                {
                    errorMessage.Text = "An error occurred: " + ex.Message;
                    errorMessage.Visible = true;
                    successMessage.Visible = false;
                }
            }
        }

        private bool HasEnoughAcquiredHours(SqlConnection conn, int studentId)
        {
            using (SqlCommand checkAcquiredHours = new SqlCommand("SELECT acquired_hours FROM Student WHERE student_id = @studentId", conn))
            {
                checkAcquiredHours.Parameters.AddWithValue("@studentId", studentId);

                int acquiredHours = (int)checkAcquiredHours.ExecuteScalar();

                // Check if the student has acquired enough hours
                return acquiredHours >= 157;
            }
        }

        private bool IsGraduationPlanDuplicate(SqlConnection conn, string semesterCode, int advisorId, int studentId)
        {
            using (SqlCommand checkDuplicate = new SqlCommand("SELECT COUNT(*) FROM Graduation_Plan WHERE semester_code = @semesterCode AND advisor_id = @advisorId AND student_id = @studentId", conn))
            {
                checkDuplicate.Parameters.AddWithValue("@semesterCode", semesterCode);
                checkDuplicate.Parameters.AddWithValue("@advisorId", advisorId);
                checkDuplicate.Parameters.AddWithValue("@studentId", studentId);

                int count = (int)checkDuplicate.ExecuteScalar();

                // If count is greater than 0, a duplicate graduation plan exists
                return count > 0;
            }
        }

        private bool IsSemesterCodeValid(SqlConnection conn, string semesterCode)
        {
            using (SqlCommand validateSemesterCode = new SqlCommand("SELECT COUNT(*) FROM Semester WHERE semester_Code = @semesterCode", conn))
            {
                validateSemesterCode.Parameters.AddWithValue("@semesterCode", semesterCode);

                int count = (int)validateSemesterCode.ExecuteScalar();

                // If count is greater than 0, the semester code is valid
                return count > 0;
            }
        }

        // Function to check if the student belongs to the advisor
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
    }
}
