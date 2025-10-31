using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Project2.Pages
{
    public partial class ManageProducts : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Products", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "INSERT INTO Products (ProductName, Price, ImageUrl, Quantity) VALUES (@n, @p, @i, @q)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@n", txtName.Text);
                cmd.Parameters.AddWithValue("@p", Convert.ToDecimal(txtPrice.Text));
                cmd.Parameters.AddWithValue("@i", txtImage.Text);
                int quantity = 0;
                int.TryParse(txtQuantity.Text, out quantity);
                cmd.Parameters.AddWithValue("@q", quantity);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            // เคลียร์ TextBox หลังบันทึก
            txtName.Text = "";
            txtPrice.Text = "";
            txtImage.Text = "";
            txtQuantity.Text = "";

            BindGrid();
        }

        protected void gvProducts_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Products WHERE ProductID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
        protected void gvProducts_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvProducts_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            BindGrid();
        }

        protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int productID = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvProducts.Rows[e.RowIndex];

            string name = ((TextBox)row.FindControl("txtEditName")).Text;
            decimal price = Convert.ToDecimal(((TextBox)row.FindControl("txtEditPrice")).Text);
            int quantity = Convert.ToInt32(((TextBox)row.FindControl("txtEditQuantity")).Text);
            string imageUrl = ((TextBox)row.FindControl("txtEditImage")).Text;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE Products SET ProductName=@name, Price=@price, Quantity=@quantity, ImageUrl=@image WHERE ProductID=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@price", price);
                cmd.Parameters.AddWithValue("@quantity", quantity);
                cmd.Parameters.AddWithValue("@image", imageUrl);
                cmd.Parameters.AddWithValue("@id", productID);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvProducts.EditIndex = -1;
            BindGrid();
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Home.aspx");
        }
    }
}