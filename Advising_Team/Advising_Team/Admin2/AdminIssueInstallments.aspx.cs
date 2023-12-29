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
    public partial class AdminIssueInstallments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void IssueInstallments(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            using(SqlConnection conn = new SqlConnection(connStr))
            {
                if (!int.TryParse(paymentID.Value, out int payID))
                    message.Text = "payment ID must be an integer";
                else if (payID < 0)
                    message.Text = "payment ID must be positive";
                else
                {
                    using (SqlCommand checkPayment = new SqlCommand("SELECT COUNT(*) " +
                                                                    "FROM Payment " +
                                                                    "WHERE payment_id = @payment_id", conn))
                    {
                        checkPayment.Parameters.Add(new SqlParameter("@payment_id", payID));

                        conn.Open();
                        if ((int)checkPayment.ExecuteScalar() == 0)
                            message.Text = "payment ID does not exist";
                        else
                        {

                            using (SqlCommand checkInstallments = new SqlCommand("SELECT COUNT(*) " +
                                                                                 "FROM Installment " +
                                                                                 "WHERE payment_id = @payment_id", conn))
                            {
                                checkInstallments.Parameters.Add(new SqlParameter("@payment_id", payID));

                                if ((int)checkInstallments.ExecuteScalar() != 0)
                                    message.Text = "installments already issued";
                                else
                                    message.Text = "installments issued successfully";
                            }
                        }
                    }   
                }
                message.Visible = true;
            }
        }
    }
}