
CREATE DATABASE SQL_PRJ_1;
DROP TABLE IF EXISTS RETAIL_SALES;
CREATE table RETAIL_SALES
(
transactions_id INT PRIMARY KEY,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT, 
category VARCHAR(15),	
quantiy	INT,
price_per_unit	FLOAT,
cogs FLOAT,
total_sale FLOAT
);

-- data cleaning 
select * FROM RETAIL_SALES
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id	is null
or
gender	is null
or
age	is null
or
category is null
or	
quantiy	is null
or
price_per_unit	is null
or
cogs is null
or
total_sale is null;

SELECT * FROM RETAIL_SALES
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id	is null
or
gender	is null
or
age	is null
or
category is null
or	
quantiy	is null
or
price_per_unit	is null
or
cogs is null
or
total_sale is null;

select count(*) as total_sale from retail_sales;
select count(distinct customer_id) as total_customers from retail_sales;
select distinct category from retail_sales;

-- data analysis
-- q1. retirve all clmns for sales made on 2022-11-05
select * from retail_sales
where sale_date= '2022-11-05';

-- q2. retrieve trancns where category is clothing and quantity sold is >10 in month of nov-2022
select transactions_id from retail_sales
where (category='clothing' and quantiy<10);

-- it gives transactons_id

select * from retail_sales
where 
category='clothing' 
and 
quantiy >3
and 
sale_date between '2022-11-01' and '2022-11-30';

--- q3. query to cal total sales for each category include total order clmn also

select category, sum(total_sale) as net_sales,
count(*) as total_orders
 from retail_sales
group by 1;

-- q4. query to find avg age of customers purchased items from beauty category
select category, round(avg(age), 2) as avg_age from retail_sales
where 
category='beauty';

-- query to find all transcns where total sales>1000
select * from retail_sales
where total_sale>1000;

-- q6. qry to find total num of transacns made by each gender in each category
select count(*) as tot_trn, category, gender  from retail_sales
group by category, gender
ORDER BY category;

-- q7. QRY TO FIND THE avg sale for each month, find best selling month in each year
select 
year, month, avg_sale
from
(
select 
year(sale_date) as year,
month(sale_date) as month,
avg(total_sale) as avg_sale,
RANK() OVER(PARTITION BY year(sale_date) order by avg(total_sale) DESC) as rank_
 from retail_sales
 GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1 
where rank_=1;

-- q8. sql qry to find top 5 customers based on highest total sales
select 
customer_id,
sum(total_sale) as tot_sale
from retail_sales
group by customer_id
order by tot_sale desc
LIMIT 5;


-- Q9. SQL QRY to find number of unique cstmers who prchased items FRM each category
select 
category,
count(distinct customer_id) as unq_cust
from retail_sales
group by category; 

-- q10. sql qry to create each shift and num of orders (eg; morning <=12 afternoon between 12 and 17, evening >17)
WITH HRLY_TABLE 
AS
(
select *,
CASE 
WHEN hour(SALE_TIME)<=12 THEN 'MORNING'
WHEN hour(SALE_TIME) BETWEEN 12 AND 17 THEN 'NOON'
ELSE 'EVENING'
END AS SHIFT 
from retail_sales
)
SELECT 
SHIFT, COUNT(*) AS TOTAL_ORDERS
FROM HRLY_TABLE
GROUP BY SHIFT;
