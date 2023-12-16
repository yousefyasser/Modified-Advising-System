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

namespace Advising_Team.Admin1
{
    public partial class Link_instructor_to_course_in_certain_slot : System.Web.UI.Page
    {
      
        protected void Button1_Click1(object sender, EventArgs e)

        {
            try
            {
             
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand action = new SqlCommand("Procedures_AdminLinkInstructor", conn);
                    action.CommandType = CommandType.StoredProcedure;
                    action.Parameters.Add(new SqlParameter("@cours_id", t1.Text));
                        action.Parameters.Add(new SqlParameter("@instructor_id", t2.Text));
                    action.Parameters.Add(new SqlParameter("@slot_id", t3.Text));

                    conn.Open();
                    action.ExecuteNonQuery();
                    conn.Close();
                
            }
            catch (Exception Error)
            {
                Response.Write(Error.Message);
            }
        }

      
    }
}