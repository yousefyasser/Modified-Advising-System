using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Advising_Team.Student
{
    public partial class CreditHour_Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }
        }

        protected void SendCreditHourRequest(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (!int.TryParse(creditHours.Value, out int creditHoursIn))
                {
                    errorMessage.Text = "Invalid Credit Hours";
                    errorMessage.Visible = true;
                    successMessage.Visible = false;
                    return;
                }

                int studentId = (int)Session["user"];
                string commentIn = comment.Value;

                using (SqlCommand creditHourRequestProc = new SqlCommand("Procedures_StudentSendingCHRequest", conn))
                {
                    creditHourRequestProc.CommandType = CommandType.StoredProcedure;
                    creditHourRequestProc.Parameters.Add(new SqlParameter("@credit_hours", creditHoursIn));
                    creditHourRequestProc.Parameters.Add(new SqlParameter("@student_id", studentId));
                    creditHourRequestProc.Parameters.Add(new SqlParameter("@type", "credit hours"));
                    creditHourRequestProc.Parameters.Add(new SqlParameter("@comment", commentIn));

                    creditHourRequestProc.ExecuteNonQuery();

                    // display changes to web page
                    successMessage.Text = "Credit Hour Request was sent successfully!";
                    successMessage.Visible = true;
                    errorMessage.Visible = false;
                    creditHours.Value = "";
                    comment.Value = "";
                }
            }
        }
    }
}