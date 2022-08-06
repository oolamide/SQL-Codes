-- Module 1: Getting Started with Transact-SQL DEMO
-- USE SELECT QUERIES TO RETRIEVE DATA
-- Includes all columns for all products
SELECT * FROM SalesLT.Product;

-- Retrieve only the Name, StandardCost, and ListPrice columns for all products
SELECT Name, StandardCost, ListPrice
FROM SalesLT.Product;

-- Use an expression that results in a calculated column
-- Unnamed column containing the result of subtracting the StandardCost from the ListPrice.
SELECT Name, ListPrice - StandardCost
FROM SalesLT.Product;

-- The AS keyword has been used to assign an alias for each column in the results.
SELECT Name AS ProductName, ListPrice - StandardCost AS MarkUp
FROM SalesLT.Product

-- To concatenate the Color and Size column values (with a literal comma between them)
-- The behavior of this operator is determined by the data types of the columns.
-- For the numeric values, the + operator will add them. 
SELECT ProductNumber, Color, Size, Color + ',' + SIZE AS ProductDetails
FROM SalesLT.Product;

-- WORK WITH DATA TYPES

-- Note that this query returns an error. 
 SELECT ProductID + ': ' + Name AS ProductName
 FROM SalesLT.Product; 

-- The + operator can be used to concatenate text-based values, or add numeric values
-- CAST function is to change the numeric ProductID column into a varchar value 
-- that can be concatenated with other text-based values.
SELECT CAST (ProductID AS VARCHAR (5)) + ':' + Name AS ProductName
FROM SALESLT.Product;

-- Replace the CAST function with a CONVERT function
-- The CAST function is an ANSI standard part of the SQL language.
-- CONVERT is a SQL Server specific function.
SELECT CONVERT (varchar (5), ProductID) + ':' + Name AS ProductName
FROM SalesLT.Product

-- CONVERT includes an additional parameter that can be useful for
-- formatting date and time values when converting them to text-based data. 
 SELECT SellStartDate,
    CONVERT(nvarchar(30), SellStartDate) AS ConvertedDate,
    CONVERT(nvarchar(30), SellStartDate, 126) AS ISO8601FormatDate
 FROM SalesLT.Product; 

-- An error is returned because some Size values are not numeric 
SELECT Name, CAST(Size AS Integer) AS NumericSize
FROM SalesLT.Product; 

-- numeric Size values are converted successfully to integers, 
-- but that non-numeric sizes are returned as NULL.
SELECT Name, TRY_CAST(Size AS Integer) AS NumericSize
FROM SalesLT.Product; 

-- HANDLE NULL VALUES
--ISNULL function replaces NULL values with the specified value which is 0
-- ISNULL function is applied to the output of the inner TRY_CAST function
SELECT Name, ISNULL(TRY_CAST(Size AS Integer),0) AS NumericSize
FROM SalesLT.Product;

SELECT ProductNumber, Color, Size, Color + ',' + SIZE AS ProductDetails
    FROM SalesLT.Product

-- The ISNULL function replaces NULL values with a specified literal value. 
SELECT ProductNumber, Color, Size, 
    ISNULL(Color, '') + ', ' + ISNULL(Size, '') AS ProductDetails
FROM SalesLT.Product;

-- Sometimes, you may want to achieve the opposite result by 
-- replacing an explicit value with NULL.
-- To do this, you can use the NULLLIF function.
SELECT Name, Color,
    NULLIF(Color, 'Multi') AS SingleColor
FROM SalesLT.Product;

-- Compare multiple columns and find the first one that isn’t NULL. 
-- To find the first non-NULL column, you can use the COALESCE function.
-- Returns the last date on which the product selling status was updated
SELECT Name, 
    COALESCE(SellEndDate, SellStartDate) AS StatusLastUpdated
FROM SalesLT.Product;

-- To determine sales status, we’ll need to check the dates to see if the SellEndDate is NULL.
-- Using a CASE expression in the SELECT clause to check for NULL SellEndDate values.
-- To check to see if a value is NULL, you must use the IS NULL predicate; 
-- and conversely to check that a value is not NULL you can use the IS NOT NULL predicate.
-- A searched CASE that evaluates one or more expressions
SELECT Name, SellStartDate, SellEndDate,
     CASE
         WHEN SellEndDate IS NULL THEN 'Currently for sale'
         ELSE 'No longer available'
     END AS SalesStatus
FROM SalesLT.Product;

 -- A simple CASE that evaluates a specific column or value
 SELECT Name,
     CASE Size
         WHEN 'S' THEN 'Small'
         WHEN 'M' THEN 'Medium'
         WHEN 'L' THEN 'Large'
         WHEN 'XL' THEN 'Extra-Large'
         ELSE ISNULL(Size, 'n/a')
     END AS ProductSize
 FROM SalesLT.Product;
