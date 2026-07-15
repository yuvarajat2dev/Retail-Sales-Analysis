-- =====================================================
-- Retail Sales Analysis
-- Dataset: retail_sales_dataset
-- Goal: Understand customer purchasing behavior by gender
--       and product category (spend + frequency)
-- =====================================================

-- 1. Quick look at the raw data
select * from retail_sales_dataset;

-- 2. Gender distribution — how many male vs female customers
select gender,
       count(*) as gender_count
from retail_sales_dataset
group by gender;

-- 3. Total spend by gender — who spends more overall
select gender,
       count(*) as gender_count,
       sum("total amount") as total_spent
from retail_sales_dataset
group by gender
order by total_spent desc;

-- 4. Spend and purchase frequency by gender + product category
--    total_buy   = number of transactions per gender/category
--    total_spent = actual money spent (price per unit x quantity, pre-aggregated)
select gender,
       "product category",
       count(*) as total_buy,
       sum("total amount") as total_spent
from retail_sales_dataset
group by gender, "product category"
order by "product category";
