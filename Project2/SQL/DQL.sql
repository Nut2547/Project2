--1. แสดงยอดขายรวมของแต่ละสินค้า
SELECT 
    P.ProductName,
    SUM(OD.Quantity) AS TotalSold,
    SUM(OD.Quantity * OD.Price) AS TotalRevenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalRevenue DESC;

--2.แสดงบิลทั้งหมดพร้อมชื่อผู้สั่งซื้อ
SELECT 
    O.OrderID,
    U.UserName,
    O.OrderDate,
    O.TotalAmount
FROM Orders O
JOIN Users U ON O.UserID = U.UserID
ORDER BY O.OrderDate DESC;

--3. แสดงสินค้าที่มียอดขายเกิน 100 ชิ้น
SELECT 
    P.ProductName,
    SUM(OD.Quantity) AS TotalSold
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
HAVING SUM(OD.Quantity) > 100;

--4. แสดงสินค้าที่ไม่เคยถูกสั่งซื้อเลย
SELECT 
    P.ProductID,
    P.ProductName
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL;

--5. แสดงข้อมูลคำสั่งซื้อพร้อมยอดรวมของแต่ละรายการ
SELECT 
    O.OrderID,
    COUNT(OD.ProductID) AS ItemsCount,
    SUM(OD.Price * OD.Quantity) AS OrderTotal
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID;

--6. ดึงประวัติการสั่งซื้อของผู้ใช้แต่ละคน
SELECT U.UserName, U.FirstName, U.LastName, P.OrderID, P.OrderDate, P.TotalAmount
FROM Users U
JOIN PurchaseOrders P ON U.UserName = P.UserName
ORDER BY P.OrderDate DESC;

--7. หายอดรวมการขายของแต่ละวัน
SELECT 
    CONVERT(date, OrderDate) AS OrderDate,
    SUM(TotalAmount) AS DailyTotal
FROM PurchaseOrders
GROUP BY CONVERT(date, OrderDate)
ORDER BY OrderDate DESC;

--8. แสดงรายละเอียดคำสั่งซื้อพร้อมจำนวนสินค้าในแต่ละบิล
SELECT 
    PO.OrderID,
    PO.UserName,
    COUNT(OP.ProductID) AS ProductCount,
    PO.TotalAmount
FROM PurchaseOrders PO
JOIN OrderProducts OP ON PO.OrderID = OP.OrderID
GROUP BY PO.OrderID, PO.UserName, PO.TotalAmount
ORDER BY PO.OrderID DESC;

--9. แสดงผู้ใช้แต่ละ Role พร้อมจำนวนผู้ใช้ในแต่ละ Role
SELECT Role, COUNT(UserID) AS TotalUsers
FROM Users
GROUP BY Role;

--10. แสดงชื่อผู้ใช้และเบอร์โทรของผู้ใช้ที่ไม่มีที่อยู่ (Address ว่าง)
SELECT Username, Phone
FROM Users
WHERE Address IS NULL OR Address = '';