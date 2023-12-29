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
    public partial class View_all_advisors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand list_advisors = new SqlCommand("Procedures_AdminListAdvisors", conn);
            list_advisors.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader rdr = list_advisors.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                int advis_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id"));
                String advis_name = rdr.GetString(rdr.GetOrdinal("name"));
                String advis_mail = rdr.GetString(rdr.GetOrdinal("email"));
                String advis_office = rdr.GetString(rdr.GetOrdinal("office"));
                String advis_password = rdr.GetString(rdr.GetOrdinal("password"));
                Label id = new Label();
                id.Text = "<br >" + advis_id.ToString() + "<br >";
                Label name = new Label();
                name.Text = advis_name + "<br >";
                Label mail = new Label();
                mail.Text = advis_mail + "<br >";
                Label office = new Label();
                office.Text = advis_office + "<br >";
                Label password = new Label();
                password.Text = advis_password + "<br >";
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