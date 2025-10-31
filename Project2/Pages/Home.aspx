<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Project2.Pages.Home" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>หน้าสินค้า</title>
    <style>
        html, body {
            height: 100%;
            width: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #f1f1f1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        form {
            width: 95%;
            max-width: 1600px;
            background-color: #1e1e1e;
            padding: 40px;
            margin: 30px auto;
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(255, 0, 0, 0.25);
            min-height: 85vh;
            box-sizing: border-box;
        }

        .btn {
            padding: 12px 25px;
            margin: 10px 10px 20px 0;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            color: white;
            background-color: #b30000;
            transition: all 0.3s ease-in-out;
        }

        .btn:hover {
            background-color: #ff1a1a;
            box-shadow: 0 0 12px #ff1a1a;
            transform: scale(1.03);
        }

        #btnLogout {
            float: right;
            background-color: #333;
        }

        #btnLogout:hover {
            background-color: #ff3333;
        }

        #lblShopName {
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            font-size: 36px !important;
            text-align: center;
            display: block;
            margin-bottom: 25px;
        }

        /* ✅ ช่องค้นหาด้านขวา */
        .search-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar input[type="text"] {
            width: 250px;
            padding: 8px 12px;
            border: 1px solid #444;
            border-radius: 6px;
            background-color: #222;
            color: #fff;
            font-size: 15px;
            margin-right: 10px;
        }

        .search-bar input[type="text"]:focus {
            outline: none;
            border-color: #ff4d4d;
        }

        .gv-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #ff4d4d;
            transition: transform 0.3s ease;
        }

        .gv-image:hover {
            transform: scale(1.05);
        }

        .txt-qty {
            width: 70px;
            text-align: center;
            background-color: #222;
            color: #fff;
            border: 1px solid #555;
            border-radius: 4px;
            padding: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblShopName" runat="server" Text="I HAVE GPU" />
        <asp:HyperLink ID="hlUserProfile" runat="server" Text="" NavigateUrl=""
            Style="font-weight:bold; font-size:20px; margin-bottom:20px; display:inline-block;" />

        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn" />
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="btn" />
        <asp:Button ID="btnManageProducts" runat="server" Text="Manage Products" CssClass="btn" OnClick="btnManageProducts_Click" />

        <!-- ✅ เพิ่มช่องค้นหาด้านขวา -->
        <div class="search-bar">
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="ค้นหาชื่อสินค้า..." />
            <asp:Button ID="btnSearch" runat="server" Text="ค้นหา" CssClass="btn" OnClick="btnSearch_Click" />
        </div>

        <!-- ✅ ตารางสินค้า -->
        <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="false" CssClass="product-grid"
            OnRowCommand="gvProducts_RowCommand" DataKeyNames="ProductID">
            <Columns>
                <asp:BoundField DataField="ProductName" HeaderText="ชื่อสินค้า" />
                <asp:BoundField DataField="Price" HeaderText="ราคา" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="Quantity" HeaderText="จำนวนสินค้าในสต็อก" />

                <asp:TemplateField HeaderText="รูปภาพ">
                    <ItemTemplate>
                        <asp:Image ID="imgProduct" runat="server" 
                            ImageUrl='<%# Eval("ImageUrl") %>' 
                            CssClass="gv-image" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="จำนวนที่ต้องการ">
                    <ItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="txt-qty" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="ซื้อสินค้า">
                    <ItemTemplate>
                        <asp:Button ID="btnAddToCart" runat="server" Text="ซื้อสินค้า" 
                            CommandName="AddToCart" CommandArgument='<%# Eval("ProductID") %>'
                            CssClass="btn" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
