<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProducts.aspx.cs" Inherits="Project2.Pages.ManageProducts" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>จัดการสินค้า (Admin)</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #121212;
        color: #f1f1f1;
        margin: 0;
        padding: 20px;
    }

    form {
        max-width: 900px;
        margin: auto;
        background-color: #1e1e1e;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(255,0,0,0.3);
    }

    h2 {
        color: #ff4d4d;
        text-shadow: 0 0 10px #ff1a1a;
        margin-bottom: 20px;
        border-bottom: 2px solid #ff1a1a;
        padding-bottom: 10px;
    }

    input[type="text"] {
        width: 100%;
        padding: 10px 12px;
        margin-bottom: 15px;
        border: 1px solid #555;
        border-radius: 5px;
        font-size: 14px;
        background-color: #222;
        color: #f1f1f1;
        box-sizing: border-box;
    }

    #btnAdd {
        width: 100%;
        padding: 12px;
        background-color: #b30000;
        border: none;
        border-radius: 5px;
        color: white;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s;
    }

    #btnAdd:hover {
        background-color: #ff1a1a;
        box-shadow: 0 0 10px #ff1a1a;
    }

    .gridview {
        width: 100%;
        border-collapse: collapse;
        margin-top: 30px;
        color: #f1f1f1;
    }

    .gridview th {
        background-color: #b30000;
        color: white;
        padding: 12px;
    }

    .gridview td {
        border-bottom: 1px solid #333;
        padding: 12px;
        vertical-align: middle;
    }

    .gridview tr:hover {
        background-color: #2a2a2a;
    }

    /* รูปภาพใน GridView */
    .gv-image {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 5px;
        border: 1px solid #ff4d4d;
    }

    .gv-edit-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 5px;
        border: 1px solid #ff4d4d;
        margin-top: 5px;
    }

    .aspNet-CommandField button {
        padding: 6px 12px;
        background-color: #b30000;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.3s;
    }

    .aspNet-CommandField button:hover {
        background-color: #ff1a1a;
    }

    /* ปุ่มกลับหน้า Home */
    .btnBackHome {
        position: absolute;
        top: 20px;
        left: 20px;
        padding: 8px 16px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.3s;
        z-index: 1000;
    }

    .btnBackHome:hover {
        background-color: #ff3333;
        box-shadow: 0 0 10px #ff1a1a;
    }
</style>

</head>

<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnBackHome" runat="server" Text="กลับหน้าหลัก" CssClass="btnBackHome" OnClick="btnBackHome_Click" />
        
        <h2>เพิ่มสินค้า</h2>
        <asp:TextBox ID="txtName" runat="server" placeholder="ชื่อสินค้า" />
        <asp:TextBox ID="txtPrice" runat="server" placeholder="ราคา" />
        <asp:TextBox ID="txtImage" runat="server" placeholder="ลิงก์รูปภาพ" />
        <asp:TextBox ID="txtQuantity" runat="server" placeholder="จำนวนสินค้า" />

        <asp:Button ID="btnAdd" runat="server" Text="เพิ่มสินค้า" OnClick="btnAdd_Click" />

        <h2 style="margin-top:50px;">รายการสินค้า</h2>
<asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID"
    OnRowEditing="gvProducts_RowEditing"
    OnRowCancelingEdit="gvProducts_RowCancelingEdit"
    OnRowUpdating="gvProducts_RowUpdating"
    OnRowDeleting="gvProducts_RowDeleting"
    CssClass="gridview">
    <Columns>
        <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" />

        <asp:TemplateField HeaderText="ชื่อสินค้า">
            <ItemTemplate>
                <%# Eval("ProductName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("ProductName") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="ราคา">
            <ItemTemplate>
                <%# Eval("Price", "{0:C}") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditPrice" runat="server" Text='<%# Bind("Price") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="จำนวน">
            <ItemTemplate>
                <%# Eval("Quantity") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditQuantity" runat="server" Text='<%# Bind("Quantity") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

 <asp:TemplateField HeaderText="รูปภาพ">
    <ItemTemplate>
        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="gv-image" />
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtEditImage" runat="server" Text='<%# Bind("ImageUrl") %>' />
        <br />
        <asp:Image ID="imgPreview" runat="server" ImageUrl='<%# Bind("ImageUrl") %>' CssClass="gv-edit-image" />
    </EditItemTemplate>
</asp:TemplateField>


        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="จัดการ" />
    </Columns>
</asp:GridView>

    </form>
</body>
</html>
