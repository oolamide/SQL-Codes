-- SUBQUERIES
-- A subquery is a query that is nested within another query
-- The subquery is often referred to as the inner query
-- and the query within which it is nested is referred to as the outer query.

-- the highest price for which any individual product has been sold).
 SELECT MAX(UnitPrice)
 FROM SalesLT.SalesOrderDetail;

-- retrieves products with a ListPrice higher than the maximum selling price.
 SELECT Name, ListPrice
 FROM SalesLT.Product
 WHERE ListPrice >
     (SELECT MAX(UnitPrice)
      FROM SalesLT.SalesOrderDetail);

-- returns the ProductID for each product that has been ordered in quantities of 20 or more.
 SELECT DISTINCT ProductID
 FROM SalesLT.SalesOrderDetail
 WHERE OrderQty >= 20;

-- Query to eturns the product names.
SELECT Name FROM SalesLT.Product
 WHERE ProductID IN
     (SELECT DISTINCT ProductID
      FROM SalesLT.SalesOrderDetail
      WHERE OrderQty >= 20);

-- Often you can achieve the same outcome with a subquery or a join.
SELECT DISTINCT Name
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS o
    ON p.ProductID = o.ProductID
WHERE OrderQty >= 20;


-- BUILT-IN FUNCTIONS

--  Scalar functions

-- Functions that you can use to extract additional information from your data
-- Scalar functions that return a single value based on one or more input parameters, often a data field.

-- YEAR function has retrieved the year from the SellStartDate field.
SELECT YEAR(SellStartDate) AS SellStartYear, ProductID, Name
 FROM SalesLT.Product
 ORDER BY SellStartYear;

-- DATENAME function returns a different value depending on the datepart parameter that is passed to it.
-- mm returns the month name, and dw returns the weekday name.
-- DATEDIFF function returns the specified time interval between and start date and an end date. 
-- GETDATE function; which when used with no parameters returns the current date and time.
SELECT YEAR(SellStartDate) AS SellStartYear,
        DATENAME(mm,SellStartDate) AS SellStartMonth,
        DAY(SellStartDate) AS SellStartDay,
        DATENAME(dw, SellStartDate) AS SellStartWeekday,
        DATEDIFF(yy,SellStartDate, GETDATE()) AS YearsSold,
        ProductID,
        Name
 FROM SalesLT.Product
 ORDER BY SellStartYear;

 -- returns the concatenated first and last name for each customer.
 SELECT CONCAT(FirstName + ' ', LastName) AS FullName
 FROM SalesLT.Customer;


-- String functions
 -- code to explore some more functions that manipulate string-based values.
  SELECT UPPER(Name) AS ProductName,
        ProductNumber,
        ROUND(Weight, 0) AS ApproxWeight,
        LEFT(ProductNumber, 2) AS ProductType
 FROM SalesLT.Product; 


 -- Use logical functions

 -- the results only products with a numeric size.
 SELECT Name, Size AS NumericSize
 FROM SalesLT.Product
 WHERE ISNUMERIC(Size) = 1;

-- ISNUMERIC function and returns Numeric if the result is 1 (true), and Non-Numeric otherwise.
SELECT Name, Size, IIF(ISNUMERIC(Size) = 1, 'Numeric', 'Non-Numeric') AS SizeType
 FROM SalesLT.Product;

-- CHOOSE function returns the value in the ordinal position in a list based on the a specified index value. 
 SELECT prd.Name AS ProductName,
        cat.Name AS Category,
        CHOOSE (cat.ParentProductCategoryID, 'Bikes','Components','Clothing','Accessories') AS ProductType
 FROM SalesLT.Product AS prd
 JOIN SalesLT.ProductCategory AS cat
     ON prd.ProductCategoryID = cat.ProductCategoryID;

-- Use aggregate functions

--Aggregate functions return an aggregated value, such as a sum, count, average, minimum, or maximum
--The number of products in the table. This is returned by using the COUNT function to count the number of rows (*).
-- COUNT function to count the number of distinct category IDs in the table.
--The average price of a product. This is returned by using the AVG function with the ListPrice field.
 SELECT COUNT(*) AS Products,
        COUNT(DISTINCT ProductCategoryID) AS Categories,
        AVG(ListPrice) AS AveragePrice
 FROM SalesLT.Product;

--Returns the number of models and the average price for products with category names that end in “bikes”
 SELECT COUNT(p.ProductID) AS BikeModels, AVG(p.ListPrice) AS AveragePrice
 FROM SalesLT.Product AS p
 JOIN SalesLT.ProductCategory AS c
     ON p.ProductCategoryID = c.ProductCategoryID
 WHERE c.Name LIKE '%Bikes';


-- Group aggregated results with the GROUP BY clause

-- Aggregate functions are especially useful when combined with the GROUP BY 
-- clause to calculate aggregations for different groups of data.

-- returns the number of customers assigned to each salesperson.
SELECT Salesperson, COUNT(CustomerID) AS Customers
 FROM SalesLT.Customer
 GROUP BY Salesperson
 ORDER BY Salesperson;

-- returns the total sales revenue for each salesperson who has completed any sales
SELECT c.Salesperson, SUM(oh.SubTotal) AS SalesRevenue
 FROM SalesLT.Customer c
 JOIN SalesLT.SalesOrderHeader oh
     ON c.CustomerID = oh.CustomerID
 GROUP BY c.Salesperson
 ORDER BY SalesRevenue DESC;

-- returns the sales totals for salespeople who have sold items, and 0.00 for those who haven’t
SELECT c.Salesperson, ISNULL(SUM(oh.SubTotal), 0.00) AS SalesRevenue
 FROM SalesLT.Customer c
 LEFT JOIN SalesLT.SalesOrderHeader oh
     ON c.CustomerID = oh.CustomerID
 GROUP BY c.Salesperson
 ORDER BY SalesRevenue DESC;

-- Filter groups with the HAVING clause

-- After grouping data, you may want to filter the results to include only the groups that meet specified criteria. 

-- The WHERE clause is applied before the aggregations and the GROUP BY clause
-- so you can’t use it to filter on the aggregated value.
SELECT Salesperson, COUNT(CustomerID) AS Customers
 FROM SalesLT.Customer
 WHERE COUNT(CustomerID) > 100
 GROUP BY Salesperson
 ORDER BY Salesperson;

-- HAVING clause is applied after the aggregations and GROUP BY clause.
-- Returns only salespeople who have more than 100 customers assigned to them.
SELECT Salesperson, COUNT(CustomerID) AS Customers
 FROM SalesLT.Customer
 GROUP BY Salesperson
 HAVING COUNT(CustomerID) > 100
 ORDER BY Salesperson;
