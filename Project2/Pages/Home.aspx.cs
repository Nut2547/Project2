using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project2.Pages
{
    public partial class Home : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // เช็คสิทธิ์
                if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
                {
                    btnManageProducts.Visible = true;
                }
                else
                {
                    btnManageProducts.Visible = false;
                }

                // แสดงชื่อผู้ใช้
                if (Session["UserName"] != null)
                {
                    string userName = Session["UserName"].ToString();
                    hlUserProfile.Text = userName;
                    hlUserProfile.NavigateUrl = "Profile.aspx?user=" + Server.UrlEncode(userName);
                }
                else
                {
                }

                // เช็คสิทธิ์และสถานะการเข้าสู่ระบบ
                bool isLoggedIn = Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
                btnRegister.Visible = !isLoggedIn;
                btnLogin.Visible = !isLoggedIn;
                btnLogout.Visible = isLoggedIn; // แสดงเมื่อเข้าสู่ระบบ
                LoadProducts();
            }
        }

        private void LoadProducts(string search = "")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT ProductID, ProductName, Price, Quantity, ImageUrl FROM Products";

                    if (!string.IsNullOrEmpty(search))
                    {
                        query += " WHERE ProductName LIKE @Search";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        if (!string.IsNullOrEmpty(search))
                        {
                            cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                        }

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            gvProducts.DataSource = dt;
                            gvProducts.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('เกิดข้อผิดพลาดในการโหลดสินค้า: " + ex.Message + "');</script>");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            LoadProducts(searchTerm);
        }


        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Home.aspx");
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int productId;
                if (!int.TryParse(e.CommandArgument.ToString(), out productId))
                {
                    Response.Write("<script>alert('ProductID ไม่ถูกต้อง');</script>");
                    return;
                }

                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
                int quantity;

                if (!int.TryParse(txtQuantity.Text, out quantity) || quantity <= 0)
                {
                    Response.Write("<script>alert('กรุณากรอกจำนวนที่ถูกต้อง');</script>");
                    return;
                }

                try
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        string query = "SELECT ProductID, ProductName, Price, Quantity AS StockQuantity FROM Products WHERE ProductID = @ProductID";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@ProductID", productId);
                            con.Open();

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    int stockQuantity = Convert.ToInt32(reader["StockQuantity"]);

                                    if (quantity > stockQuantity)
                                    {
                                        Response.Write("<script>alert('จำนวนที่กรอกเกินกว่าสินค้าในสต็อก');</script>");
                                        return;
                                    }

                                    string name = reader["ProductName"].ToString();
                                    decimal price = Convert.ToDecimal(reader["Price"]);

                                    con.Close();

                                    con.Open();
                                    using (var transaction = con.BeginTransaction())
                                    {
                                        try
                                        {
                                            // อัปเดตจำนวนในสต็อก
                                            string updateQuery = "UPDATE Products SET Quantity = Quantity - @PurchasedQuantity WHERE ProductID = @ProductID AND Quantity >= @PurchasedQuantity";
                                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, con, transaction))
                                            {
                                                updateCmd.Parameters.AddWithValue("@PurchasedQuantity", quantity);
                                                updateCmd.Parameters.AddWithValue("@ProductID", productId);

                                                int rowsAffected = updateCmd.ExecuteNonQuery();
                                                if (rowsAffected == 0)
                                                {
                                                    Response.Write("<script>alert('จำนวนสินค้าในสต็อกไม่เพียงพอสำหรับการซื้อครั้งนี้');</script>");
                                                    transaction.Rollback();
                                                    return;
                                                }
                                            }

                                            // เพิ่มสินค้าในตะกร้า
                                            var cart = Session["Cart"] as List<Dictionary<string, object>>;
                                            if (cart == null)
                                                cart = new List<Dictionary<string, object>>();

                                            var existing = cart.Find(p => Convert.ToInt32(p["ProductID"]) == productId);

                                            if (existing != null)
                                            {
                                                int currentQty = Convert.ToInt32(existing["Quantity"]);
                                                if (currentQty + quantity > stockQuantity)
                                                {
                                                    Response.Write("<script>alert('จำนวนรวมในตะกร้าจะเกินกว่าสินค้าในสต็อก');</script>");
                                                    transaction.Rollback();
                                                    return;
                                                }
                                                existing["Quantity"] = currentQty + quantity;
                                            }
                                            else
                                            {
                                                var newItem = new Dictionary<string, object>
                                                {
                                                    { "ProductID", productId },
                                                    { "ProductName", name },
                                                    { "Price", price },
                                                    { "Quantity", quantity }
                                                };
                                                cart.Add(newItem);
                                            }

                                            Session["Cart"] = cart;

                                            transaction.Commit();
                                            Response.Redirect("Cart.aspx");
                                        }
                                        catch (Exception ex)
                                        {
                                            transaction.Rollback();
                                            Response.Write("<script>alert('เกิดข้อผิดพลาดในกระบวนการซื้อสินค้า: " + ex.Message + "');</script>");
                                        }
                                    }
                                }
                                else
                                {
                                    Response.Write("<script>alert('ไม่พบสินค้าที่เลือกในฐานข้อมูล');</script>");
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('เกิดข้อผิดพลาดในการซื้อสินค้า: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnManageProducts_Click(object sender, EventArgs e)
        {
            if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
            {
                Response.Redirect("ManageProducts.aspx");
            }
            else
            {
                Response.Write("<script>alert('คุณไม่มีสิทธิ์เข้าถึงหน้านี้');</script>");
            }
        }
    }
}