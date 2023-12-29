using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student.Exams
{
    public partial class Makeup_Registration1 : System.Web.UI.Page
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
                    if (!check)
                    {
                        using (SqlCommand registerProc = new SqlCommand("[Procedures_StudentRegisterFirstMakeup]", conn))
                        {
                            registerProc.CommandType = CommandType.StoredProcedure;
                            registerProc.Parameters.Add(new SqlParameter("@student_id", sId));
                            registerProc.Parameters.Add(new SqlParameter("@course_id", idIn));
                            registerProc.Parameters.Add(new SqlParameter("@current_semester", GetCurrentSemester()));
                            registerProc.ExecuteNonQuery(); 
                            successMessage.Text = "You have successfully registered for a first makeup exam in this course";
                            successMessage.Visible = true;
                            errorMessage.Visible = false;
                        }
                    }

                    else
                    {
                        errorMessage.Text = "You are not eligible for first makeup exam in this course";
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
                using (SqlCommand checkProc = new SqlCommand("", conn1))
                {
                    checkProc.CommandText = " Select student_id from Student_Instructor_Course_take where Student_Instructor_Course_take.student_id = @sid and Student_Instructor_Course_take.course_id= @cid and (Student_Instructor_Course_take.exam_type in ('First_makeup','Second_makeup') or (Student_Instructor_Course_take.exam_type = 'Normal' and Student_Instructor_Course_take.grade not in ('F','FF','null')));\r\n";
                    SqlParameter sid = new SqlParameter("@sid", SqlDbType.Int);
                    SqlParameter cid = new SqlParameter("@cid", SqlDbType.Int);
                    cid.Value = idIn;
                    sid.Value = sidIn;
                    checkProc.Parameters.Add(sid);
                    checkProc.Parameters.Add(cid);

                    bool c = false;
                    SqlDataReader reader = checkProc.ExecuteReader(CommandBehavior.CloseConnection);
                    if (reader.Read())
                    {
                        int code = reader.GetInt32(reader.GetOrdinal("student_id"));
                        if (code == sidIn)
                        {
                            c = true;
                        }
                    }
                    return c;
                }


                // Handle the case when no course is found
                throw new InvalidOperationException("Course not found for the specified student.");
            }
        }
    }
}
            
