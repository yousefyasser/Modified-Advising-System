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
                if (String.IsNullOrEmpty(t1.Value) || String.IsNullOrEmpty(t2.Value)
                       || String.IsNullOrEmpty(t3.Value))
                {
                    Response.Write("One of the inputs is null");
                }
                else
                {
                    String thecode = t1.Value;
                    String thestart = t2.Value;
                    String theend = t3.Value;

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
    }
}