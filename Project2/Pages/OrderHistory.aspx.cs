using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Project2.Pages
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    LoadOrderHistory(userId);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        void LoadOrderHistory(int userId)
        {
            string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT OrderID, OrderDate, TotalAmount FROM Orders WHERE UserID = @UserID ORDER BY OrderDate DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewOrders.DataSource = dt;
                GridViewOrders.DataBind();
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

    }
}
