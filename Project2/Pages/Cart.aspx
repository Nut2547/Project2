<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Project2.Pages.Cart" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>ตะกร้าสินค้า</title>
    <style>
        /* ✅ พื้นหลังเต็มจอ ธีมดำแดง */
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

        /* ✅ กล่องหลัก */
        form {
            width: 95%;
            max-width: 1000px;
            background-color: #1e1e1e;
            padding: 40px;
            margin: 30px auto;
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(255, 0, 0, 0.25);
            min-height: 80vh;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            font-size: 30px;
        }

        /* ✅ ปุ่ม */
        .btn {
            padding: 12px 25px;
            margin: 10px 8px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            color: white;
            transition: all 0.3s ease-in-out;
        }

        #btnClear {
            background-color: #b30000;
        }
        #btnCheckout {
            background-color: #009933;
        }
        #btnBackToShop {
            background-color: #333;
        }

        #btnClear:hover {
            background-color: #ff1a1a;
            box-shadow: 0 0 10px #ff1a1a;
            transform: scale(1.05);
        }
        #btnCheckout:hover {
            background-color: #00cc44;
            box-shadow: 0 0 10px #00cc44;
            transform: scale(1.05);
        }
        #btnBackToShop:hover {
            background-color: #ff3333;
            box-shadow: 0 0 10px #ff3333;
            transform: scale(1.05);
        }

        .btn-top {
            text-align: right;
            margin-bottom: 15px;
        }

        /* ✅ ตารางสินค้า */
        table, #<%= gvCart.ClientID %> {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            color: #f1f1f1;
            border-radius: 8px;
            overflow: hidden;
        }

        #<%= gvCart.ClientID %> th {
            background-color: #b30000;
            color: #fff;
            padding: 14px;
            border-bottom: 2px solid #ff1a1a;
            font-size: 16px;
        }

        #<%= gvCart.ClientID %> td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #333;
            background-color: #2a2a2a;
        }

        #<%= gvCart.ClientID %> tr:hover td {
            background-color: #3a3a3a;
        }

        /* ✅ ปรับรวมราคาให้เด่น */
        #<%= gvCart.ClientID %> td:last-child {
            color: #ff4d4d;
            font-weight: bold;
        }

        /* ✅ Responsive สำหรับมือถือ */
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

            #<%= gvCart.ClientID %> th,
            #<%= gvCart.ClientID %> td {
                font-size: 14px;
                padding: 10px;
            }

            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- ✅ ปุ่มกลับไปร้านค้า -->
        <div class="btn-top">
            <asp:Button ID="btnBackToShop" runat="server" Text="กลับไปหน้าร้านค้า" CssClass="btn" OnClick="btnBackToShop_Click" />
        </div>

        <h2>🛒 รายการสินค้าในตะกร้า</h2>

        <!-- ✅ ตารางแสดงสินค้า -->
        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" CssClass="product-grid"
            OnRowCommand="gvCart_RowCommand">
            <Columns>
                <asp:BoundField DataField="ProductID" HeaderText="ID" />
                <asp:BoundField DataField="ProductName" HeaderText="ชื่อสินค้า" />
                <asp:BoundField DataField="Price" HeaderText="ราคา (บาท)" DataFormatString="{0:N2}" />

                <asp:TemplateField HeaderText="จำนวน">
                    <ItemTemplate>
                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="รวมราคา (บาท)">
                    <ItemTemplate>
                        <%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- ✅ ปุ่มล้างตะกร้า & ชำระเงิน -->
        <div style="text-align:center; margin-top:30px;">
            <asp:Button ID="btnClear" runat="server" Text="ล้างตะกร้า" CssClass="btn" OnClick="btnClear_Click" />
            <asp:Button ID="btnCheckout" runat="server" Text="ชำระเงิน" CssClass="btn" OnClick="btnCheckout_Click" />
        </div>
    </form>
</body>
</html>
