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
    public partial class view_all_details_of_instructors_with_courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand list_Instructors_AssignedCourses = new SqlCommand("select * FROM Instructors_AssignedCourses", conn);
            list_Instructors_AssignedCourses.CommandType = CommandType.Text;
            conn.Open();
            SqlDataReader rdr = list_Instructors_AssignedCourses.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int instructor_id = rdr.GetInt32(rdr.GetOrdinal("instructor_id"));
                String name = rdr.GetString(rdr.GetOrdinal("Instructor"));
                int thecourse_id = rdr.GetInt32(rdr.GetOrdinal("course_id"));
                String coursename = rdr.GetString(rdr.GetOrdinal("Course"));
                Label theinstructorid = new Label();
                theinstructorid.Text = "<br >"+ instructor_id + "<br >";
                Label thename = new Label();
                thename.Text = name + "<br >";
                Label courseid = new Label();
                courseid.Text = thecourse_id + "<br >";
                Label thecoursename = new Label();
                thecoursename.Text = coursename + "<br >";
                Label spacer = new Label();
                spacer.Text = "----------------- ";
                form1.Controls.Add(theinstructorid);
                form1.Controls.Add(thename);
                form1.Controls.Add(courseid);
                form1.Controls.Add(thecoursename);
                form1.Controls.Add(spacer);


            }
            conn.Close();
        }
    }
    
}