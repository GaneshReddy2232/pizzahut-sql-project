create database pizzahut;
use pizzahut;
--import the pizzas and pizza_types directly due to no changes need to be done 

create table orders
(
	order_id int not null primary key,
	order_date date not null,
	order_time time not null
)


create table order_details
(	
	order_details_id int not null primary key,
	order_id int not null,
	pizza_id text,
	quantity int not null
)



select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;




--Query1
--Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS [Total_orders]
FROM 
    orders;


--Query2
--Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS [total_revenue]
FROM 
    order_details
JOIN 
    pizzas ON pizzas.pizza_id = order_details.pizza_id;


--Query3
--Identify the highest-priced pizza.

SELECT TOP 1 
    pizza_types.name, 
    ROUND(pizzas.price, 2) AS [highest-priced]
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY 
    pizzas.price DESC;


--Query4
--Identify the most common pizza size ordered.
-- if we want to show only the one most common pizza sold then then mention the top 1 after the select command

SELECT 
    pizzas.size, 
    COUNT(order_details.order_details_id) AS [order_count]
FROM 
    pizzas
JOIN 
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY 
    pizzas.size
ORDER BY 
    [order_count] DESC;


--Query5
--List the top 5 most ordered pizza types along with their quantities.

SELECT TOP 5 
    pizza_types.name, 
    SUM(order_details.quantity) AS [quantity]
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN 
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.name
ORDER BY 
    [quantity] DESC;


--Query6
--Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS [quantity]
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN 
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.category
ORDER BY 
    [quantity] DESC;



--Query7
--Determine the distribution of orders by hour of the day.

SELECT 
    DATEPART(HOUR, order_time) AS [order_hour],
    COUNT(order_id) AS [order_count]
FROM orders
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_hour;


--Query8
--Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category,
    COUNT(name) AS pizza_count
FROM 
    pizza_types
GROUP BY 
    category;


--Query9
--Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    AVG(order_quantity.total_quantity) AS avg_pizza_ordered_per_day
FROM 
    (
        SELECT 
            orders.order_date, 
            SUM(order_details.quantity) AS total_quantity
        FROM 
            orders
        JOIN 
            order_details ON orders.order_id = order_details.order_id
        GROUP BY 
            orders.order_date
    ) AS order_quantity;


--Query10
--Determine the top 3 most ordered pizza types based on revenue.

SELECT TOP 3 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM 
    pizza_types
JOIN 
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN 
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.name
ORDER BY 
    revenue DESC;
