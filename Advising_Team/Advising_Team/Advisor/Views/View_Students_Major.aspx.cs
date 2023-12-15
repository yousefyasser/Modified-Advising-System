using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using static Advising_Team.Advisor.Pick_Major;

namespace Advising_Team.Advisor.Views
{
    public partial class View_Students_Major : System.Web.UI.Page
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
                    Response.Redirect("../Advisor_Login.aspx");
                    return;
                }

                int advisorId = (int)Session["user"];
                string major = (string)Session["major"];

                using (SqlCommand viewStudentsMajorProc = new SqlCommand("Procedures_AdvisorViewAssignedStudents", conn))
                {
                    viewStudentsMajorProc.CommandType = CommandType.StoredProcedure;
                    viewStudentsMajorProc.Parameters.Add(new SqlParameter("@AdvisorID", advisorId));
                    viewStudentsMajorProc.Parameters.Add(new SqlParameter("@major", major));

                    SqlDataReader reader = viewStudentsMajorProc.ExecuteReader(CommandBehavior.CloseConnection);

                    while (reader.Read())
                    {
                        try
                        {
                            string studentName = reader.GetString(reader.GetOrdinal("Student_name"));
                            int studentId = reader.GetInt32(reader.GetOrdinal("student_id"));
                            string courseName = reader.GetString(reader.GetOrdinal("Course_name"));

                            TableRow tr = new TableRow();
                            TableCell name = new TableCell();
                            TableCell id = new TableCell();
                            TableCell course = new TableCell();
                            TableCell Major = new TableCell();

                            name.Text = studentName;
                            id.Text = studentId.ToString();
                            course.Text = courseName;
                            Major.Text = major;

                            tr.Cells.Add(id);
                            tr.Cells.Add(name);
                            tr.Cells.Add(Major);
                            tr.Cells.Add(course);

                            viewStudentsMajor.Controls.Add(tr);
                        }catch(Exception ex)
                        {
                            Pick_Major.ShowErrorMessage(ex.Message, errorMessage, successMessage);
                        }
                        
                    }
                }
            }
        }
    }
}
