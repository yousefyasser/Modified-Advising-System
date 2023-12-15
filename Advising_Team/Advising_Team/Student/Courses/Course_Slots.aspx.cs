using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student.Courses
{
    public partial class Course_Slots : System.Web.UI.Page
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
                using (SqlCommand courseSlotsProc = new SqlCommand("Select Course.course_id as CourseID , Course.name As Course, Slot.*, Instructor.name as Instructor\r\nfrom Course inner join Slot on Course.course_id = Slot.course_id\r\ninner join Instructor on Slot.instructor_id = Instructor.instructor_id ", conn))
                {
                    SqlDataReader reader = courseSlotsProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
                    {
                        int courseId = reader.GetInt32(reader.GetOrdinal("CourseID"));
                        string courseName = reader.GetString(reader.GetOrdinal("Course"));
                        int code = reader.GetInt32(reader.GetOrdinal("instructor_id"));
                        string prereq = reader.GetString(reader.GetOrdinal("Instructor"));
                        int sid = reader.GetInt32(reader.GetOrdinal("slot_id"));
                        string time = reader.GetString(reader.GetOrdinal("time"));
                        string location = reader.GetString(reader.GetOrdinal("location"));
                        string day = reader.GetString(reader.GetOrdinal("day"));
                        TableRow tr = new TableRow();
                        TableCell p_id = new TableCell();
                        TableCell p_name = new TableCell();
                        TableCell c_name = new TableCell();
                        TableCell c_id = new TableCell();
                        TableCell s_id = new TableCell();
                        TableCell s_day = new TableCell();
                        TableCell s_time = new TableCell();
                        TableCell s_location = new TableCell();
                        c_id.Text = courseId.ToString();
                        c_name.Text = courseName;
                        p_name.Text = prereq;
                        p_id.Text = code.ToString();
                        s_id.Text = sid.ToString();
                        s_day.Text = day;
                        s_time.Text = time;
                        s_location.Text = location;
                        tr.Cells.Add(c_id);
                        tr.Cells.Add(c_name);
                        tr.Cells.Add(s_id);
                        tr.Cells.Add(s_day);
                        tr.Cells.Add(s_time);
                        tr.Cells.Add(s_location);
                        tr.Cells.Add(p_id);
                        tr.Cells.Add(p_name);
                        courseSlots.Controls.Add(tr);
                    }
                }
            }
        }
    }
}