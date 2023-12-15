using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Advising_Team.Advisor.Views
{
    public partial class View_All_Requests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the advisor is logged in
                if (Session["user"] == null)
                {
                    Response.Redirect("../Advisor_Login.aspx");
                    return;
                }

                // Retrieve advisor ID from the session
                int advisorId = (int)Session["user"];

                // Retrieve requests for the advisor using the function
                DataTable requestsTable = GetAdvisorsRequests(advisorId);

                // Populate the table with the retrieved data
                PopulateRequestsTable(requestsTable);
            }
        }

        private DataTable GetAdvisorsRequests(int advisorId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Use the function to retrieve requests for the advisor
                using (SqlCommand getRequests = new SqlCommand("SELECT * FROM FN_Advisors_Requests(@advisorId)", conn))
                {
                    getRequests.Parameters.AddWithValue("@advisorId", advisorId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(getRequests))
                    {
                        DataTable requestsTable = new DataTable();
                        adapter.Fill(requestsTable);

                        return requestsTable;
                    }
                }
            }
        }

        private void PopulateRequestsTable(DataTable requestsTable)
        {
            foreach (DataRow row in requestsTable.Rows)
            {
                int requestId = Convert.ToInt32(row["request_id"]);
                string type = row["type"].ToString();
                string comment = row["comment"].ToString();
                string status = row["status"].ToString();

                int creditHours;
                if (row["credit_hours"] != DBNull.Value)
                {
                    creditHours = Convert.ToInt32(row["credit_hours"]);
                }
                else
                {
                    // Handling the case when credit_hours is DBNull
                    creditHours = -1; 
                }

                int courseId;
                if (row["course_id"] != DBNull.Value)
                {
                    courseId = Convert.ToInt32(row["course_id"]);
                }
                else
                {
                    // Handling the case when credit_hours is DBNull
                    courseId = -1; 
                }

                int studentId = Convert.ToInt32(row["student_id"]);
                int advisorId = Convert.ToInt32(row["advisor_id"]);

                TableRow tr = new TableRow();
                tr.Cells.Add(CreateTableCell(requestId.ToString()));
                tr.Cells.Add(CreateTableCell(type));
                tr.Cells.Add(CreateTableCell(comment));
                tr.Cells.Add(CreateTableCell(status));
                tr.Cells.Add(CreateTableCell(creditHours.ToString()));
                tr.Cells.Add(CreateTableCell(courseId.ToString()));
                tr.Cells.Add(CreateTableCell(studentId.ToString()));
                tr.Cells.Add(CreateTableCell(advisorId.ToString()));

                viewRequests.Rows.Add(tr);
            }
        }

        private TableCell CreateTableCell(string text)
        {
            TableCell cell = new TableCell();
            cell.Text = text;
            return cell;
        }
    }
}
