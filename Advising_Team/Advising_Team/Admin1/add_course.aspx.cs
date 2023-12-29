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
                if (String.IsNullOrEmpty(t1.Value) || String.IsNullOrEmpty(t2.Value)
                   || String.IsNullOrEmpty(t3.Value) || String.IsNullOrEmpty(t4.Value)
                   || String.IsNullOrEmpty(t5.Value))
                {
                    Response.Write("Please enter all inputs");

                }
                else
                {
                    String themajor = t1.Value;
                    int thesemster = Int16.Parse(t2.Value);
                    int thecredithours = Int16.Parse(t3.Value);
                    String thename = t4.Value;
                    String isoffered = t5.Value;
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand add_course = new SqlCommand("AdminAddingCourse", conn);
                    add_course.CommandType = CommandType.StoredProcedure;
                    add_course.Parameters.Add(new SqlParameter("@major", themajor));
                    add_course.Parameters.Add(new SqlParameter("@semester", thesemster));
                    add_course.Parameters.Add(new SqlParameter("@credit_hrs", thecredithours));
                    add_course.Parameters.Add(new SqlParameter("@name", thename));
                    add_course.Parameters.Add(new SqlParameter("@offered", isoffered));
                    conn.Open();
                    add_course.ExecuteNonQuery();
                }
            }
            catch (Exception error) {
                msg.Text = error.Message;
                msg.Visible = true;
            }


        }
    }
}