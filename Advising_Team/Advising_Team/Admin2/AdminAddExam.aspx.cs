using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Admin2
{
    public partial class AdminAddExam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<string> examTypes = new List<string> {"First_makeup", "Second_makeup"};
                examType.DataSource = examTypes;
                examType.DataBind();
            }
        }
        protected void AddExam(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                if (!DateTime.TryParse(examDatetime.Value, out DateTime examDate))
                {
                    msg.Text = "invalid date";
                }
                else if (examDate < DateTime.Now)
                {
                    msg.Text = "exam date must be in the future";
                }
                else if (!int.TryParse(courseID.Value, out int crsID))
                {
                    msg.Text = "course ID must be an integer";
                }
                else if (crsID < 0)
                {
                    msg.Text = "course ID must be positive";
                }
                else
                {
                    int count = 0;
                    using (SqlCommand viewExams = new SqlCommand("SELECT COUNT(*) " +
                                                                 "FROM MakeUp_Exam " +
                                                                 "WHERE date = @date " +
                                                                 "AND type = @type " +
                                                                 "AND course_id = @course_id", conn))
                    {
                        //viewExams.CommandType = CommandType.Text;

                        conn.Open();
                        viewExams.Parameters.Add(new SqlParameter("@date", examDate));
                        viewExams.Parameters.Add(new SqlParameter("@type", examType.Text));
                        viewExams.Parameters.Add(new SqlParameter("@course_id", crsID));
                        count = (int)viewExams.ExecuteScalar();
                    }
                    if (count > 0)
                    {
                        msg.Text = "exam already exists";
                    }
                    else if (examType.Text != "First_makeup" && examType.Text != "Second_makeup")
                    {
                        msg.Text = "invalid exam type";
                    }
                    else
                    {
                        using (SqlCommand addExam = new SqlCommand("Procedures_AdminAddExam", conn))
                        {
                            addExam.CommandType = CommandType.StoredProcedure;
                            addExam.Parameters.Add(new SqlParameter("@type", examType.Text));
                            addExam.Parameters.Add(new SqlParameter("@date", examDate));
                            addExam.Parameters.Add(new SqlParameter("@courseID", crsID));

                            addExam.ExecuteNonQuery();

                            msg.Text = "exam added";
                        }
                    }
                }
                msg.Visible = true;
            }
        }
    }
}