using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Project2.Pages
{
    public partial class Profile : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserName"] != null)
                {
                    string username = Session["UserName"].ToString();
                    LoadUserProfile(username);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void LoadUserProfile(string username)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT UserName, FirstName, LastName, Address, Phone FROM Users WHERE UserName = @UserName";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserName", username);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        lblUsername.Text = "ชื่อผู้ใช้: " + dr["UserName"].ToString();
                        txtFirstName.Text = dr["FirstName"].ToString();
                        txtLastName.Text = dr["LastName"].ToString();
                        txtAddress.Text = dr["Address"].ToString();
                        txtPhone.Text = dr["Phone"].ToString();
                    }
                    else
                    {
                        lblMessage.Text = "ไม่พบข้อมูลผู้ใช้";
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "เกิดข้อผิดพลาด: " + ex.Message;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Session["UserName"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string username = Session["UserName"].ToString();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                        UPDATE Users 
                        SET FirstName = @fn, 
                            LastName = @ln, 
                            Address = @addr, 
                            Phone = @ph 
                        WHERE UserName = @u";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@fn", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ln", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@addr", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@ph", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@u", username);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "✅ แก้ไขข้อมูลสำเร็จ";
                    }
                    else
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "❌ ไม่พบผู้ใช้";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "เกิดข้อผิดพลาด: " + ex.Message;
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
