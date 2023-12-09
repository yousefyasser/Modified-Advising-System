using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Advising_Team
{
    public partial class Student_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void student_login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    if (!int.TryParse(id.Text, out int idIn))
                    {
                        errorMessage.Text = "Invalid Student ID";
                        errorMessage.Visible = true;
                        return;
                    }

                    string passwordIn = password.Text;

                    using (SqlCommand loginFn = new SqlCommand("dbo.FN_StudentLogin", conn))
                    {
                        loginFn.CommandType = CommandType.StoredProcedure;
                        loginFn.Parameters.Add(new SqlParameter("@Student_id", idIn));
                        loginFn.Parameters.Add(new SqlParameter("@password", passwordIn));

                        SqlParameter success = new SqlParameter("@success", SqlDbType.Bit);
                        success.Direction = ParameterDirection.ReturnValue;
                        loginFn.Parameters.Add(success);

                        loginFn.ExecuteNonQuery();

                        bool loginSuccess = Convert.ToBoolean(success.Value);

                        if (loginSuccess)
                        {
                            Session["user"] = idIn;

                            successMessage.Text = "You have successfully logged in";
                            successMessage.Visible = true;
                            errorMessage.Visible = false;

                            // Wait for 1 second before redirecting to home page
                            string script = "setTimeout(function() { window.location.href = 'Available_Courses.aspx'; }, 1000);";
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", script, true);
                        }
                        else
                        {
                            errorMessage.Text = "Please recheck your credentials";
                            errorMessage.Visible = true;
                            successMessage.Visible = false;
                        }
                    }
                }
                catch (Exception ex)
                {
                    errorMessage.Text = "An error occurred: " + ex.Message;
                    errorMessage.Visible = true;
                    successMessage.Visible = false;
                }
            }
        }

        
    }
}