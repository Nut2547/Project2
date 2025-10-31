
CREATE TABLE [dbo].[Users] (
    [UserID]    INT            IDENTITY (1, 1) NOT NULL,
    [Username]  NVARCHAR (100) NOT NULL,
    [Password]  NVARCHAR (100) NOT NULL,
    [Role]      NVARCHAR (10)  DEFAULT ('User') NULL,
    [FirstName] NVARCHAR (100) NULL,
    [LastName]  NVARCHAR (100) NULL,
    [Address]   NVARCHAR (255) NULL,
    [Phone]     NVARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    UNIQUE NONCLUSTERED ([Username] ASC)
);


CREATE TABLE [dbo].[Products] (
    [ProductID]   INT             IDENTITY (1, 1) NOT NULL,
    [ProductName] NVARCHAR (100)  NULL,
    [Price]       DECIMAL (10, 2) NULL,
    [ImageUrl]    NVARCHAR (200)  NULL,
    [Quantity]    INT             DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC)
);
