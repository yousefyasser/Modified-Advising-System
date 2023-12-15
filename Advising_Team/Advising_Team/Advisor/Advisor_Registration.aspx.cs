using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Advising_Team
{
    public partial class Advisor_Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void advisorImage_Click(object sender, ImageClickEventArgs e)
        {
            // Redirect to another page
            Response.Redirect("~/Student/Student_Login.aspx");
        }

        protected void register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    string nameIn = name.Text;
                    string passwordIn = password.Text;
                    string emailIn = email.Text;
                    string officeIn = office.Text;

                    using (SqlCommand registerProc = new SqlCommand("Procedures_AdvisorRegistration", conn))
                    {
                        registerProc.CommandType = CommandType.StoredProcedure;

                        if (name.Text.Length == 0 || password.Text.Length == 0 || email.Text.Length == 0 || office.Text.Length == 0)
                        {
                            errorMessage.Text = "Error: " + "Please fill in all fields";
                            errorMessage.Visible = true;
                            successMessage.Visible = false;
                            return;
                        }

                        // Add parameters
                        registerProc.Parameters.Add(new SqlParameter("@advisor_name", nameIn));
                        registerProc.Parameters.Add(new SqlParameter("@password", passwordIn));
                        registerProc.Parameters.Add(new SqlParameter("@email", emailIn));
                        registerProc.Parameters.Add(new SqlParameter("@office", officeIn));


                        // Output parameter for advisor_id
                        SqlParameter advisor_id = new SqlParameter("@advisor_id", SqlDbType.Int);
                        advisor_id.Direction = ParameterDirection.Output;
                        registerProc.Parameters.Add(advisor_id);

                        registerProc.ExecuteNonQuery();

                        // Check if advisor_id is not null or DBNull.Value
                        if (advisor_id.Value != null && advisor_id.Value != DBNull.Value)
                        {
                            int advisorIdValue = Convert.ToInt32(advisor_id.Value);

                            successMessage.Text = "Advisor registered successfully. Advisor ID: " + advisorIdValue;
                            successMessage.Visible = true;
                            errorMessage.Visible = false;

                            // Wait for 2 seconds before redirecting to login page
                            string script = "setTimeout(function() { window.location.href = 'Advisor_Login.aspx'; }, 2000);";
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", script, true);
                        }
                        else
                        {
                            errorMessage.Text = "Registration failed. Advisor ID not generated.";
                            errorMessage.Visible = true;
                            successMessage.Visible = false;
                        }
                    }
                }
                catch (Exception ex)
                {
                    errorMessage.Text = "Error: " + ex.Message;
                    errorMessage.Visible = true;
                    successMessage.Visible = false;
                }
            }
        }
    }
}