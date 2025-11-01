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
        }

        /* ✅ Navbar เต็มจอ */
        .navbar {
            position: sticky;
            top: 0;
            width: 100%;
            background-color: #1e1e1e;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 50px;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.3);
            z-index: 1000;
            box-sizing: border-box;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .shop-name {
            color: #ff4d4d;
            font-size: 28px;
            font-weight: bold;
            text-shadow: 0 0 10px #ff1a1a;
        }

        .btn {
            padding: 8px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            color: white;
            background-color: #b30000;
            transition: all 0.3s ease-in-out;
        }

        .btn:hover {
            background-color: #ff1a1a;
            box-shadow: 0 0 10px #ff1a1a;
            transform: scale(1.05);
        }

        .btn-dark {
            background-color: #333;
        }

        .btn-dark:hover {
            background-color: #ff3333;
        }

        .search-bar {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-left: 20px;
        }

        .search-bar input[type="text"] {
            width: 220px;
            padding: 6px 10px;
            border: 1px solid #444;
            border-radius: 6px;
            background-color: #222;
            color: #fff;
            font-size: 14px;
        }

        .search-bar input[type="text"]:focus {
            outline: none;
            border-color: #ff4d4d;
        }

        /* ✅ เนื้อหา */
        form {
            width: 100%;
            margin: 0 auto;
            padding: 30px 50px;
            box-sizing: border-box;
        }

        .content {
            margin-top: 30px;
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

        /* ✅ Responsive: มือถือ */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
                padding: 15px 20px;
            }

            .navbar-right {
                flex-wrap: wrap;
                gap: 5px;
            }

            .search-bar input[type="text"] {
                width: 160px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">
            <div class="navbar-left">
                <span class="shop-name">I HAVE GPU</span>
            </div>

            <div class="navbar-right">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn" />
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="btn btn-dark" />
                <asp:Button ID="btnManageProducts" runat="server" Text="Manage Products" CssClass="btn" OnClick="btnManageProducts_Click" />
                
                <div class="search-bar">
                    <asp:TextBox ID="txtSearch" runat="server" Placeholder="ค้นหาชื่อสินค้า..." />
                    <asp:Button ID="btnSearch" runat="server" Text="ค้นหา" CssClass="btn" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>

        <div class="content">
            <asp:HyperLink ID="hlUserProfile" runat="server" Text="" NavigateUrl=""
                Style="font-weight:bold; font-size:20px; margin-bottom:20px; display:inline-block;" />

            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="false"
                CssClass="product-grid" OnRowCommand="gvProducts_RowCommand"
                DataKeyNames="ProductID">
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
        </div>
    </form>
</body>
</html>
