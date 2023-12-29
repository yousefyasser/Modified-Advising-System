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
    public partial class Link_student_to_advisor : System.Web.UI.Page
    {
      
     

        protected void Button1_Click(object sender, EventArgs e)

        {
            try
            {
                if (String.IsNullOrEmpty(t1.Value)
                              || String.IsNullOrEmpty(t2.Value))
                {
                    Response.Write("please enter all inputs");
                }
                else
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand action = new SqlCommand("Procedures_AdminLinkStudentToAdvisor", conn);
                   action.CommandType = CommandType.StoredProcedure;
                    action .Parameters.Add(new SqlParameter("@studentID", t1.Value));
                    action.Parameters.Add(new SqlParameter("@advisorID", t2.Value));

                    conn.Open();
                    action.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception error)
            {
                Response.Write(error.Message);
                    }
            }
            

        
    }
}