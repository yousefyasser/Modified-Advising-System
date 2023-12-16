using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Policy;

namespace Advising_Team.Admin1
{
    public partial class add_course : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             
        }

        protected void Button1_Click(object sender, EventArgs e)

        {
            try
            {
                if (String.IsNullOrEmpty(t1.Text) || String.IsNullOrEmpty(t2.Text)
                   || String.IsNullOrEmpty(t3.Text) || String.IsNullOrEmpty(t4.Text)
                   || String.IsNullOrEmpty(t5.Text))
                {
                    Response.Write("Please enter all inputs");

                }
                else
                {
                    String themajor = t1.Text;
                    int thesemster = Int16.Parse(t2.Text);
                    int thecredithours = Int16.Parse(t3.Text);
                    String thename = t4.Text;
                    String isoffered = t5.Text;
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand add_course = new SqlCommand("Procedures_AdminAddingCourse", conn);
                    add_course.CommandType = CommandType.StoredProcedure;
                    add_course.Parameters.Add(new SqlParameter("@major", themajor));
                    add_course.Parameters.Add(new SqlParameter("@semester", thesemster));
                    add_course.Parameters.Add(new SqlParameter("@credit_hours", thecredithours));
                    add_course.Parameters.Add(new SqlParameter("@name", thename));
                    add_course.Parameters.Add(new SqlParameter("@is_offered", isoffered));
                    conn.Open();
                    add_course.ExecuteNonQuery();
                }
            }
            catch (Exception error) {
                Response.Write( error.Message );
            }


        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_page.aspx");
        }
    }
}