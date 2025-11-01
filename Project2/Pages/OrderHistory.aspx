<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="Project2.Pages.OrderHistory" %>

<!DOCTYPE html>
<html>
<head>
    <title>ประวัติการสั่งซื้อ</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #121212;
            color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #ff3b3b;
            margin-top: 30px;
        }

        .table {
            width: 80%;
            margin: 40px auto;
            border-collapse: collapse;
            background-color: #1e1e1e;
            box-shadow: 0 3px 10px rgba(255, 0, 0, 0.3);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #333;
            text-align: center;
        }

        th {
            background-color: #ff3b3b;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #292929;
        }

        .btn-home {
            display: block;
            width: 150px;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #ff3b3b;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
        }

        .btn-home:hover {
            background-color: #ff5c5c;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>ประวัติการสั่งซื้อของคุณ</h2>

        <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="table">
            <Columns>
                <asp:BoundField HeaderText="วันที่สั่งซื้อ" DataField="OrderDate" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                <asp:BoundField HeaderText="ยอดรวม (บาท)" DataField="TotalAmount" />
            </Columns>
        </asp:GridView>

        <asp:Button ID="btnBackHome" runat="server" Text="กลับหน้า HOME" CssClass="btn-home" OnClick="btnBackHome_Click" />
    </form>
</body>
</html>
