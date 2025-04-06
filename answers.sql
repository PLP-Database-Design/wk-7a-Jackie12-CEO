QUESTION 1
-- Simulate the original data using a CTE
WITH ProductDetail AS (
    SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop, Mouse' AS Products UNION ALL
    SELECT 102, 'Jane Smith', 'Tablet, Keyboard, Mouse' UNION ALL
    SELECT 103, 'Emily Clark', 'Phone'
),
SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
    FROM 
        ProductDetail
    JOIN (
        SELECT a.N + b.N * 10 + 1 AS n
        FROM 
            (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) a,
            (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) b
    ) n ON n.n <= 1 + LENGTH(Products) - LENGTH(REPLACE(Products, ',', ''))
)
SELECT 
    OrderID,
    CustomerName,
    Product
FROM 
    SplitProducts
ORDER BY OrderID;


QUESTION 2
-- CustomerOrders table (remove partial dependency)
SELECT DISTINCT
    OrderID,
    CustomerName
FROM
    OrderDetails;

-- OrderItems table (only fully dependent on composite key)
SELECT
    OrderID,
    Product,
    Quantity
FROM
    OrderDetails;
