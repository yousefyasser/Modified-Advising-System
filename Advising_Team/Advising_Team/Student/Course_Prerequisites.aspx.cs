using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Advising_Team.Student
{
    public partial class Course_Prerequisites : System.Web.UI.Page
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
            using (SqlCommand coursePrereqProc = new SqlCommand("Select * from view_Course_prerequisites ", conn))
            {
                SqlDataReader reader = coursePrereqProc.ExecuteReader(CommandBehavior.CloseConnection);

                while (reader.Read())
                {
                    int courseId = reader.GetInt32(reader.GetOrdinal("course_id"));
                    string courseName = reader.GetString(reader.GetOrdinal("name"));
                    int code = reader.GetInt32(reader.GetOrdinal("preRequsite_course_id"));
                    string prereq = reader.GetString(reader.GetOrdinal("preRequsite_course_name"));
                    TableRow tr = new TableRow();
                    TableCell p_id = new TableCell();
                    TableCell p_name = new TableCell();
                    TableCell c_name = new TableCell();
                    TableCell c_id = new TableCell();
                    c_id.Text = courseId.ToString();
                    c_name.Text = courseName;
                    p_name.Text = prereq;
                    p_id.Text = code.ToString();
                    tr.Cells.Add(c_id);
                    tr.Cells.Add(c_name);
                    tr.Cells.Add(p_id);
                    tr.Cells.Add(p_name);
                    coursePrereq.Controls.Add(tr);
                }
            }
        }
    }
    }
}