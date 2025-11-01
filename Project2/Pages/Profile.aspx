<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Project2.Pages.Profile" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>โปรไฟล์ผู้ใช้</title>
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
            max-width: 700px;
            background-color: #1e1e1e;
            padding: 40px;
            margin: 40px auto;
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(255, 0, 0, 0.25);
            min-height: 70vh;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff1a1a;
            margin-bottom: 25px;
            border-bottom: 2px solid #ff1a1a;
            padding-bottom: 10px;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
            color: #f1f1f1;
        }

        input[type=text], textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #555;
            margin-bottom: 15px;
            font-size: 15px;
            background-color: #222;
            color: #f1f1f1;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input[type=text]:focus, textarea:focus {
            border-color: #ff1a1a;
            box-shadow: 0 0 8px #ff1a1a;
            outline: none;
        }

        textarea {
            resize: vertical;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #b30000;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s;
        }

        .btn:hover {
            background-color: #ff1a1a;
            box-shadow: 0 0 12px #ff1a1a;
            transform: scale(1.03);
        }

        #lblMessage {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            color: #ff4d4d;
        }

        .btnBackHome {
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 8px 16px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            z-index: 1000;
        }

        .btnBackHome:hover {
            background-color: #ff3333;
            box-shadow: 0 0 10px #ff1a1a;
        }

        /* ✅ Responsive */
        @media screen and (max-width: 768px) {
            form {
                padding: 25px;
                margin: 20px;
            }

            h2 {
                font-size: 22px;
            }

            .btn {
                font-size: 15px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnHistory" runat="server" Text="ดูประวัติการสั่งซื้อ" 
    OnClick="btnHistory_Click" CssClass="btn" />
            
        <asp:Button ID="btnBackHome" runat="server" Text="กลับหน้าหลัก" CssClass="btnBackHome" OnClick="btnBackHome_Click" />

        <h2>ข้อมูลส่วนตัว</h2>

        <asp:Label ID="lblUsername" runat="server" Font-Bold="True" Font-Size="18px" ForeColor="#ff4d4d" />

        <label>ชื่อ:</label>
        <asp:TextBox ID="txtFirstName" runat="server" />

        <label>นามสกุล:</label>
        <asp:TextBox ID="txtLastName" runat="server" />

        <label>ที่อยู่:</label>
        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" />

        <label>เบอร์โทรศัพท์:</label>
        <asp:TextBox ID="txtPhone" runat="server" />

        <asp:Button ID="btnUpdate" runat="server" Text="บันทึกการแก้ไข" CssClass="btn" OnClick="btnUpdate_Click" />

        <asp:Label ID="lblMessage" runat="server" />
    </form>
</body>
</html>
