using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student
{
    public partial class Makeup_Registration2 : System.Web.UI.Page
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
                    if (Session["user"] == null)
                    {
                        Response.Redirect("Student_Login.aspx");
                        return;
                    }
                    if (!int.TryParse(c_id.Text, out int idIn))
                    {
                        errorMessage.Text = "Invalid Course ID";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                        return;
                    }
                    int sId = (int)Session["user"];
                    bool check = checkEligible(sId, idIn);
                    if (check)
                    {
                        using (SqlCommand registerProc = new SqlCommand("[Procedures_StudentRegisterSecondMakeup]", conn))
                        {
                            registerProc.CommandType = CommandType.StoredProcedure;
                            registerProc.Parameters.Add(new SqlParameter("@StudentID", sId));
                            registerProc.Parameters.Add(new SqlParameter("@courseID", idIn));
                            registerProc.Parameters.Add(new SqlParameter("@studentCurr_sem", GetCurrentSemester()));
                            registerProc.ExecuteNonQuery();
                            successMessage.Text = "You have successfully registered for a second makeup exam in this course";
                            successMessage.Visible = true;
                            errorMessage.Visible = false;
                        }
                    }

                    else
                    {
                        errorMessage.Text = "You are not eligible for second makeup exam in this course";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
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



        public static string GetCurrentSemester()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                using (SqlCommand getSemester = new SqlCommand("SELECT semester_code FROM Semester WHERE CURRENT_TIMESTAMP BETWEEN start_date AND end_date", conn))
                {

                    // ExecuteScalar returns the first column of the first row
                    object result = getSemester.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToString(result);
                    }
                }

                // Handle the case when no semester is found
                throw new InvalidOperationException("Semester not found for the specified student.");
            }
        }
        public static bool checkEligible(int sidIn, int idIn)
        {
            string connStr2 = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            using (SqlConnection conn1 = new SqlConnection(connStr2))
            {
                conn1.Open();
                using (SqlCommand checkProc = new SqlCommand("dbo.[FN_StudentCheckSMEligibility]", conn1))
                {
                    checkProc.CommandType= CommandType.StoredProcedure;
                    SqlParameter sid = new SqlParameter("@StudentID", SqlDbType.Int);
                    SqlParameter cid = new SqlParameter("@CourseID", SqlDbType.Int);
                    cid.Value = idIn;
                    sid.Value = sidIn;
                    checkProc.Parameters.Add(cid);
                    checkProc.Parameters.Add(sid);

                    SqlParameter eligable = new SqlParameter("@eligable", SqlDbType.Bit);
                    eligable.Direction = ParameterDirection.ReturnValue;
                    checkProc.Parameters.Add(eligable);

                    checkProc.ExecuteNonQuery();

                    bool c = Convert.ToBoolean(eligable.Value);
                    return c;
                }


                // Handle the case when no course is found
                throw new InvalidOperationException("Course not found for the specified student.");
            }
        }
    }
}