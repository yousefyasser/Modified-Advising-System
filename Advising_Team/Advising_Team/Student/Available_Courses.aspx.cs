using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Advising_Team.Student.Student_Optional_Courses;

namespace Advising_Team.Student
{
    public partial class Available_Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();

                // redirect if the session is closed
                if (Session["user"] == null)
                {
                    Response.Redirect("Student_Login.aspx");
                    return;
                }

                using (SqlCommand availableCourses = new SqlCommand("SELECT course_id, name FROM Semster_offered_Courses WHERE semester_code = @curr_sem", conn))
                {
                    availableCourses.Parameters.Add(new SqlParameter("@curr_sem", GetCurrentSemester()));
                    SqlDataReader reader = availableCourses.ExecuteReader(CommandBehavior.CloseConnection);

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
                        AvailableCourses.Controls.Add(tr);
                    }
                }
            }
        }
    }
}