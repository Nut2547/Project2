<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Project2.Pages.Register" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>สมัครสมาชิก</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #f1f1f1;
            margin: 0;
            padding: 0;
        }

        .register-container {
            width: 380px;
            margin: auto;
            margin-top: 60px;
            padding: 30px;
            background-color: #1e1e1e;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(255,0,0,0.3);
        }

        h2 {
            text-align: center;
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #ff4d4d;
        }

        input[type="text"], input[type="password"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 14px;
            border: 1px solid #555;
            border-radius: 5px;
            font-size: 14px;
            background-color: #222;
            color: #f1f1f1;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        #btnRegister {
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

        #btnRegister:hover {
            background-color: #ff1a1a;
            box-shadow: 0 0 10px #ff1a1a;
        }

        #lblMsg {
            margin-top: 15px;
            display: block;
            text-align: center;
            font-size: 14px;
            color: #ff4d4d;
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

        a {
            color: #ff4d4d;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #ff1a1a;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnBackHome" runat="server" Text="กลับหน้าหลัก" CssClass="btnBackHome" OnClick="btnBackHome_Click" />

        <div class="register-container">
            <h2>สมัครสมาชิก</h2>

            <label>ชื่อผู้ใช้:</label>
            <asp:TextBox ID="txtUsername" runat="server" />

            <label>รหัสผ่าน:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />

            <label>ชื่อจริง:</label>
            <asp:TextBox ID="txtFirstName" runat="server" />

            <label>นามสกุล:</label>
            <asp:TextBox ID="txtLastName" runat="server" />

            <label>ที่อยู่:</label>
            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" />

            <label>เบอร์โทรศัพท์:</label>
            <asp:TextBox ID="txtPhone" runat="server" />

            <asp:HiddenField ID="hiddenRole" runat="server" Value="User" />

            <asp:Button ID="btnRegister" runat="server" Text="สมัครสมาชิก" OnClick="btnRegister_Click" />

            <asp:Label ID="lblMsg" runat="server" />
        </div>
    </form>
</body>
</html>
