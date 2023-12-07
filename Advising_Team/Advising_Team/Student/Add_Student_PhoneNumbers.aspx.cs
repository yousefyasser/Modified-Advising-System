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
            if (!IsPostBack)
            {
                // Check if the StudentID cookie exists
                if (Request.Cookies["StudentID"] != null)
                {
                    // Retrieve the student ID from the cookie
                    int studentId = Convert.ToInt32(Request.Cookies["StudentID"].Value);

                    // Store the student ID in a session variable for future use
                    Session["StudentID"] = studentId;
                }
                else
                {
                    Response.Redirect("Student_Login.aspx");
                }
            }
        }

        protected void add_phone(object sender, EventArgs e)
        {
            // Check if the student ID is available in the session
            if (Session["StudentID"] != null)
            {
                int studentId = Convert.ToInt32(Session["StudentID"]);

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
                }
            }
            else
            {
                Response.Redirect("Student_Login.aspx");
            }
        }
    }
}
