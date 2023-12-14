using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Advising_Team.Student
{
    public partial class Missing_Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using(SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                using (SqlCommand missingCoursesProc= new SqlCommand("Procedures_ViewMS", conn))
                {
                    int studentId = (int)Session["user"];
                    missingCoursesProc.CommandType = CommandType.StoredProcedure;
                    missingCoursesProc.Parameters.Add(new SqlParameter("@StudentID", studentId));

                    SqlDataReader reader = missingCoursesProc.ExecuteReader(CommandBehavior.CloseConnection);
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
                        missingCourses.Controls.Add(tr);
                    }
                }
            }
        }
    }
}