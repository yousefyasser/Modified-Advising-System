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
    public partial class Courses_Exams : System.Web.UI.Page
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
                using (SqlCommand courseExamProc = new SqlCommand("Select MakeUp_Exam.*, Course.name, Course.semester from MakeUp_Exam inner join Course on MakeUp_Exam.course_id = Course.course_id ", conn))
                {
                    SqlDataReader reader = courseExamProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
                    {
                        int courseId = reader.GetInt32(reader.GetOrdinal("course_id"));
                        string courseName = reader.GetString(reader.GetOrdinal("name"));
                        int code = reader.GetInt32(reader.GetOrdinal("semester"));
                        string types = reader.GetString(reader.GetOrdinal("type"));
                        DateTime date = reader.GetDateTime(reader.GetOrdinal("date"));
                        TableRow tr = new TableRow();
                        TableCell type = new TableCell();
                        TableCell semester = new TableCell();
                        TableCell c_name = new TableCell();
                        TableCell c_id = new TableCell();
                        TableCell dates = new TableCell();
                        c_id.Text = courseId.ToString();
                        c_name.Text = courseName;
                        type.Text = types;
                        semester.Text = code.ToString();
                        dates.Text = date.ToString();                 
                        tr.Cells.Add(c_id);
                        tr.Cells.Add(c_name);
                        tr.Cells.Add(semester);
                        tr.Cells.Add(dates);
                        tr.Cells.Add(type);
                        courseExam.Controls.Add(tr);
                    }
                }
            }

        }
    }
}