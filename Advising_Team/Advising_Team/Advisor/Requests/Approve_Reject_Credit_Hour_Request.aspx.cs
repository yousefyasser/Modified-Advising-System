﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Advisor.Requests
{
    public partial class Approve_Reject_Credit_Hour_Request : System.Web.UI.Page
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Validate that Request ID is provided
                    if (!int.TryParse(txtReqID1.Text, out int requestID) || requestID <= 0)
                    {
                        ShowErrorMessage("Invalid Request ID.");
                        return;
                    }

                    // Validate that Current Semester is provided
                    string currentSemester = currSem1.Text;
                    if (string.IsNullOrWhiteSpace(currentSemester))
                    {
                        ShowErrorMessage("Please enter the current semester.");
                        return;
                    }

                    // Perform the approval or rejection using the stored procedure
                    using (SqlCommand approvalProc = new SqlCommand("Procedures_AdvisorApproveRejectCHRequest", conn))
                    {
                        approvalProc.CommandType = CommandType.StoredProcedure;

                        approvalProc.Parameters.Add(new SqlParameter("@request_id", requestID));
                        approvalProc.Parameters.Add(new SqlParameter("@current_semester", currentSemester));

                        approvalProc.ExecuteNonQuery();
                    }

                    // Display success message
                    ShowSuccessMessage("Credit Hour request processed successfully.");

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