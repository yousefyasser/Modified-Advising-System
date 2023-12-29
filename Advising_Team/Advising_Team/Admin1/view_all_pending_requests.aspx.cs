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
    public partial class view_all_pending_requests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand list_pending_requests = new SqlCommand("select * FROM all_Pending_Requests", conn);
                list_pending_requests.CommandType = CommandType.Text;
                conn.Open();
                SqlDataReader rdr = list_pending_requests.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    int req_id = rdr.GetInt32(rdr.GetOrdinal("request_id"));
                    String type = rdr.GetString(rdr.GetOrdinal("type"));
                    String comment = rdr.GetString(rdr.GetOrdinal("comment"));
                    String status = rdr.GetString(rdr.GetOrdinal("status"));
                    int credit_hours = rdr.GetInt32(rdr.GetOrdinal("credit_hours"));
                    int course_id = rdr.GetInt32(rdr.GetOrdinal("course_id"));
                    int student_id = rdr.GetInt32(rdr.GetOrdinal("student_id"));
                    int advisor_id = rdr.GetInt32(rdr.GetOrdinal("advisor_id"));
                    Label the_request_id = new Label();
                    the_request_id.Text = "<br >" + req_id.ToString() + "<br >";
                    Label thetype = new Label();
                    thetype.Text = type + "<br >";
                    Label thecomment = new Label();
                    thecomment.Text = comment + "<br >";
                    Label thestatus = new Label();
                    thestatus.Text = status + "<br >";

                    Label thecredit = new Label();
                    thecredit.Text = credit_hours.ToString() + "<br >";
                    Label thecourseid = new Label();
                    thecourseid.Text = course_id.ToString() + "<br >";
                    Label thestudentid = new Label();
                    thestudentid.Text = student_id.ToString() + "<br >";
                    Label theadvisorid = new Label();
                    theadvisorid.Text = advisor_id.ToString() + "<br >";
                    Label spacer = new Label();
                    spacer.Text = "----------------- ";
                    form1.Controls.Add(the_request_id);
                    form1.Controls.Add(thecomment);
                    form1.Controls.Add(thestatus);
                    form1.Controls.Add(thecredit);
                    form1.Controls.Add(thecourseid);
                    form1.Controls.Add(thestudentid);
                    form1.Controls.Add(theadvisorid);
                    form1.Controls.Add(spacer);
                }
                conn.Close();
            }
            catch (Exception ex)
            {

            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_page.aspx");
        }
    }
}