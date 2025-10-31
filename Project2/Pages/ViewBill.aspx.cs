using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace Project2.Pages
{
    public partial class ViewBill : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["BillSaved"] == null)
                {
                    SaveBillToDatabase();
                    Session["BillSaved"] = true;
                }

                LoadBill();
                LoadCustomerInfo();
            }
        }

        private void SaveBillToDatabase()
        {
            var bill = Session["LastBill"] as List<Dictionary<string, object>>;
            var info = Session["CustomerInfo"] as Dictionary<string, string>;
            string username = Session["Username"] as string;

            if (bill == null || bill.Count == 0 || string.IsNullOrEmpty(username))
                return;

            decimal total = 0;
            foreach (var item in bill)
            {
                total += Convert.ToDecimal(item["Price"]) * Convert.ToInt32(item["Quantity"]);
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    // ✅ 1. เพิ่มข้อมูลใน PurchaseOrders โดยใช้ Username
                    string orderQuery = @"
                        INSERT INTO PurchaseOrders (Username, OrderDate, TotalAmount, Status)
                        OUTPUT INSERTED.OrderID
                        VALUES (@Username, @OrderDate, @TotalAmount, @Status)";

                    int orderId;
                    using (SqlCommand cmd = new SqlCommand(orderQuery, con, tran))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TotalAmount", total);
                        cmd.Parameters.AddWithValue("@Status", "Completed");

                        orderId = (int)cmd.ExecuteScalar();
                    }

                    // ✅ 2. เพิ่มสินค้าใน OrderProducts
                    foreach (var item in bill)
                    {
                        string detailQuery = @"
                            INSERT INTO OrderProducts (OrderID, ProductID, Quantity, Price)
                            VALUES (@OrderID, @ProductID, @Quantity, @Price)";

                        using (SqlCommand cmd = new SqlCommand(detailQuery, con, tran))
                        {
                            cmd.Parameters.AddWithValue("@OrderID", orderId);
                            cmd.Parameters.AddWithValue("@ProductID", item["ProductID"]);
                            cmd.Parameters.AddWithValue("@Quantity", item["Quantity"]);
                            cmd.Parameters.AddWithValue("@Price", item["Price"]);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    tran.Commit();
                    lblTotal.Text = "✅ บันทึกบิลสำเร็จ (Order ID: " + orderId + ")";
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    lblTotal.Text = "❌ เกิดข้อผิดพลาด: " + ex.Message;
                }
            }
        }

        private void LoadBill()
        {
            var bill = Session["LastBill"] as List<Dictionary<string, object>>;
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

                gvBillView.DataSource = dt;
                gvBillView.DataBind();

                lblTotal.Text = "รวมทั้งหมด: " + total.ToString("N2") + " บาท";
            }
            else
            {
                lblTotal.Text = "ไม่มีข้อมูลบิล";
            }
        }

        private void LoadCustomerInfo()
        {
            var info = Session["CustomerInfo"] as Dictionary<string, string>;
            if (info != null)
            {
                lblName.Text = info["Name"];
                lblAddress.Text = info["Address"];
                lblPhone.Text = info["Phone"];
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Home.aspx");
        }
    }
}
