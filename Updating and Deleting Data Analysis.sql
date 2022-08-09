-- Modify Data in T-SQL
-- Inserting Data into a table

-- creates a table with some fields that we’ll use in subsequent tasks to insert, update, and delete data.
CREATE TABLE SalesLT.CallLog
 (
     CallID int IDENTITY PRIMARY KEY NOT NULL,
     CallTime datetime NOT NULL DEFAULT GETDATE(),
     SalesPerson nvarchar(256) NOT NULL,
     CustomerID int NOT NULL REFERENCES SalesLT.Customer(CustomerID),
     PhoneNumber nvarchar(25) NOT NULL,
     Notes nvarchar(max) NULL
 );

 SELECT * FROM SalesLT.CallLog;

 INSERT INTO SalesLT.CallLog
 VALUES
 ('2015-01-01T12:30:00', 'adventure-works\pamela0', 1, '245-555-0173',
  'Returning call re: enquiry about delivery');

-- The CallID column is an identity column that is automatically incremented 
 SELECT * FROM SalesLT.CallLog;

 -- the INSERT statement takes advantage of the fact that the table has a default value 
 -- defined for the CallTime field, and allows NULL values in the Notes field.
 -- the CallTime field (the current time when the row was inserted) and NULL for the Notes field.
INSERT INTO SalesLT.CallLog
VALUES
(DEFAULT, 'adventure-works\david8', 2, '170-555-0127', NULL);

SELECT * FROM SalesLT.CallLog;

-- the INSERT statement explicitly lists the columns into which the new values will be inserted.
-- The columns not specified in the statement support either default or NULL values, so they can be omitted
INSERT INTO SalesLT.CallLog (SalesPerson, CustomerID, PhoneNumber)
VALUES
('adventure-works\jillian0', 3, '279-555-0130');

SELECT * FROM SalesLT.CallLog;

-- Insert additional 2 records
INSERT INTO SalesLT.CallLog
VALUES
(GETDATE(), 'adventure-works\jillian0', 4, '710-555-0173', NULL),
(DEFAULT, 'adventure-works\shu0', 5, '828-555-0186', 
'Called to arrange deliver of order 10987');

SELECT 'Ibadan Digital Academy'

-- inserts the results of a SELECT query into the SalesLT.CallLog table.
SELECT SalesPerson, CustomerID, Phone, 'Sales promotion call'
FROM SalesLT.Customer
WHERE CompanyName = 'Big-Time Bike Store';

-- Insert two rows that were retrieved by the SELECT query.
INSERT INTO SalesLT.CallLog (SalesPerson, CustomerID, PhoneNumber, Notes)
SELECT SalesPerson, CustomerID, Phone, 'Sales promotion call'
FROM SalesLT.Customer
WHERE CompanyName = 'Big-Time Bike Store';

SELECT * FROM SalesLT.CallLog;

-- Update Data
UPDATE SalesLT.CallLog
 SET Notes = 'No notes'
 WHERE Notes IS NULL;

-- Note that the rows that previously had NULL values for the Notes field now contain the text No notes.
SELECT * FROM SalesLT.CallLog;

-- all rows have been updated to remove the SalesPerson and PhoneNumber fields
 -- this emphasizes the danger of accidentally omitting a WHERE clause in an UPDATE statement.
 UPDATE SalesLT.CallLog
 SET SalesPerson = '', PhoneNumber = ''

 -- updates the SalesLT.CallLog table based on the results of a SELECT query.
 SELECT c.SalesPerson, PhoneNumber = c.Phone
 FROM SalesLT.Customer AS c

UPDATE SalesLT.CallLog
 SET SalesPerson = c.SalesPerson, PhoneNumber = c.Phone
 FROM SalesLT.Customer AS c
 WHERE c.CustomerID = SalesLT.CallLog.CustomerID;

-- Note that the table has been updated using the values returned by the SELECT statement.
SELECT * FROM SalesLT.CallLog;

-- Delete Data
DELETE FROM SalesLT.CallLog
 WHERE CustomerID = 1;

SELECT * FROM SalesLT.CallLog

-- statement to remove all rows in the table.
TRUNCATE TABLE SalesLT.CallLog;
