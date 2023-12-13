using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Web.UI;

namespace Advising_Team
{
    public partial class Student_Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    string f_nameIn = f_name.Value;
                    string l_nameIn = l_name.Value;
                    string passwordIn = password.Value;
                    string facultyIn = faculty.Value;
                    string emailIn = email.Value;
                    string majorIn = major.Value;


                    if (!int.TryParse(semester.Value, out int semesterIn))
                    {
                        errorMessage.Text = "Invalid Semester";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }

                    using (SqlCommand registerProc = new SqlCommand("Procedures_StudentRegistration", conn))
                    {
                        registerProc.CommandType = CommandType.StoredProcedure;

                        // Add parameters
                        registerProc.Parameters.Add(new SqlParameter("@first_name", f_nameIn));
                        registerProc.Parameters.Add(new SqlParameter("@last_name", l_nameIn));
                        registerProc.Parameters.Add(new SqlParameter("@password", passwordIn));
                        registerProc.Parameters.Add(new SqlParameter("@faculty", facultyIn));
                        registerProc.Parameters.Add(new SqlParameter("@email", emailIn));
                        registerProc.Parameters.Add(new SqlParameter("@major", majorIn));
                        registerProc.Parameters.Add(new SqlParameter("@Semester", semesterIn));

                        // Output parameter for student_id
                        SqlParameter student_id = new SqlParameter("@Student_id", SqlDbType.Int);
                        student_id.Direction = ParameterDirection.Output;
                        registerProc.Parameters.Add(student_id);

                        registerProc.ExecuteNonQuery();

                        // Check if student_id is not null or DBNull.Value
                        if (student_id.Value != null && student_id.Value != DBNull.Value)
                        {
                            int studentIdValue = Convert.ToInt32(student_id.Value);

                            successMessage.Text = "Student registered successfully. Student ID: " + studentIdValue;
                            successMessage.Visible = true;
                            errorMessage.Visible = false;

                            // Wait for 2 seconds before redirecting to login page
                            string script = "setTimeout(function() { window.location.href = 'Student_Login.aspx'; }, 2000);";
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", script, true);
                        }
                        else
                        {
                            errorMessage.Text = "Registration failed. Student ID not generated.";
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