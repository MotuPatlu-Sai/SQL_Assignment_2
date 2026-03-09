create database assignment_6;

use assignment_6;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

#Q6. Write a CTE to calculate the total revenue for each product(Revenues = Price × Quantity), and return only products where  revenue > 3000
with prevenue as
(
	select p.ProductID, p.ProductName, sum(p.price*s.quantity) as Revenue
	from Products as p join Sales as s
	on p.ProductID = s.ProductID
	group by p.ProductID, p.ProductName
)
SELECT *
FROM prevenue
WHERE Revenue > 3000;

#Create a view named vw_CateorysSummary that shows: Category, TotalProducts, AveragePrice.
create view vw_CategorySummary as
select category, 
	COUNT(ProductID) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

#Create an updatable view containing ProductID, ProductName, and Price. Then update the price of ProductID = 1 using the view
CREATE VIEW vw_ProductDetails AS
SELECT ProductID, ProductName, Price
FROM Products;
UPDATE vw_ProductDetails
SET Price = 1300
WHERE ProductID = 1;

#Create a stored procedure that accepts a category name and returns all products belonging to that category.
DELIMITER $$
CREATE PROCEDURE GetProductsByCategory(
    IN CategoryName VARCHAR(50)
)
BEGIN
    SELECT *
    FROM Products
    WHERE Category = CategoryName;
END $$
DELIMITER ;
CALL GetProductsByCategory('Electronics');

#Create an AFTER DELETE trigger on the table that archives deleted product rows into a new table ProductArchive. The archive should store ProductID, ProductName, Category, Price, and DeletedAt timestamp. Products Product
CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);
DELIMITER $$

CREATE TRIGGER trg_AfterDeleteProduct
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive
    (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES
    (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END $$

DELIMITER ;