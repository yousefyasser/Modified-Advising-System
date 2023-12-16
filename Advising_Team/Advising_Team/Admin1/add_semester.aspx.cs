using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Web.Caching;

namespace Advising_Team.Admin1
{
    public partial class add_semester : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(t1.Text) || String.IsNullOrEmpty(t2.Text)
                       || String.IsNullOrEmpty(t3.Text))
                {
                    Response.Write("One of the inputs is null");
                }
                else
                {
                    String thecode = t1.Text;
                    String thestart = t2.Text;
                    String theend = t3.Text;

                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand add_sem = new SqlCommand("AdminAddingSemester", conn);
                    add_sem.CommandType = CommandType.StoredProcedure;
                    add_sem.Parameters.Add(new SqlParameter("@end_date", theend));
                    add_sem.Parameters.Add(new SqlParameter("@start_date", thestart));
                    add_sem.Parameters.Add(new SqlParameter("@semester_code", thecode));
                    conn.Open();
                    add_sem.ExecuteNonQuery();
                }
            }
            catch   (Exception error) {
                Response.Write( error.Message);


            }

            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_page.aspx"); // lazem t8iyar hena el web form esm 
        }
    }
}