-- Data Exploration

-- How many sales

select count(*) as total_sales from retail_sales

-- How many unique customers we have?

select 
count(distinct customer_id)as total_customers
from retail_sales

-- how many categories we have?

select
distinct category as total_category
from retail_sales

--
