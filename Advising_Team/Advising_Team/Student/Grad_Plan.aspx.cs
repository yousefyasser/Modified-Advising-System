using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Student
{
    public partial class Grad_Plan : System.Web.UI.Page
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

                using (SqlCommand gradPlanProc = new SqlCommand("Select * from dbo.[FN_StudentViewGP](@student)", conn))
                {
                    int studentId = (int)Session["user"];
                    gradPlanProc.Parameters.Add(new SqlParameter("@student", studentId));

                    SqlDataReader reader = gradPlanProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
                    {
                        int courseId = reader.GetInt32(reader.GetOrdinal("course_id"));
                        int credits= reader.GetInt32(reader.GetOrdinal("semester_credit_hours"));
                        string courseName = reader.GetString(reader.GetOrdinal("name"));
                        string code = reader.GetString(reader.GetOrdinal("semester_code"));
                        string s_name = reader.GetString(reader.GetOrdinal("Student_name"));
                        DateTime date = reader.GetDateTime(reader.GetOrdinal("expected_grad_date"));
                        int aId = reader.GetInt32(reader.GetOrdinal("advisor_id"));
                        TableRow tr = new TableRow();
                        TableCell name = new TableCell();
                        TableCell credit = new TableCell();
                        TableCell semester = new TableCell();
                        TableCell c_name = new TableCell();
                        TableCell c_id = new TableCell();
                        TableCell ad_id = new TableCell();
                        TableCell dates = new TableCell();
                        c_id.Text = courseId.ToString();
                        c_name.Text = courseName;
                        name.Text = s_name;
                        credit.Text = credits.ToString();
                        semester.Text = code;
                        dates.Text = date.ToString();
                        ad_id.Text= aId.ToString();
                        tr.Cells.Add(name);
                        tr.Cells.Add(semester);
                        tr.Cells.Add(credit);
                        tr.Cells.Add(dates);
                        tr.Cells.Add(ad_id);
                        tr.Cells.Add(c_id);
                        tr.Cells.Add(c_name);
                        graduationPlan.Controls.Add(tr);
                    }
                }
            }
        
    }
    }
}