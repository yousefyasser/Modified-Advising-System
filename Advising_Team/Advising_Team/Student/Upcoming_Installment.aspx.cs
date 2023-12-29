using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student
{
    public partial class Upcoming_Installment : System.Web.UI.Page
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
                using (SqlCommand upcomProc = new SqlCommand("dbo.[FN_StudentUpcoming_installment]", conn))
                {
                    int studentId = (int)Session["user"];
                    upcomProc.CommandType = CommandType.StoredProcedure;
                    upcomProc.Parameters.Add(new SqlParameter("@student_id", studentId));

                    SqlParameter installdeadline = new SqlParameter("@installdeadline", SqlDbType.Date);
                    installdeadline.Direction = ParameterDirection.ReturnValue;
                    upcomProc.Parameters.Add(installdeadline);

                    upcomProc.ExecuteNonQuery();
                    try {
                        DateTime x = Convert.ToDateTime(installdeadline.Value); 
                        Date.Text = x.ToString();
                        Date.Visible = true;
                    }catch(Exception ex)
                    {
                        
                    }

                }
            }
        }
    }
}