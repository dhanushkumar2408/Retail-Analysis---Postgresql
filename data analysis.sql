--Data Analysis

--retrive all columns for sales made on 2022-11-05

select*from retail_sales
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
     --the quantity sold is more than 4 in the month of Nov-2022:

select*from retail_sales
where 
category = 'Clothing'
and TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
AND quantity >= 3


-- calculate the total sales (total_sale)
   --for each category

  select 
  category,
  sum(total_sale)as TOTAL_SALES,
  COUNT(*)AS total_orders
  from retail_sales
  group by 1


 --Write a SQL query to find the average age of customers who purchased 
    --items from the 'Beauty' category.

select
round(avg(age),0) as avg_age
from
retail_sales
where category='Beauty'

---Write a SQL query to find all transactions where
    --the total_sale is greater than 1000

select*from retail_sales
where total_sale > 1000;

--total number of transactions (transaction_id) made by 
   --each gender in each category.

  select 
  category,
  count(*)as total_transactions,
  gender
  from retail_sales
  GROUP BY
  category, gender
  order by category

  --calculate the average sale for each month. Find out 
    --best selling month in each year
   select
   year,
   month,
   avg_sale from
  (select
  EXTRACT(YEAR from sale_date)as year,
  EXTRACT(MONTH from sale_date)as month,
  avg(total_sale)as avg_sale,
  RANK()OVER(PARTITION BY  EXTRACT(YEAR from sale_date) order by AVG(total_sale)desc) as rank
  from retail_sales
  GROUP BY 1,2) AS t1
  where rank=1


  ---find the top 5 customers 
     --based on the highest total sales :

select
customer_id,
sum(total_sale)as total_sales
from retail_sales
group by customer_id
order by sum(total_sale)
limit 5;

--find the number of unique customers 
   --who purchased items from each category.

 select
 category,
 count(distinct customer_id)as unique_customers
 from retail_sales
 group by category;

---Write a SQL query to create each shift and number of orders (Example Morning <12, 
  --Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale AS(
select *,
case
when EXTRACT(HOUR FROM sale_time)< 12 then 'Morning'
when EXTRACT(HOUR FROM sale_time )between 12 and 17 then 'Afternoon'
ELSE 'evening'
END AS shift
from retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

 
 select*from retail_sales;
 
-- total sales by female in clothing and sales category

 select 
 gender,
 category,
 sum(total_sale)as total_sales
 from retail_sales
 where gender = 'Female' and Category IN ('Beauty','Clothing')
 group by 1,2




-- classify the customers and their age based on total sales if they made more than 500 consider them as Gold, 
   ---between 500 and 1500 siver and below them bronze
   
 select 
 customer_id,
 age,
 total_sale,
 case
 when total_sale >= 1500 THEN 'GOLD MEMBER'
 WHEN total_sale between 500 and 1500 then 'SILVER MEMBER'
 ELSE 'BRONE MEMBER'
 END as customer_label
 from retail_sales;

 




