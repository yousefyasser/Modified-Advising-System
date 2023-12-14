using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Advising_Team.Advisor
{
    public partial class Approve_Reject_Course_Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the session is closed
            if (Session["user"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
                return;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Validate that Request ID is provided
                    if (!int.TryParse(txtReqID.Text, out int requestID) || requestID <= 0)
                    {
                        ShowErrorMessage("Invalid Request ID.");
                        return;
                    }

                    // Validate that Current Semester is provided
                    string currentSemester = currSem.Text;
                    if (string.IsNullOrWhiteSpace(currentSemester))
                    {
                        ShowErrorMessage("Please enter the current semester.");
                        return;
                    }

                    // Perform the approval or rejection using the stored procedure
                    using (SqlCommand approvalProc = new SqlCommand("Procedures_AdvisorApproveRejectCourseRequest", conn))
                    {
                        approvalProc.CommandType = CommandType.StoredProcedure;

                        approvalProc.Parameters.Add(new SqlParameter("@requestID", requestID));
                        approvalProc.Parameters.Add(new SqlParameter("@current_semester_code", currentSemester));

                        approvalProc.ExecuteNonQuery();
                    }

                    // Display success message
                    ShowSuccessMessage("Course request processed successfully.");

                }
                catch (Exception ex)
                {
                    // Display error message
                    ShowErrorMessage("An error occurred: " + ex.Message);
                }
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
