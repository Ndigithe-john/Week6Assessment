--Write a query to retrieve the list of orders along with the customer name and staff name for each order.

SELECT
    o.order_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name
FROM
    sales.orders o
    JOIN sales.customers c ON o.customer_id = c.customer_id
    JOIN sales.staffs s ON o.staff_id = s.staff_id;

--Create a view that returns the total quantity and sales amount for each product
--CREATE VIEW sales.product_info
--AS
--SELECT
--    product_name, 
--    brand_name, 
--    list_price
--FROM
--    production.products p
--INNER JOIN production.brands b 
--        ON b.brand_id = p.brand_id;

CREATE VIEW  product_sales AS 
Select p.product_id, 
p.product_name,
SUM(o.quantity) As totalQuantity, 
SUM(o.quantity *o.list_price *(1-o.discount)) AS salesAmount FROM 
production.products p JOIN sales.order_items o on p.product_id =o.product_id
Group by 
p.product_name,
p.product_id

SELECT * FROM product_sales;




--Write a stored procedure that accepts a customer ID and returns the total number of orders placed by that customer.
--ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL)
--AS
--BEGIN
--    SELECT
--        product_name,
--        list_price
--    FROM 
--        production.products
--    WHERE
--        list_price >= @min_list_price
--    ORDER BY
--        list_price;
--END;


CREATE PROCEDURE totalNumberOrders(@customer_id INT)
AS 
BEGIN
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM
    sales.customers c
    JOIN sales.orders o ON c.customer_id = o.customer_id
WHERE
    c.customer_id = @customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;
	END;

	--EXEC totalNumberOrders 2;
	EXEC totalNumberOrders 100;






--Write a query to find the top 5 customers who have placed the most orders.

SELECT TOP 5
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    COUNT(o.order_id) AS order_count
FROM
    sales.customers c
    JOIN sales.orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name


--Create a view that shows the product details along with the total sales quantity and revenue for each product.

--CREATE VIEW sales.product_info
--AS
--SELECT
--    product_name, 
--    brand_name, 
--    list_price
--FROM
--    production.products p
--INNER JOIN production.brands b 
--        ON b.brand_id = p.brand_id;

--select * from production.products
--select * from sales.order_items

CREATE VIEW productDetails
AS 
SELECT
p.product_id
 p.product_name,
 p.category_id,
 p.model_year
 FROM production.products p
 JOINS 

