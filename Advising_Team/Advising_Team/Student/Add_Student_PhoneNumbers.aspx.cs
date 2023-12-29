using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

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
                string phoneIn = phones.Value;

                if (checkDuplicatePhones(phoneIn))
                {
                    errorMessage.Text = "Please enter another phone number";
                    errorMessage.Visible = true;
                    successMessage.Visible = false;
                    return;
                }

                using (SqlCommand phoneProc = new SqlCommand("Procedures_StudentaddMobile", conn))
                {
                    phoneProc.CommandType = CommandType.StoredProcedure;

                    // Add parameters
                    phoneProc.Parameters.Add(new SqlParameter("@student_id", studentId));
                    phoneProc.Parameters.Add(new SqlParameter("@phone_number", phoneIn));

                    // Execute the stored procedure
                    phoneProc.ExecuteNonQuery();
                }

                successMessage.Text = "Successfully updated your profile with this phone number";
                successMessage.Visible = true;
                errorMessage.Visible = false;
            }
        }

        protected bool checkDuplicatePhones(string phone)
        {
            int studentId = (int)Session["user"];

            string connStr1 = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn1 = new SqlConnection(connStr1))
            {
                conn1.Open();
                
                using (SqlCommand dupPhone = new SqlCommand("SELECT count(*) FROM Student_Phone WHERE student_id = @studentID AND phone_number = @phone", conn1))
                {
                    dupPhone.Parameters.Add(new SqlParameter("@studentID", studentId));
                    dupPhone.Parameters.Add(new SqlParameter("@phone", phone));
                    int return_count = (int)dupPhone.ExecuteScalar();
                    return return_count != 0;
                }
            }
        }
    }
}
