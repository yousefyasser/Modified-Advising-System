using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Admin2
{
    public partial class AdminDeleteSlot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RemoveSlots(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand deleteSlots = new SqlCommand("Procedures_AdminDeleteSlots", conn);
            deleteSlots.CommandType = CommandType.StoredProcedure;
            deleteSlots.Parameters.Add(new SqlParameter("@current_semester", semester_code.Value));

            conn.Open();
            int rowsAffected = deleteSlots.ExecuteNonQuery();
            conn.Close();

            if (rowsAffected > 0)
            {
                msg.Text = "slots deleted";
            }
            else
            {
                msg.Text = "invalid semester code";
            }

            msg.Visible = true;
        }
    }
}