using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Admin1
{
    public partial class view_semester_along_with_their_courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand list_Instructors_AssignedCourses = new SqlCommand("select * FROM Semster_offered_Courses", conn);
            list_Instructors_AssignedCourses.CommandType = CommandType.Text;
            conn.Open();
            SqlDataReader rdr = list_Instructors_AssignedCourses.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                int thecourse_id = rdr.GetInt32(rdr.GetOrdinal("course_id"));
                String coursename = rdr.GetString(rdr.GetOrdinal("name"));
                String semestercode = rdr.GetString(rdr.GetOrdinal("semester_code"));


                Label courseid = new Label();
                courseid.Text = "<br >" + thecourse_id + "<br >";
                Label thecoursename = new Label();
                thecoursename.Text = coursename + "<br >";
                Label thesemecode = new Label();
                thesemecode.Text = semestercode + "<br >";
                Label spacer = new Label();
                spacer.Text = "----------------- ";


                form1.Controls.Add(courseid);
                form1.Controls.Add(thecoursename);
                form1.Controls.Add(thesemecode);
                form1.Controls.Add(spacer);
            }
        }
    }
}