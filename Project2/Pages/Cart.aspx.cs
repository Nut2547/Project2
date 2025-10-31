using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace Project2.Pages
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        /// <summary>
        /// แปลง List<Dictionary> ของสินค้าที่อยู่ใน Session["Cart"] เป็น DataTable แล้ว Bind กับ GridView
        /// </summary>
        private void BindCart()
        {
            var cart = Session["Cart"] as List<Dictionary<string, object>>;

            if (cart != null && cart.Count > 0)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProductID");
                dt.Columns.Add("ProductName");
                dt.Columns.Add("Price", typeof(decimal));
                dt.Columns.Add("Quantity", typeof(int));
                dt.Columns.Add("Total", typeof(decimal));

                foreach (var item in cart)
                {
                    decimal price = Convert.ToDecimal(item["Price"]);
                    int qty = Convert.ToInt32(item["Quantity"]);
                    dt.Rows.Add(item["ProductID"], item["ProductName"], price, qty, price * qty);
                }

                gvCart.DataSource = dt;
                gvCart.DataBind();
            }
            else
            {
                gvCart.DataSource = null;
                gvCart.DataBind();
            }
        }

        /// <summary>
        /// ปุ่มล้างตะกร้า
        /// </summary>
        protected void btnClear_Click(object sender, EventArgs e)
        {
            Session["Cart"] = null;
            BindCart();
        }

        /// <summary>
        /// ปุ่มชำระเงิน → ไปหน้า CheckBill.aspx
        /// </summary>
        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<Dictionary<string, object>>;

            if (cart != null && cart.Count > 0)
            {
                // เก็บสินค้าปัจจุบันไว้เป็นบิล
                Session["CurrentBill"] = cart;

                Response.Redirect("CheckBill.aspx");
            }
            else
            {
                Response.Write("<script>alert('ไม่มีสินค้าในตะกร้า');</script>");
            }
        }

        /// <summary>
        /// ปุ่มกลับไปหน้าร้านค้า
        /// </summary>
        protected void btnBackToShop_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateQty")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvCart.Rows[index];

                // ดึง TextBox จำนวนจากแถวที่เลือก
                TextBox txtQty = row.FindControl("txtQuantity") as TextBox;
                if (txtQty != null)
                {
                    int newQty;
                    if (int.TryParse(txtQty.Text, out newQty) && newQty > 0)
                    {
                        // อัปเดต Session["Cart"]
                        var cart = Session["Cart"] as List<Dictionary<string, object>>;
                        if (cart != null)
                        {
                            // หาไอเท็มในตะกร้าที่ตรงกับ ProductID
                            string productID = gvCart.DataKeys[index].Value.ToString();

                            var item = cart.Find(i => i["ProductID"].ToString() == productID);
                            if (item != null)
                            {
                                item["Quantity"] = newQty;
                                // รีเฟรชข้อมูลใน GridView
                                BindCart();
                            }
                        }
                    }
                    else
                    {
                        // กรณีใส่จำนวนผิด ให้แจ้งเตือน
                        Response.Write("<script>alert('กรุณาใส่จำนวนที่ถูกต้อง');</script>");
                    }
                }
            }
        }
    }
}
