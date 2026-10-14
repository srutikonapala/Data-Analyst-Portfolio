use customer_purchase_analysis;

select count(distinct customer_id) as total_unique_customers
 from customer_data;

select count(order_id) as total_orders
from orders_data;

select sum(quantity*price) as total_revenue
from orders_data;

select avg(quantity*price) as average_order_value
from orders_data;

select product,sum(quantity*price) as total_revenue
from orders_data
group by product
order by total_revenue desc
limit 1;

select category,sum(quantity*price) as total_revenue
from orders_data
group by category
order by total_revenue desc;

select product,sum(quantity) as total_quantity
from orders_data
group by product 
order by total_quantity desc
limit 1;

select customer_id,sum(quantity*price) as total_spending
from orders_data
group by customer_id
order by total_spending desc;

select customer_id,sum(quantity*price) as total_spending 
from orders_data
group by customer_id
order by total_spending desc
limit 3;

select c.customer_id , c.name 
from customer_data as c
left join orders_data as o
on c.customer_id = o.customer_id
where o.customer_id is null;

select month(str_to_date(orderDate, '%d-%m-%y')) as month,
sum(quantity*price) as total_revenue 
from orders_data
group by month(str_to_date(orderDate, '%d-%m-%y'))
order by month;

select customer_id, min(str_to_date(orderDate,
'%d-%m-%y')) as first_order_date
from orders_data
group by customer_id;

with customer_spending as (select customer_id, sum(quantity*price) as total_spending
from orders_data 
group by customer_id
)
select* from customer_spending
where total_spending > (select avg(quantity*price) as avg_spending 
from orders_data);

select customer_id, sum(quantity*price) as total_spending , 
rank() over (order by sum(quantity*price)desc) as spending_rank
from orders_data
group by customer_id ;

with customer_spending as (select c.customer_id, c.name, c.country, sum(o.quantity*o.price) as total_spending 
from customer_data as c
inner join orders_data as o
on c.customer_id = o.customer_id
group by c.customer_id , c.name, c.country
)
select customer_id, name,country, total_spending from customer_spending 
order by total_spending desc
limit 1;

