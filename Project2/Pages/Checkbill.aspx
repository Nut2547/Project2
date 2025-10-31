<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckBill.aspx.cs" Inherits="Project2.Pages.CheckBill" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>ตรวจสอบบิลก่อนชำระเงิน</title>
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

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #ff4d4d;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            background-color: #222;
            color: #fff;
            border: 1px solid #555;
            border-radius: 5px;
            font-size: 15px;
        }

        input:focus, textarea:focus {
            border-color: #ff4d4d;
            box-shadow: 0 0 10px #ff4d4d;
            outline: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            color: #f1f1f1;
        }

        th, td {
            padding: 12px;
            border: 1px solid #333;
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

        #btnConfirm {
            background-color: #ff3333;
        }

        #btnCancel {
            background-color: #333;
        }

        #btnCancel:hover {
            background-color: #ff1a1a;
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

        .button-container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>ตรวจสอบบิลก่อนชำระเงิน</h2>

        <!-- 🔹 ฟอร์มข้อมูลลูกค้า -->
        <label for="txtName">ชื่อผู้รับสินค้า:</label>
        <asp:TextBox ID="txtName" runat="server" />

        <label for="txtAddress">ที่อยู่สำหรับจัดส่ง:</label>
        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" />

        <label for="txtPhone">เบอร์โทรศัพท์:</label>
        <asp:TextBox ID="txtPhone" runat="server" />

        <!-- 🔹 ตารางสินค้า -->
        <asp:GridView ID="gvBill" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="ProductID" HeaderText="รหัสสินค้า" />
                <asp:BoundField DataField="ProductName" HeaderText="ชื่อสินค้า" />
                <asp:BoundField DataField="Price" HeaderText="ราคา (บาท)" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="Quantity" HeaderText="จำนวน" />
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblTotal" runat="server" Font-Bold="true" />

        <div class="button-container">
            <asp:Button ID="btnConfirm" runat="server" Text="ยืนยันการสั่งซื้อ" CssClass="btn" OnClick="btnConfirm_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="ยกเลิก" CssClass="btn" OnClick="btnCancel_Click" />
        </div>
    </form>
</body>
</html>
