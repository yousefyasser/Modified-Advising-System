using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student
{
    public partial class Slot_Course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void viewSlot(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
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

                    using (SqlCommand viewProc = new SqlCommand("Select * from dbo.[FN_StudentViewSlot](@CourseID, @InstructorID)", conn))
                    {
                        viewProc.Parameters.Add(new SqlParameter("@CourseID", idIn));
                        viewProc.Parameters.Add(new SqlParameter("@InstructorID", id2In));

                        SqlDataReader reader = viewProc.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            int courseId = reader.GetInt32(reader.GetOrdinal("CourseID"));
                            string courseName = reader.GetString(reader.GetOrdinal("Course"));
                            int code = reader.GetInt32(reader.GetOrdinal("instructor_id"));
                            string insName = reader.GetString(reader.GetOrdinal("Instructor"));
                            int sid = reader.GetInt32(reader.GetOrdinal("slot_id"));
                            string time = reader.GetString(reader.GetOrdinal("time"));
                            string location = reader.GetString(reader.GetOrdinal("location"));
                            string day = reader.GetString(reader.GetOrdinal("day"));
                            TableRow tr = new TableRow();
                            TableCell i_id = new TableCell();
                            TableCell i_name = new TableCell();
                            TableCell c_name = new TableCell();
                            TableCell c_id = new TableCell();
                            TableCell s_id = new TableCell();
                            TableCell s_day = new TableCell();
                            TableCell s_time = new TableCell();
                            TableCell s_location = new TableCell();
                            c_id.Text = courseId.ToString();
                            c_name.Text = courseName;
                            i_name.Text = insName;
                            i_id.Text = code.ToString();
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
                            tr.Cells.Add(i_id);
                            tr.Cells.Add(i_name);
                            slotCourse.Controls.Add(tr);
                        }
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
    }
}