-- =====================================================
-- Retail Sales Analysis
-- Dataset: retail_sales_dataset
-- Goal: Understand customer purchasing behavior by gender,
--       age group, and product category (spend + frequency)
-- =====================================================

-- 1. Data overview — inspect raw structure before analysis
select * from retail_sales_dataset;

-- 2. Gender distribution — customer base split by gender
select gender,
       count(*) as gender_count
from retail_sales_dataset
group by gender;

-- 3. Total spend by gender — which gender contributes more revenue overall
select gender,
       count(*) as gender_count,
       sum("total amount") as total_spending
from retail_sales_dataset
group by gender
order by total_spending desc;

-- 4. Spend and purchase frequency by gender + product category
--    total_buy      = number of transactions per gender/category
--    total_spending = actual revenue per gender/category
select gender,
       "product category",
       count(*) as total_buy,
       sum("total amount") as total_spending
from retail_sales_dataset
group by gender, "product category"
order by "product category";

-- 5. Spend by age group + gender + product category
--    buckets raw age into ranges, then breaks revenue down
--    by gender and category within each age group
select
  case
    when age between 18 and 25 then '18-25'
    when age between 26 and 35 then '26-35'
    when age between 36 and 45 then '36-45'
    when age between 46 and 55 then '46-55'
    else '56+'
  end as age_group,
  gender,
  "product category",
  sum("total amount") as total_spending
from retail_sales_dataset
group by age_group, gender, "product category"
order by age_group, gender, "product category";

-- 6. Units sold vs revenue by product category
--    reveals whether a category's revenue comes from high volume
--    (many units, lower price) or high value (fewer units, higher price)
select
  "product category",
  sum(quantity) as total_units_sold,
  sum("total amount") as total_spending,
  round(sum("total amount") * 1.0 / sum(quantity), 2) as avg_price_per_unit
from retail_sales_dataset
group by "product category"
order by total_spending desc;
