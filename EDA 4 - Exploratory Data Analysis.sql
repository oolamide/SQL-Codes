--CHALLENGE 1
--List of all of you customers’ locations, reomiving duplicates
SELECT DISTINCT [City], [StateProvince] 
FROM [SalesLT].[Address]
ORDER BY [City] ASC;

--Retrieve the names of the top ten percent of products by weight.
SELECT TOP 10 PERCENT [Name], [Weight] 
FROM [SalesLT].[Product]
ORDER BY [Weight] DESC;

--CHALLENGE 2
--Find the names, colors, and sizes of the products with a product model ID 1.
SELECT Name, Color, Size, [ProductModelID]
FROM SalesLT.Product
WHERE ProductModelID = 1;

--Retrieve the product number and name of the products that have a color of black, red, or white
--and a size of S or M.
SELECT ProductNumber, Name, Color, Size
FROM[SalesLT].[Product]
WHERE Color IN ('Black', 'Red', 'White') AND Size IN ('S', 'M');

--Retrieve the product number, name, and list price of products
--whose product number begins BK-
SELECT [ProductNumber], [Name], [ListPrice]
FROM [SalesLT].[Product]
WHERE [ProductNumber] LIKE 'BK%';

--Modify your previous query to retrieve the product number, name, and list price of products
--whose product number begins BK-
--followed by any character other than R, and ends with a -
--followed by any two numerals.
SELECT [ProductNumber], [Name], [ListPrice]
FROM [SalesLT].[Product]
WHERE [ProductNumber] LIKE 'BK-[^R]%-[0-9][0-9]';
