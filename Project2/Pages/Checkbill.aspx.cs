using System;
using System.Collections.Generic;
using System.Data;

namespace Project2.Pages
{
    public partial class CheckBill : System.Web.UI.Page
    {
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
            // เก็บบิลสินค้า
            Session["LastBill"] = Session["CurrentBill"];
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

            // ไปหน้าดูบิล
            Response.Redirect("ViewBill.aspx");
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

    }
}
