<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Project2.Pages.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>เข้าสู่ระบบ</title>
    <style>
        /* ภาพรวม */
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #f1f1f1;
            margin: 0;
            padding: 0;
        }

        /* กล่อง login */
        .login-container {
            width: 340px;
            margin: auto;
            margin-top: 80px;
            padding: 30px;
            background-color: #1e1e1e;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(255,0,0,0.3);
        }

        h2 {
            text-align: center;
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #ff4d4d;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 15px;
            border: 1px solid #555;
            border-radius: 5px;
            background-color: #222;
            color: #f1f1f1;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="text"]::placeholder, input[type="password"]::placeholder {
            color: #aaa;
        }

        #btnLogin {
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

        #btnLogin:hover {
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

        .register-link {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnBackHome" runat="server" Text="กลับหน้าหลัก" CssClass="btnBackHome" OnClick="btnBackHome_Click" />

        <div class="login-container">
            <h2>เข้าสู่ระบบ</h2>

            <label for="txtUsername">ชื่อผู้ใช้:</label>
            <asp:TextBox ID="txtUsername" runat="server" Width="100%" />

            <label for="txtPassword">รหัสผ่าน:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="100%" />

            <asp:Button ID="btnLogin" runat="server" Text="เข้าสู่ระบบ" OnClick="btnLogin_Click" /><br />

            <asp:Label ID="lblMsg" runat="server" /><br />

            <div class="register-link">
                ยังไม่ได้สมัครสมาชิก? <a href="Register.aspx">คลิกที่นี่</a>
            </div>
        </div>
    </form>
</body>
</html>
