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
    public partial class view_all_students_with_advisors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand list_students_with_advisors = new SqlCommand("AdminListStudentsWithAdvisors", conn);
            list_students_with_advisors.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader rdr = list_students_with_advisors.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                int student_id = rdr.GetInt32(rdr.GetOrdinal("student_id"));
                String student_f_name = rdr.GetString(rdr.GetOrdinal("f_name"));
                String student_l_name = rdr.GetString(rdr.GetOrdinal("l_name"));
                int advis_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id"));
                String advis_name = rdr.GetString(rdr.GetOrdinal("advisor_name"));
                Label id = new Label();
                id.Text = "<br >" + student_id.ToString() + "<br >";
                Label name = new Label();
                name.Text = student_f_name + "<br >";
                Label mail = new Label();
                mail.Text = student_l_name + "<br >";
                Label office = new Label();
                office.Text = advis_id.ToString() + "<br >";
                Label password = new Label();
                password.Text = advis_name + "<br >";
                Label spacer = new Label();
                spacer.Text = "---------------- ";
                form1.Controls.Add(id);
                form1.Controls.Add(name);
                form1.Controls.Add(mail);
                form1.Controls.Add(office);
                form1.Controls.Add(password);
                form1.Controls.Add(spacer);


            }
            conn.Close();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_page.aspx");
        }
    }
}