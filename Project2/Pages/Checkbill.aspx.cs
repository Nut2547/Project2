using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Project2.Pages
{
    public partial class CheckBill : System.Web.UI.Page
    {


        public class CartItem
        {
            public int ProductID { get; set; }
            public string ProductName { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBill();
            }
        }

        private void LoadBill()
        {
            var bill = Session["CurrentBill"] as List<Dictionary<string, object>>;
            if (bill != null && bill.Count > 0)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProductID");
                dt.Columns.Add("ProductName");
                dt.Columns.Add("Price", typeof(decimal));
                dt.Columns.Add("Quantity", typeof(int));

                decimal total = 0;

                foreach (var item in bill)
                {
                    decimal price = Convert.ToDecimal(item["Price"]);
                    int qty = Convert.ToInt32(item["Quantity"]);
                    dt.Rows.Add(item["ProductID"], item["ProductName"], price, qty);
                    total += price * qty;
                }

                gvBill.DataSource = dt;
                gvBill.DataBind();

                lblTotal.Text = "ราคารวมทั้งหมด: " + total.ToString("N2") + " บาท";
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            var bill = Session["CurrentBill"] as List<Dictionary<string, object>>;

            if (bill != null && bill.Count > 0)
            {
                // แปลงเป็น List<CartItem> สำหรับใช้กับ SaveOrderHistory
                List<CartItem> cartItems = bill.Select(item => new CartItem
                {
                    ProductID = Convert.ToInt32(item["ProductID"]),
                    ProductName = item["ProductName"].ToString(),
                    Price = Convert.ToDecimal(item["Price"]),
                    Quantity = Convert.ToInt32(item["Quantity"])
                }).ToList();

                // ✅ ดึง UserID จาก Session (ตอน Login แล้วเก็บไว้)
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);

                    // ✅ บันทึกประวัติการสั่งซื้อ
                    SaveOrderHistory(userId, cartItems);
                }

                // 🔹 เก็บบิลไว้ใน Session (ไว้ดูในหน้า ViewBill.aspx)
                Session["LastBill"] = bill;
                Session["Cart"] = null;
                Session["CurrentBill"] = null;

                // 🔹 เก็บข้อมูลลูกค้า
                var customerInfo = new Dictionary<string, string>
        {
            { "Name", txtName.Text },
            { "Address", txtAddress.Text },
            { "Phone", txtPhone.Text }
        };
                Session["CustomerInfo"] = customerInfo;

                // ✅ ไปหน้าดูบิล
                Response.Redirect("ViewBill.aspx");
            }
            else
            {
                Response.Write("<script>alert('ไม่พบข้อมูลสินค้าในบิล');</script>");
            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<Dictionary<string, object>>;

            if (cart != null && cart.Count > 0)
            {
                // เก็บข้อมูลตะกร้าไว้เป็นบิลปัจจุบัน
                Session["CurrentBill"] = cart;

                // ไปหน้าตรวจสอบบิลก่อนชำระเงิน
                Response.Redirect("~/Pages/CheckBill.aspx");
            }
            else
            {
                // กรณีไม่มีสินค้าในตะกร้า
                Response.Write("<script>alert('ไม่มีสินค้าในตะกร้า');</script>");
            }
        }

        protected void SaveOrderHistory(int userId, List<CartItem> cartItems)
        {
            string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1. บันทึกข้อมูลใน Orders
                string insertOrder = "INSERT INTO Orders (UserID, OrderDate, TotalAmount) OUTPUT INSERTED.OrderID VALUES (@UserID, GETDATE(), @Total)";
                SqlCommand cmdOrder = new SqlCommand(insertOrder, con);
                cmdOrder.Parameters.AddWithValue("@UserID", userId);
                cmdOrder.Parameters.AddWithValue("@Total", cartItems.Sum(x => x.Price * x.Quantity));
                int orderId = (int)cmdOrder.ExecuteScalar();

                // 2. บันทึกสินค้าใน OrderDetails
                foreach (var item in cartItems)
                {
                    string insertDetail = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES (@OrderID, @ProductID, @Qty, @Price)";
                    SqlCommand cmdDetail = new SqlCommand(insertDetail, con);
                    cmdDetail.Parameters.AddWithValue("@OrderID", orderId);
                    cmdDetail.Parameters.AddWithValue("@ProductID", item.ProductID);
                    cmdDetail.Parameters.AddWithValue("@Qty", item.Quantity);
                    cmdDetail.Parameters.AddWithValue("@Price", item.Price);
                    cmdDetail.ExecuteNonQuery();
                }
            }


        }

    }
}
