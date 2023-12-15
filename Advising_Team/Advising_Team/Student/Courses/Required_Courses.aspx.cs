using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using static Advising_Team.Student.Courses.Optional_Courses;

namespace Advising_Team.Student.Courses
{
    public partial class Required_Courses : System.Web.UI.Page
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

                using (SqlCommand requiredCoursesProc = new SqlCommand("Procedures_ViewRequiredCourses", conn))
                {
                    int studentId = (int)Session["user"];

                    requiredCoursesProc.CommandType = CommandType.StoredProcedure;
                    requiredCoursesProc.Parameters.Add(new SqlParameter("@StudentID", studentId));
                    requiredCoursesProc.Parameters.Add(new SqlParameter("@current_semester_code", GetCurrentSemester()));

                    SqlDataReader reader = requiredCoursesProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
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
                        RequiredCourses.Controls.Add(tr);
                    }
                }
            }
        }
    }
}