using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading;

namespace Project2.Pages
{
    public partial class Register : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // ตรวจสอบการกรอกข้อมูลเบื้องต้น
            if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text) ||
                string.IsNullOrWhiteSpace(txtFirstName.Text) ||
                string.IsNullOrWhiteSpace(txtLastName.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text) ||
                string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "❌ กรุณากรอกข้อมูลให้ครบทุกช่อง";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // ✅ ตรวจสอบว่า Username ซ้ำหรือไม่
                string check = "SELECT COUNT(*) FROM Users WHERE UserName = @u";
                using (SqlCommand cmdCheck = new SqlCommand(check, con))
                {
                    cmdCheck.Parameters.AddWithValue("@u", txtUsername.Text.Trim());
                    int exists = (int)cmdCheck.ExecuteScalar();

                    if (exists > 0)
                    {
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        lblMsg.Text = "❌ ชื่อผู้ใช้นี้ถูกใช้แล้ว กรุณาใช้ชื่ออื่น";
                        return;
                    }
                }

                // ✅ เพิ่มข้อมูลผู้ใช้ใหม่ (Role ถูกล็อกให้เป็น 'User')
                string query = @"
                    INSERT INTO Users 
                        (UserName, Password, FirstName, LastName, Address, Phone, Role)
                    VALUES 
                        (@u, @p, @fn, @ln, @addr, @ph, @r)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@u", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@p", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@fn", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ln", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@addr", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@ph", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@r", "User"); // ✅ ล็อกให้เป็น User เสมอ

                    cmd.ExecuteNonQuery();

                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "✅ สมัครสมาชิกสำเร็จ! กำลังนำคุณไปยังหน้าเข้าสู่ระบบ...";

                    // ✅ เคลียร์ฟอร์ม
                    ClearForm();

                    // ✅ หน่วงเวลา 2 วินาทีแล้วไปหน้า Login.aspx
                    Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                }
            }
        }

        private void ClearForm()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtAddress.Text = "";
            txtPhone.Text = "";
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
