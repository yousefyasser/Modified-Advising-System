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

namespace Advising_Team.Advisor
{
    public partial class Advisor_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void advisor_login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    if (!int.TryParse(id.Text, out int idIn))
                    {
                        errorMessage.Text = "Invalid Advisor ID";
                        errorMessage.Visible = true;
                        return;
                    }

                    string passwordIn = password.Text;

                    using (SqlCommand loginFn = new SqlCommand("dbo.FN_AdvisorLogin", conn))
                    {
                        loginFn.CommandType = CommandType.StoredProcedure;

                        if (id.Text.Length == 0 || password.Text.Length == 0)
                        {
                            errorMessage.Text = "Error: " + "Please fill in all fields";
                            errorMessage.Visible = true;
                            successMessage.Visible = false;
                            return;
                        }

                        if (idIn == -1 && passwordIn == "admin")
                        {
                            Session["admin"] = true;

                            successMessage.Text = "Welcome Boss";
                            successMessage.Visible = true;
                            errorMessage.Visible = false;

                            // Wait for 1 second before redirecting
                            string script = "setTimeout(function() { window.location.href = 'Advisors.aspx'; }, 1000);";
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", script, true);
                            return;
                        }
                        else
                        {
                            Session["admin"] = false;
                        }

                        loginFn.Parameters.Add(new SqlParameter("@advisor_Id", idIn));
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
                            string script = "setTimeout(function() { window.location.href = 'All_Options.aspx'; }, 1000);";
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