--Retrieve all customer data.
SELECT * 
FROM [SalesLT].[Customer];

--Retrieve all customer names that includes the title, first name, middle name (if any), last name, and suffix (if any) of all customers.
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM [SalesLT].[Customer];

--Retrieve all customer names and phone numbers
SELECT [FirstName], [MiddleName], [LastName], [Phone]
FROM [SalesLT].[Customer];

--Creating a call sheet that lists: The salesperson, and a column named CustomerName that displays Title and FirstName together, and their phone numbers.
SELECT [SalesPerson], [Title] + ' ' + [FirstName] AS CustomerName, [Phone]
FROM [SalesLT].[Customer];

--List of all customer companies in the format Customer ID : Company Name.
SELECT
    CAST([CustomerID] AS varchar) + '; ' + [CompanyName]
FROM [SalesLT].[Customer];

--Retrieve a list of sales order revisions in the SalesOrderHeader Tavle
SELECT * 
FROM [SalesLT].[SalesOrderHeader];

--The sales order number and revision number in the format () –for example SO71774 (2).
SELECT [SalesOrderNumber], [RevisionNumber], [SalesOrderNumber] + '(2)' AS SalesOrderRevisions
FROM [SalesLT].[SalesOrderHeader];
OR
SELECT [SalesOrderNumber] + '(' + CONVERT(varchar (5), [RevisionNumber]) + ')' AS OrderRevision
FROM [SalesLT].[SalesOrderHeader];

--Convert the order date to ANSI standard 102 format (yyyy.mm.dd).
SELECT OrderDate,
    CONVERT(nvarchar(30), OrderDate) AS ConvertedDate,
    CONVERT(nvarchar(30), OrderDate, 102) AS ANSIStandardDate
FROM [SalesLT].[SalesOrderHeader]

SELECT [FirstName] + ' ' + ISNULL(MiddleName, '') + ' ' + [LastName] AS CustomerNames
FROM[SalesLT].[Customer];
