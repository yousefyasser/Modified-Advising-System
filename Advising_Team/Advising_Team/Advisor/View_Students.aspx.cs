using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Advisor
{
    public partial class View_Students : System.Web.UI.Page
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
                    Response.Redirect("Advisor_Login.aspx");
                    return;
                }
                    int advisorId = (int)Session["user"];

                using (SqlCommand viewStudentsProc = new SqlCommand("SELECT S.f_name+' ' + S.l_name as Name, S.student_id as Id from Student S inner join Advisor A ON S.advisor_id = A.advisor_id where A.advisor_id = @advisorId ", conn))
                {
                    viewStudentsProc.Parameters.Add(new SqlParameter("@advisorId", advisorId));

                    SqlDataReader reader = viewStudentsProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
                    {
                        string studentName = reader.GetString(reader.GetOrdinal("Name"));
                        int studentId = reader.GetInt32(reader.GetOrdinal("Id"));
                        TableRow tr = new TableRow();
                        TableCell id = new TableCell();
                        TableCell name = new TableCell();
                        name.Text = studentName;
                        id.Text = studentId.ToString();
                        tr.Cells.Add(name);
                        tr.Cells.Add(id);
                        viewStudents.Controls.Add(tr);
                    }
                }
            }
        }
    }
}