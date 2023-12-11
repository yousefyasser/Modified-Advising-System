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
    public partial class Instructor_Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void chooseInstructor(object sender, EventArgs e)
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
                        return;
                    }
                    if (!int.TryParse(i_id.Text, out int id2In))
                    {
                        errorMessage.Text = "Invalid Instructor ID";
                        errorMessage.Visible = true;
                        return;
                    }
                    int sId = (int)Session["user"];
                    bool c = checkOk(idIn,id2In);
                    bool c2 = checkOk2(idIn,sId);

                    if (c & c2)
                    {
                        using (SqlCommand chooseProc = new SqlCommand("[Procedures_Chooseinstructor]", conn))
                        {
                            chooseProc.CommandType = CommandType.StoredProcedure;
                            chooseProc.Parameters.Add(new SqlParameter("@StudentID", sId));
                            chooseProc.Parameters.Add(new SqlParameter("@instrucorID", id2In));
                            chooseProc.Parameters.Add(new SqlParameter("@CourseID", idIn));
                            chooseProc.Parameters.Add(new SqlParameter("@current_semester_code", GetCurrentSemester()));
                            chooseProc.ExecuteNonQuery();
                            successMessage.Text = "Successful Operation";
                            successMessage.Visible = true;
                            errorMessage.Visible = false;

                        }
                    }
                    else if(!c2)
                    {
                        errorMessage.Text = "You don't take this course.";
                        errorMessage.Visible = true;
                        successMessage.Visible = false;
                    }
                    else
                    {
                        errorMessage.Text = "This instructor doesn't teach the course. Please choose again.";
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
        public static bool checkOk(int idIn, int id2In)
        {
            string connStr4 = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            using (SqlConnection conn3 = new SqlConnection(connStr4))
            {
                conn3.Open();
                using (SqlCommand checkProc = new SqlCommand("", conn3))
                {
                    checkProc.CommandText = "Select instructor_id from Instructor_Course where course_id = @id ";
                    SqlParameter id = new SqlParameter("@id", SqlDbType.Int);
                    id.Value = idIn;
                    checkProc.Parameters.Add(id);
                    bool c = false;
                    SqlDataReader reader = checkProc.ExecuteReader(CommandBehavior.CloseConnection);
                    if (reader.Read())
                    {
                        int code = reader.GetInt32(reader.GetOrdinal("instructor_id"));
                        if (code == id2In)
                        {
                            c = true;
                        }
                    }
                    return c;
                }


                // Handle the case when no instructor is found
                throw new InvalidOperationException("Instructor not found for the specified course.");
            }
        }
            public static bool checkOk2(int idIn, int sidIn)
            {
                string connStr2 = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                using (SqlConnection conn1 = new SqlConnection(connStr2))
                {
                    conn1.Open();
                    using (SqlCommand checkProc = new SqlCommand("", conn1))
                    {
                        checkProc.CommandText = "Select course_id from Students_Courses_transcript where course_id = @id and student_id=@sid ";
                        SqlParameter id = new SqlParameter("@id", SqlDbType.Int);
                        SqlParameter sid = new SqlParameter("@sid", SqlDbType.Int);
                        id.Value = idIn;
                        sid.Value = sidIn;
                        checkProc.Parameters.Add(id);
                        checkProc.Parameters.Add(sid);

                        bool c = false;
                        SqlDataReader reader = checkProc.ExecuteReader(CommandBehavior.CloseConnection);
                        if (reader.Read())
                        {
                            int code = reader.GetInt32(reader.GetOrdinal("course_id"));
                            if (code == idIn)
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