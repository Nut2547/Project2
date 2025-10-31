<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Project2.Pages.Home" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>หน้าสินค้า</title>
    <style>
        /* ✅ ปรับให้เต็มจอ */
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

        /* ✅ ฟอร์มหลักเต็มจอและจัดกึ่งกลาง */
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

        #lblUserName {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            display: inline-block;
            color: #ff4d4d;
        }

        /* ✅ ปุ่มธีมแดง */
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

        /* ✅ ตารางขยายเต็มพื้นที่ */
        #<%= gvProducts.ClientID %> {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            color: #f1f1f1;
            table-layout: auto;
        }

        #<%= gvProducts.ClientID %> th {
            background-color: #b30000;
            color: white;
            padding: 14px;
            text-align: left;
            border-bottom: 3px solid #ff1a1a;
            font-size: 16px;
        }

        #<%= gvProducts.ClientID %> td {
            padding: 12px;
            border-bottom: 1px solid #333;
            font-size: 15px;
        }

        #<%= gvProducts.ClientID %> tr:hover {
            background-color: #2a2a2a;
        }

        /* ✅ ปรับขนาดรูปสินค้า */
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

        /* ✅ กล่องกรอกจำนวนสินค้า */
        .txt-qty {
            width: 70px;
            text-align: center;
            background-color: #222;
            color: #fff;
            border: 1px solid #555;
            border-radius: 4px;
            padding: 5px;
        }

        #lblShopName {
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            font-size: 36px !important;
            text-align: center;
            display: block;
            margin-bottom: 25px;
        }

        a, a:visited {
            color: #ff4d4d;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
            color: #ff1a1a;
        }

        /* ✅ Responsive: ปรับให้เข้ากับจอมือถือ */
        @media screen and (max-width: 768px) {
            form {
                padding: 20px;
                margin: 10px;
            }

            .btn {
                display: block;
                width: 100%;
                margin-bottom: 10px;
            }

            .gv-image {
                width: 70px;
                height: 70px;
            }

            #<%= gvProducts.ClientID %> th,
            #<%= gvProducts.ClientID %> td {
                font-size: 14px;
                padding: 10px;
            }

            #lblShopName {
                font-size: 28px !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblShopName" runat="server" Text="I HAVE GPU" />
        <asp:HyperLink ID="hlUserProfile" runat="server" Text="" NavigateUrl="" Style="font-weight:bold; font-size:20px; margin-bottom:20px; display:inline-block;" />

        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn" />
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="btn" />
        <asp:Button ID="btnManageProducts" runat="server" Text="Manage Products" CssClass="btn" OnClick="btnManageProducts_Click" />

<div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 15px;">
    <asp:TextBox ID="txtSearch" runat="server" 
        Placeholder="ค้นหาชื่อสินค้า..." 
        CssClass="form-control" 
        style="width: 250px; margin-right: 10px;" />
    <asp:Button ID="btnSearch" runat="server" 
        Text="ค้นหา" 
        OnClick="btnSearch_Click" 
        CssClass="btn btn-primary" />
</div>

<asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
    OnRowCommand="gvProducts_RowCommand">
    <Columns>
        <asp:BoundField DataField="ProductID" HeaderText="รหัสสินค้า" />
        <asp:BoundField DataField="ProductName" HeaderText="ชื่อสินค้า" />
        <asp:BoundField DataField="Price" HeaderText="ราคา" DataFormatString="{0:N2}" />
        <asp:BoundField DataField="Quantity" HeaderText="จำนวนคงเหลือ" />
        <asp:TemplateField HeaderText="จำนวนที่ต้องการ">
            <ItemTemplate>
                <asp:TextBox ID="txtQuantity" runat="server" Width="50px" Text="1"></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnAddToCart" runat="server" Text="เพิ่มลงตะกร้า"
                    CommandName="AddToCart" CommandArgument='<%# Eval("ProductID") %>'
                    CssClass="btn btn-success" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

    </form>
</body>
</html>
