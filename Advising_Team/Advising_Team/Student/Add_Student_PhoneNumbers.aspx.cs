using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student
{
    public partial class Add_Student_PhoneNumbers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect if the session is closed
            if (Session["user"] == null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }
        }

        protected void add_phone(object sender, EventArgs e)
        {
            int studentId = (int)Session["user"];

            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string phoneIn = phones.Text;

                using (SqlCommand phoneProc = new SqlCommand("Procedures_StudentaddMobile", conn))
                {
                    phoneProc.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    phoneProc.Parameters.Add(new SqlParameter("@StudentID", studentId));
                    phoneProc.Parameters.Add(new SqlParameter("@mobile_number", phoneIn));

                    // Execute the stored procedure
                    phoneProc.ExecuteNonQuery();
                }

                successMessage.Text = "Successfully updated your profile with this phone number";
                successMessage.Visible = true;
                errorMessage.Visible = false;
            }
        }
    }
}
