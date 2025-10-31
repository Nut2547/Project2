<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewBill.aspx.cs" Inherits="Project2.Pages.ViewBill" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>บิลการสั่งซื้อ</title>
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
            margin: 0 auto;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            margin-bottom: 20px;
        }

        .info {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #222;
            border: 1px solid #555;
            border-radius: 10px;
        }

        .info p {
            margin: 6px 0;
            color: #ff4d4d;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            color: #f1f1f1;
        }

        th, td {
            border: 1px solid #333;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #b30000;
            color: white;
            border-bottom: 2px solid #ff1a1a;
        }

        tr:hover {
            background-color: #2a2a2a;
        }

        #lblTotal {
            display: block;
            text-align: right;
            font-size: 18px;
            margin-top: 20px;
            color: #ff4d4d;
            font-weight: bold;
            text-shadow: 0 0 5px #ff1a1a;
        }

        .btn {
            padding: 12px 25px;
            margin: 10px 10px 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
            color: white;
            background-color: #b30000;
        }

        .btn:hover {
            background-color: #ff1a1a;
            box-shadow: 0 0 10px #ff1a1a;
        }

        #btnHome {
            background-color: #333;
        }

        #btnHome:hover {
            background-color: #ff3333;
        }

        #btnPrint {
            background-color: #ff3333;
        }

        #btnPrint:hover {
            background-color: #ff1a1a;
        }

        .button-group {
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript">
        function printBill() {
            window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <h2>บิลการสั่งซื้อ</h2>

        <div class="info">
            <p><strong>ชื่อผู้รับ:</strong> <asp:Label ID="lblName" runat="server" /></p>
            <p><strong>ที่อยู่:</strong> <asp:Label ID="lblAddress" runat="server" /></p>
            <p><strong>เบอร์โทร:</strong> <asp:Label ID="lblPhone" runat="server" /></p>
        </div>

        <asp:GridView ID="gvBillView" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="ProductID" HeaderText="รหัสสินค้า" />
                <asp:BoundField DataField="ProductName" HeaderText="ชื่อสินค้า" />
                <asp:BoundField DataField="Price" HeaderText="ราคา (บาท)" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="Quantity" HeaderText="จำนวน" />
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblTotal" runat="server" Font-Bold="true" />

        <div class="button-group">
            <asp:Button ID="btnHome" runat="server" Text="กลับหน้าแรก" CssClass="btn" OnClick="btnHome_Click" />
            <input type="button" id="btnPrint" value="พิมพ์บิล" class="btn" onclick="printBill()" />
        </div>
    </form>
</body>
</html>
