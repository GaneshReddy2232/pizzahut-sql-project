create database pizzahut;
use pizzahut;


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

select count(order_id) as [Total_orders] from orders;


--Query2
--Calculate the total revenue generated from pizza sales.

select * from pizzas;
select * from order_details;

select
round(sum(order_details.quantity * pizzas.price),2) as
[total_revenue]
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;


--Query3
--Identify the highest-priced pizza.

select * from pizzas;
select * from pizza_types;


select top 1
pizza_types.name,round(pizzas.price,2) as [highest-priced]
from pizza_types join pizzas on 
pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc;


--Query4
--Identify the most common pizza size ordered.

select * from order_details;
select * from pizzas;
select * from orders;


select    -- if we want to show only the one most common pizza sold then then mention the top 1 after the select command
pizzas.size,count(order_details.order_details_id) as [order_count]
from pizzas join order_details on 
pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc;


--Query5
--List the top 5 most ordered pizza types along with their quantities.

select top 5
pizza_types.name,sum(order_details.quantity) as [quantity]
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc;












