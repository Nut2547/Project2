CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Address NVARCHAR(255),
    Phone NVARCHAR(20)
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    ImageUrl NVARCHAR(255),
    Quantity INT NOT NULL
);
