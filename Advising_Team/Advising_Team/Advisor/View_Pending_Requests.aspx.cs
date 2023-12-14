using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Advising_Team.Advisor
{
    public partial class View_Pending_Requests : System.Web.UI.Page
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

                using (SqlCommand viewPendingRequestsProc = new SqlCommand("Procedures_AdvisorViewPendingRequests", conn))
                {
                    viewPendingRequestsProc.CommandType = CommandType.StoredProcedure;
                    viewPendingRequestsProc.Parameters.Add(new SqlParameter("@Advisor_ID", advisorId));

                    SqlDataReader reader = viewPendingRequestsProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
                    {
                        int requestId = reader.GetInt32(reader.GetOrdinal("request_id"));
                        string type = reader.GetString(reader.GetOrdinal("type"));
                        string comment = reader.GetString(reader.GetOrdinal("comment"));
                        string status = reader.GetString(reader.GetOrdinal("status"));

                        TableCell requestIdCell = new TableCell();
                        requestIdCell.Text = requestId.ToString();

                        TableCell typeCell = new TableCell();
                        typeCell.Text = type;

                        TableCell commentCell = new TableCell();
                        commentCell.Text = comment;

                        TableCell statusCell = new TableCell();
                        statusCell.Text = status;

                        TableCell creditHoursCell = new TableCell();
                        if (!reader.IsDBNull(reader.GetOrdinal("credit_hours")))
                        {
                            int creditHours = reader.GetInt32(reader.GetOrdinal("credit_hours"));
                            creditHoursCell.Text = creditHours.ToString();
                        }
                        else
                        {
                            int creditHours = -1;
                            creditHoursCell.Text = creditHours.ToString();
                        }

                        TableCell courseIdCell = new TableCell();
                        if (!reader.IsDBNull(reader.GetOrdinal("course_id")))
                        {
                            int courseId = reader.GetInt32(reader.GetOrdinal("course_id"));
                            courseIdCell.Text = courseId.ToString();
                        }
                        else
                        {
                            int courseId = -1;
                            courseIdCell.Text = courseId.ToString();
                        }

                        TableCell studentIdCell = new TableCell();
                        studentIdCell.Text = reader["student_id"].ToString();
                        
                        TableCell advisorIdCell = new TableCell();
                        advisorIdCell.Text = advisorId.ToString();

                        TableRow tr = new TableRow();
                        tr.Cells.Add(requestIdCell);
                        tr.Cells.Add(typeCell);
                        tr.Cells.Add(commentCell);
                        tr.Cells.Add(statusCell);
                        tr.Cells.Add(creditHoursCell);
                        tr.Cells.Add(courseIdCell);
                        tr.Cells.Add(studentIdCell);
                        tr.Cells.Add(advisorIdCell);

                        viewPendingRequests.Controls.Add(tr);
                    }
                }
            }
        }
    }
}
