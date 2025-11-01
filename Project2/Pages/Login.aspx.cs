using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Project2.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMsg.Text = "❌ กรุณากรอกชื่อผู้ใช้และรหัสผ่าน";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // ✅ ดึงทั้ง UserID และ Role จาก Users
                string query = "SELECT UserID, Role FROM Users WHERE Username=@u AND Password=@p";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@u", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@p", txtPassword.Text);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // ✅ เก็บข้อมูลเข้าสู่ระบบใน Session
                            Session["UserID"] = reader["UserID"];  // ใช้ใน CheckBill
                            Session["Username"] = txtUsername.Text;
                            Session["Role"] = reader["Role"].ToString();
                            Session["IsLoggedIn"] = true;

                            lblMsg.Text = "✅ เข้าสู่ระบบสำเร็จ";

                            // ✅ แยกหน้าไปตาม Role
                            if (reader["Role"].ToString() == "Admin")
                                Response.Redirect("~/Pages/ManageProducts.aspx");
                            else
                                Response.Redirect("~/Pages/Home.aspx");
                        }
                        else
                        {
                            lblMsg.Text = "❌ ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง";
                        }
                    }
                }
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
