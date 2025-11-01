
CREATE TABLE Users (
    UserID    INT            IDENTITY (1, 1) NOT NULL,
    Username  NVARCHAR (100) NOT NULL,
    Password  NVARCHAR (100) NOT NULL,
    Role      NVARCHAR (10)  DEFAULT ('User') NULL,
    FirstName NVARCHAR (100) NULL,
    LastName  NVARCHAR (100) NULL,
    Address   NVARCHAR (255) NULL,
    Phone     NVARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED (UserID ASC),
    UNIQUE NONCLUSTERED (Username ASC)
);


CREATE TABLE Products (
    ProductID   INT             IDENTITY (1, 1) NOT NULL,
    ProductName NVARCHAR (100)  NULL,
    Price       DECIMAL (10, 2) NULL,
    ImageUrl    NVARCHAR (200)  NULL,
    Quantity    INT             DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID ASC)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
