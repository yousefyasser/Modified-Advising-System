using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Advising_Team.Student.Courses
{
    public partial class Optional_Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // redirect if the session is closed
                if (Session["user"] == null)
                {
                    Response.Redirect("Student_Login.aspx");
                    return;
                }

                using (SqlCommand optionalCoursesProc = new SqlCommand("Procedures_ViewOptionalCourse", conn))
                {
                    int studentId = (int)Session["user"];

                    optionalCoursesProc.CommandType = CommandType.StoredProcedure;
                    optionalCoursesProc.Parameters.Add(new SqlParameter("@StudentID", studentId));
                    optionalCoursesProc.Parameters.Add(new SqlParameter("@current_semester_code", GetCurrentSemester()));

                    SqlDataReader reader = optionalCoursesProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while(reader.Read())
                    {
                        int courseId = reader.GetInt32(reader.GetOrdinal("course_id"));
                        string courseName = reader.GetString(reader.GetOrdinal("name"));
                        TableRow tr = new TableRow();
                        TableCell id = new TableCell();
                        TableCell name = new TableCell();
                        id.Text = courseId.ToString();
                        name.Text = courseName;
                        tr.Cells.Add(id);
                        tr.Cells.Add(name);
                        optionalCourses.Controls.Add(tr);
                    }
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

    }
}