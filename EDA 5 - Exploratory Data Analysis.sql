--Use Inner Joins
--An inner join is used to find related data in two tables
--Find the relevant product category record for a product based on its ProductCategoryID field
--Foreign key in the product table that matches a primary key in the product category table

SELECT *
FROM  SalesLT.Product

SELECT * 
FROM [SalesLT].[ProductCategory]

SELECT SalesLT.Product.Name As ProductName, ---Column on Table 1
 SalesLT.ProductCategory.Name AS Category ----Column on Table 2
 FROM SalesLT.Product                    ---Table 1
 JOIN SalesLT.ProductCategory       ---Table 2
 ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID; ---Common column to the two tables

--The use of table aliases can greatly simplify a query
SELECT p.Name AS ProductName, c.Name AS Category
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
    ON p.ProductCategoryID = c.ProductCategoryID;

SELECT p.Name AS ProductName, c.Name AS Category
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c
    ON c.ProductCategoryID = p.ProductCategoryID;

---Return data from all three tables 
 SELECT soh.OrderDate, soh.SalesOrderNumber, p.Name AS ProductName, sod.OrderQty, sod.UnitPrice, sod.LineTotal
 FROM SalesLT.SalesOrderHeader AS soh
 JOIN SalesLT.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
 JOIN SalesLT.Product as p
    ON sod.ProductID = p.ProductID;

--USE outer Joins
SELECT c.FirstName, c.LastName, soh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID;

--Identifies non-matching rows and return only the customers who have not placed any orders.
--Contaon data for customers who have not placed any orders.
SELECT c.FirstName, c.LastName, soh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderNumber IS NULL
ORDER BY c.CustomerID;

--All subsequent outer joins must be of the same direction (LEFT or RIGHT).
SELECT p.Name AS ProductName, oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS od
    ON p.ProductID =od.ProductID
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON od.SalesOrderID =oh.SalesOrderID
ORDER BY p.ProductID;

--Croos Join
--A cross join matches all possible combinations of rows from the tables being joined
SELECT *
FROM

--Use a self join
--a technique used to join a table to itself by defining two instances of the table, each with its own alias
--This approach can be useful when a wor in the table include a foreign key field that refrences the primary key of the 
SELECT pcat.Name AS ParentCategory, cat.Name AS SubCategory
FROM SalesLT.ProductCategory AS cat
JOIN SalesLT.ProductCategory AS pcat
    ON cat.ParentProductCategoryID = pcat.ProductCategoryID
ORDER BY ParentCategory, SubCategory;
