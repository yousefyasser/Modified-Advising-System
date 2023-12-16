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
    public partial class AdminUpdateStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            if (!int.TryParse(studentID.Text, out int sID))
                message.Text = "Student ID must be an integer";
            else if (sID < 0)
                message.Text = "Student ID must be positive";
            else
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand checkStudent = new SqlCommand("SELECT COUNT(*) " +
                                                             "FROM Student " +
                                                             "WHERE student_id = @student_id", conn);
                    checkStudent.Parameters.Add(new SqlParameter("@student_id", sID));

                    conn.Open();
                    if ((int)checkStudent.ExecuteScalar() == 0)
                        message.Text = "Student ID does not exist";
                    else
                    {
                        SqlCommand updateStatus = new SqlCommand("Procedure_AdminUpdateStudentStatus", conn);
                        updateStatus.CommandType = CommandType.StoredProcedure;
                        updateStatus.Parameters.Add(new SqlParameter("@student_id", sID));
                        updateStatus.ExecuteNonQuery();
                        message.Text = "Student status updated successfully";
                    }
                }
            }
            message.Visible = true;
        }
    }
}