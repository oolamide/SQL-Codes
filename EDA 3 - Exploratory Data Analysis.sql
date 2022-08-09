SELECT  Name, ListPrice
FROM [SalesLT].[Product]
ORDER BY ListPrice;

SELECT  Name, ListPrice
FROM [SalesLT].[Product]
ORDER BY Name;

SELECT  Name, ListPrice
FROM [SalesLT].[Product]
ORDER BY ListPrice DESC;

SELECT  Name, ListPrice
FROM [SalesLT].[Product]
ORDER BY ListPrice DESC, Name ASC;

--RESTRICT RESULTS USING TOP
--FIND THE 20 MOST EXPENSIVE PRODUCTS.
--Include an ORDER BY clause when using the TOP parameter
--Products that  same price will be ignored
SELECT TOP 20 Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;

--Multiple products that share the same price
SELECT TOP 20 WITH TIES Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;

--The results contain the 20% most expensive products.
SELECT TOP 20 PERCENT Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;

--Retrieve pages of results with OFFSET and FETCH
--The first page of results with 10 rows per page.
SELECT Name, ListPrice
FROM SalesLT.Product
ORDER BY Name OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY

--Retrieve the next page of results.
SELECT Name, ListPrice
FROM SalesLT.Product
ORDER BY Name OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

--Get list of the unique color
SELECT DISTINCT Color
FROM SalesLT.Product;

--Get list of the unique color and size together
SELECT DISTINCT Color, [Size]
FROM SalesLT.Product;

--Filter reults with WHERE clause
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID <> 6
ORDER BY Name;

--All products with a ProductModelID except 6
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 6
ORDER BY Name;

--All products with a ListPrice greater than 1000.00
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ListPrice > 1000.00
ORDER BY Name;

--Like operator enables you to match string patterns
--The % character in the predicate is a wildcard for one or more characters
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Name LIKE 'HL Road Frame %';

--The _ character brings out and word that has any letter followed with L
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '_L Road Frame %';

--Matrces patterns similar to FR
SELECT Name, ListPrice, ProductNumber
FROM SalesLT.Product
WHERE ProductNumber LIKE 'FR%';

--Note that the filter based on NULL values you must use IS NULL (or IS NOT NULL)
--You cannot compare a NULL value using the = operator.
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL;

--BETWEEN operator to define a filter based on values within a defined RANGE
--Products that the company stopped selling in 2006
SELECT Name, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate BETWEEN '2006/1/1' AND '2006/12/31';

--Products with a ProductCategoryID value that is a specified list using IN operator
SELECT ProductCategoryID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductCategoryID IN (5,6,7)

--AND operator to combine two criteria.
--Filters the results to include rows that match one (or both) of the criteria.
SELECT ProductCategoryID, Name, ListPrice, SellEndDate
FROM SalesLT.Product
WHERE ProductCategoryID IN (5,6,7) AND SellEndDate IS NULL;

--Filters the results to include rows that match one (or both) of two criteria.
SELECT Name, ProductCategoryID, ProductNumber
FROM SalesLT.Product
WHERE ProductNumber LIKE 'FR%' OR ProductCategoryID IN (5,6,7);
