-- 1. List all suppliers in the UK
SELECT *
FROM Supplier
WHERE Country = 'UK';

-- 2. List the first name, last name, and city for all customers.
-- Concatenate the first and last name separated by a space and a comma as a single column
SELECT
    FirstName + ' ' + LastName + ', ' + City AS CustomerInfo
FROM
    Customer;

-- 3. List all customers in Sweden
SELECT *
FROM Customer
WHERE Country = 'Sweden';

-- 4. List all suppliers in alphabetical order
SELECT *
FROM Supplier
ORDER BY CompanyName ASC;

-- 5. List all suppliers with their products
SELECT
    s.CompanyName,
    p.ProductName,
    p.UnitPrice,
    p.Package
FROM
    Supplier AS s
JOIN
    Product AS p ON s.Id = p.SupplierId
ORDER BY
    s.CompanyName, p.ProductName;

-- 6. List all orders with customers information
SELECT
    o.Id AS OrderId,
    o.OrderDate,
    o.TotalAmount,
    o.OrderNumber,
    c.FirstName,
    c.LastName,
    c.City,
    c.Country,
    c.Phone
FROM
    [Order] AS o -- Using square brackets for the "Order" table name as it's a reserved keyword in SQL Server
JOIN
    Customer AS c ON o.CustomerId = c.Id
ORDER BY
    o.OrderDate;

-- 7. List all orders with product name, quantity, and price, sorted by order number
SELECT
    o.OrderNumber,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice
FROM
    [Order] AS o -- Using square brackets for the "Order" table name
JOIN
    OrderItem AS oi ON o.Id = oi.OrderId
JOIN
    Product AS p ON oi.ProductId = p.Id
ORDER BY
    o.OrderNumber, p.ProductName;

-- 8. Using a case statement, list all the availability of products.
-- When 0 then not available, else available
SELECT
    ProductName,
    CASE
        WHEN IsDiscontinued = 0 THEN 'Available'
        ELSE 'Not Available'
    END AS Availability
FROM
    Product;

-- 9. Using case statement, list all the suppliers and the language they speak.
-- The language they speak should be their country E.g if UK, then English
SELECT
    CompanyName,
    Country,
    CASE Country
        WHEN 'UK' THEN 'English'
        WHEN 'USA' THEN 'English'
        WHEN 'Japan' THEN 'Japanese'
        WHEN 'Spain' THEN 'Spanish'
        WHEN 'Australia' THEN 'English'
        WHEN 'Sweden' THEN 'Swedish'
        WHEN 'Brazil' THEN 'Portuguese'
        WHEN 'Germany' THEN 'German'
        WHEN 'Norway' THEN 'Norwegian'
        WHEN 'Italy' THEN 'Italian'
        WHEN 'France' THEN 'French'
        WHEN 'Singapore' THEN 'Malay, English, Mandarin, Tamil'
        WHEN 'Denmark' THEN 'Danish'
        WHEN 'Netherlands' THEN 'Dutch'
        WHEN 'Finland' THEN 'Finnish'
        WHEN 'Canada' THEN 'English, French'
        WHEN 'Argentina' THEN 'Spanish'
        WHEN 'Switzerland' THEN 'German, French, Italian'
        WHEN 'Ireland' THEN 'English, Irish'
        WHEN 'Austria' THEN 'German'
        WHEN 'Venezuela' THEN 'Spanish'
        WHEN 'Portugal' THEN 'Portuguese'
        WHEN 'Belgium' THEN 'Dutch, French, German'
        WHEN 'Poland' THEN 'Polish'
        WHEN 'Mexico' THEN 'Spanish'
        ELSE 'Unknown'
    END AS LanguageSpoken
FROM
    Supplier
ORDER BY CompanyName;

-- 10. List all products that are packaged in Jars
SELECT
    ProductName,
    Package
FROM
    Product
WHERE
    Package LIKE '%jars%';

-- 11. List products name, unitprice and packages for products that starts with Ca
SELECT
    ProductName,
    UnitPrice,
    Package
FROM
    Product
WHERE
    ProductName LIKE 'Ca%';

-- 12. List the number of products for each supplier, sorted high to low.
SELECT
    s.CompanyName,
    COUNT(p.Id) AS NumberOfProducts
FROM
    Supplier AS s
LEFT JOIN
    Product AS p ON s.Id = p.SupplierId
GROUP BY
    s.CompanyName
ORDER BY
    NumberOfProducts DESC;

-- 13. List the number of customers in each country.
SELECT
    Country,
    COUNT(Id) AS NumberOfCustomers
FROM
    Customer
GROUP BY
    Country;

-- 14. List the number of customers in each country, sorted high to low.
SELECT
    Country,
    COUNT(Id) AS NumberOfCustomers
FROM
    Customer
GROUP BY
    Country
ORDER BY
    NumberOfCustomers DESC;

-- 15. List the total order amount for each customer, sorted high to low.
SELECT
    c.FirstName,
    c.LastName,
    SUM(o.TotalAmount) AS TotalOrderAmount
FROM
    Customer AS c
JOIN
    [Order] AS o ON c.Id = o.CustomerId -- Using square brackets for the "Order" table name
GROUP BY
    c.FirstName, c.LastName
ORDER BY
    TotalOrderAmount DESC;

-- 16. List all countries with more than 2 suppliers.
SELECT
    Country,
    COUNT(Id) AS NumberOfSuppliers
FROM
    Supplier
GROUP BY
    Country
HAVING
    COUNT(Id) > 2;

-- 17. List the number of customers in each country. Only include countries with more than 10 customers.
SELECT
    Country,
    COUNT(Id) AS NumberOfCustomers
FROM
    Customer
GROUP BY
    Country
HAVING
    COUNT(Id) > 10;

-- 18. List the number of customers in each country, except the USA, sorted high to low.
-- Only include countries with 9 or more customers.
SELECT
    Country,
    COUNT(Id) AS NumberOfCustomers
FROM
    Customer
WHERE
    Country <> 'USA'
GROUP BY
    Country
HAVING
    COUNT(Id) >= 9
ORDER BY
    NumberOfCustomers DESC;

-- 19. List customer with average orders between $1000 and $1200.
SELECT
    c.FirstName,
    c.LastName,
    AVG(o.TotalAmount) AS AverageOrderAmount
FROM
    Customer AS c
JOIN
    [Order] AS o ON c.Id = o.CustomerId -- Using square brackets for the "Order" table name
GROUP BY
    c.FirstName, c.LastName
HAVING
    AVG(o.TotalAmount) BETWEEN 1000 AND 1200
ORDER BY
    AverageOrderAmount;

-- 20. Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013.
SELECT
    COUNT(Id) AS NumberOfOrders,
    SUM(TotalAmount) AS TotalAmountSold
FROM
    [Order] -- Using square brackets for the "Order" table name
WHERE
    OrderDate >= '2013-01-01' AND OrderDate <= '2013-01-31';
