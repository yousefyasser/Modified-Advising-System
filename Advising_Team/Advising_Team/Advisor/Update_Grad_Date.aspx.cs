using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Advising_Team.Advisor
{
    public partial class Update_Grad_Date : System.Web.UI.Page
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

        protected void btnUpdate_Click(object sender, EventArgs e)
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

                    // Validate Expected Graduation Date
                    DateTime expectedGradDate;
                    if (!DateTime.TryParse(txtExpectedGradDate.Text, out expectedGradDate) || expectedGradDate < DateTime.Now.Date)
                    {
                        ShowErrorMessage("Invalid Expected Graduation Date. Please select a valid future date.");
                        return;
                    }

                    // Validate that the student belongs to the advisor
                    if (!IsStudentBelongsToAdvisor(conn, advisorId, studentID))
                    {
                        ShowErrorMessage("The provided Student ID does not belong to your Advisor ID.");
                        return;
                    }

                    // Validate if the student has a record in the Graduation_Plan table
                    if (!HasGraduationPlanRecord(conn, studentID))
                    {
                        ShowErrorMessage("The specified student does not have a record in the Graduation Plan table.");
                        return;
                    }

                    // Perform the update using the stored procedure
                    using (SqlCommand updateProc = new SqlCommand("Procedures_AdvisorUpdateGP", conn))
                    {
                        updateProc.CommandType = CommandType.StoredProcedure;

                        updateProc.Parameters.Add(new SqlParameter("@expected_grad_date", expectedGradDate));
                        updateProc.Parameters.Add(new SqlParameter("@studentID", studentID));

                        updateProc.ExecuteNonQuery();
                    }

                    // Display success message
                    ShowSuccessMessage("Expected Graduation Date updated successfully.");
                }
                catch (Exception ex)
                {
                    ShowErrorMessage("An error occurred: " + ex.Message);
                }
            }
        }

        private bool HasGraduationPlanRecord(SqlConnection conn, int studentID)
        {
            using (SqlCommand checkGraduationPlan = new SqlCommand("SELECT COUNT(*) FROM Graduation_Plan WHERE student_id = @studentId", conn))
            {
                checkGraduationPlan.Parameters.AddWithValue("@studentId", studentID);

                int count = (int)checkGraduationPlan.ExecuteScalar();

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
