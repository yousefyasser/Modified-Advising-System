using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Advising_Team.Admin2
{
    public partial class AdminDeleteCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void RemoveCourse(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            

            if (int.TryParse(course_id.Value, out int crs_id))
            {
                SqlCommand deleteCrs = new SqlCommand("Procedures_AdminDeleteCourse", conn);
                deleteCrs.CommandType = CommandType.StoredProcedure;
                deleteCrs.Parameters.Add(new SqlParameter("@courseID", crs_id));

                conn.Open();
                int rowsAffected = deleteCrs.ExecuteNonQuery();
                conn.Close();

                if (rowsAffected > 0)
                {
                    msg.Text = "course deleted";
                }
                else
                {
                    msg.Text = "course not found";
                }
            }
            else
            {
                msg.Text = "course ID must be an integer";
            }

            msg.Visible = true;
        }
    }
}