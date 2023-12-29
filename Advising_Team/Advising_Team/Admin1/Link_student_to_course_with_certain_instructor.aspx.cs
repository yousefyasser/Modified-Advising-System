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
    public partial class Link_student_to_course_with_certain_instructor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            {
                try
                {
                 
                    {
                        int the_course_id = Int16.Parse(t1.Value);
                        int the_instructor_id = Int16.Parse(t2.Value);
                        int the_student_id = Int16.Parse(t3.Value);
                        String the_semester_code = t4.Value;



                        string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                        SqlConnection conn = new SqlConnection(connStr);
                        SqlCommand action = new SqlCommand("Procedures_AdminLinkStudent", conn);
                        action.CommandType = CommandType.StoredProcedure;
                        action.Parameters.Add(new SqlParameter("@cours_id", the_course_id));
                       action.Parameters.Add(new SqlParameter("@instructor_id", the_instructor_id));
                        action.Parameters.Add(new SqlParameter("@studentID", the_student_id));
                        action.Parameters.Add(new SqlParameter("@semester_code", the_semester_code));

                        conn.Open();
                        action.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                catch (Exception er) {
                    Response.Write(er.Message);
                }

            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_page.aspx");
        }
    }
}