USE AdventureWorks2019
GO

SELECT *
FROM Person.StateProvince

SELECT *
FROM Person.CountryRegion

--Question 1
SELECT cr.Name Country, sp.Name Province 
FROM person.StateProvince sp JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode

--Question 2
SELECT cr.Name Country, sp.Name Province 
FROM person.StateProvince sp JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
Where cr.Name IN ('Germany','Canada')

--Question 3
USE Northwind
GO

SELECT DISTINCT p.ProductName
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -25, CURRENT_TIMESTAMP)

--Question 4
SELECT TOP 5 o.ShipPostalCode, COUNT(od.OrderID) NumOfOrders
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -25, CURRENT_TIMESTAMP)
GROUP BY o.ShipPostalCode
ORDER BY NumOfOrders DESC

--Question 5
SELECT City, COUNT(city) NumOfCustomers
FROM Customers c
GROUP BY City
ORDER BY City

--Question 6
SELECT City, COUNT(city) NumOfCustomers
FROM Customers c
GROUP BY City
HAVING COUNT(city) > 2

--Question 7
SELECT c.ContactName, COUNT(od.Quantity) AmountOrdered
FROM Customers c JOIN orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName
ORDER BY AmountOrdered DESC

--Question 8
SELECT c.CustomerID, COUNT(od.Quantity) AmountOrdered
FROM Customers c JOIN orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.Quantity) > 100
ORDER BY AmountOrdered DESC

--Question 9
SELECT s.CompanyName AS[Supplier Company Name], sh.CompanyName AS [Shipping Company Name]
FROM Suppliers s CROSS JOIN Shippers sh

--Question 10
SELECT o.OrderDate, p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY o.OrderDate

SELECT OrderDate
FROM Orders

--Question 11
SELECT *
FROM Employees

--Question 12
SELECT FirstName + LastName [Full Name], EmployeesReportingTo
FROM Employees e JOIN
(SELECT ReportsTo, count(ReportsTo) EmployeesReportingTo
FROM Employees
GROUP BY ReportsTo) dt ON dt.ReportsTo = e.EmployeeID
WHERE dt.EmployeesReportingTo > 2

--Question 13
SELECT City, ContactName, 'Customer' [Type]
FROM Customers
UNION ALL
SELECT City, ContactName, 'Supplier'
FROM Suppliers

--Question 14
SELECT DISTINCT city
FROM Employees
WHERE city IN 
(
SELECT city
FROM Customers
)

--Question 15
	--a
SELECT DISTINCT city
FROM Customers
WHERE city NOT IN 
(
SELECT city
FROM Employees
)
	--b
SELECT DISTINCT c.city
FROM Customers c LEFT JOIN Employees e ON c.City = e.city
WHERE e.City IS NULL

--Question 16
SELECT p.ProductName, SUM(od.Quantity)
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName

--Question 17
	--a
SELECT DISTINCT City
FROM Customers
WHERE city NOT IN
(
SELECT City
FROM Customers 
GROUP BY City
Having COUNT(City) = 0
UNION
SELECT City
FROM Customers 
GROUP BY City
Having COUNT(City) = 1)
	--b
SELECT City, COUNT(city)
FROM Customers 
GROUP BY City
HAVING COUNT(city) >= 2

--Question 18

SELECT dt.City, COUNT(dt.CategoryID) NumOfTypesOfProducts
FROM
(SELECT distinct c.city, p.CategoryID
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID JOIN Products p ON od.ProductID = p.ProductID) dt
GROUP BY dt.City
HAVING COUNT(dt.CategoryID) > 2
ORDER BY NumOfTypesOfProducts

--Question 19

--Question 20

--Question 21
DISTINCT