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
                string query = "SELECT Role FROM Users WHERE Username=@u AND Password=@p";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@u", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@p", txtPassword.Text);

                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string role = result.ToString();

                        // เก็บข้อมูลการเข้าสู่ระบบใน Session
                        Session["Username"] = txtUsername.Text;
                        Session["Role"] = role;
                        Session["IsLoggedIn"] = true;

                        // แสดงข้อความยืนยันการเข้าสู่ระบบ
                        lblMsg.Text = "✅ เข้าสู่ระบบสำเร็จ";

                        // ไปยังหน้าที่เหมาะสมตาม Role
                        if (role == "Admin")
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
        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}