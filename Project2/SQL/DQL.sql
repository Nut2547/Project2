--1. แสดงชื่อสินค้าทั้งหมดพร้อมจำนวนสินค้าในคลัง
SELECT ProductName, Quantity
FROM Products;

--2.แสดงราคาสินค้าเฉลี่ยในระบบทั้งหมด
SELECT AVG(Price) AS AveragePrice
FROM Products;

--3. แสดงสินค้าที่มีราคาสูงกว่าราคาเฉลี่ย
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

--4. แสดงสินค้าที่มีจำนวนคงเหลือต่ำกว่า 5 ชิ้น
SELECT ProductID, ProductName, Quantity
FROM Products
WHERE Quantity < 5;

--5. รวมราคาสินค้าทั้งหมดในสต็อก
SELECT SUM(Price * Quantity) AS TotalStockValue
FROM Products;

--6. แสดงสินค้าราคาสูงสุดและต่ำสุด
SELECT 
    (SELECT ProductName FROM Products WHERE Price = (SELECT MAX(Price) FROM Products)) AS MostExpensiveProduct,
    (SELECT ProductName FROM Products WHERE Price = (SELECT MIN(Price) FROM Products)) AS CheapestProduct;

--7. แสดงจำนวนสินค้าทั้งหมดในระบบ
SELECT COUNT(ProductID) AS TotalProducts
FROM Products;

--8. แสดงชื่อ-นามสกุลผู้ใช้ทั้งหมดเรียงตามชื่อ
SELECT FirstName + ' ' + LastName AS FullName
FROM Users
ORDER BY FirstName ASC;

--9. แสดงผู้ใช้แต่ละ Role พร้อมจำนวนผู้ใช้ในแต่ละ Role
SELECT Role, COUNT(UserID) AS TotalUsers
FROM Users
GROUP BY Role;

--10. แสดงชื่อผู้ใช้และเบอร์โทรของผู้ใช้ที่ไม่มีที่อยู่ (Address ว่าง)
SELECT Username, Phone
FROM Users
WHERE Address IS NULL OR Address = '';