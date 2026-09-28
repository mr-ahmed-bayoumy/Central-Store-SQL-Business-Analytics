

-------------- TABLES OVERVIEW ----------------

select * from DimProduct
select * from DimCustomer
select * from DimOrders
select * from DimLocation
select * from FactOrderDetails
select * from Staging_Superstore


-------------- Primary KPIs -----------------

-- Total Products, Categories & Sub-Categories 
select count(distinct ProductID) as Total_Products,
count(Distinct Category) as Categories,
count(distinct SubCategory) as Sub_Categories
from DimProduct

-- Total Customers & Customer Segments
select count(CustomerId) as Total_Customers,
count(distinct Segment) as Segments
from DimCustomer

-- Customers by Segment
select Segment, count(CustomerId) as Customers
from DimCustomer
group by Segment
order by count(CustomerId)

-- Total Sales, Profit & Quantity Sold [View]
select round(sum(Sales),0) as total_sales,
round(sum(Profit),0) as total_profit,
sum(quantity) as total_quantity_sold
from FactOrderDetails

------ Product Analysis ------

-- Sales & Profit by Product
select ProductName, round(sum(od.sales),0) as sales,
round(sum(od.Profit),0) as profit
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.ProductName
order by profit desc

-- Top 5 Profitable Products
select top 5 ProductName, round(sum(od.Profit),0) as profit
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.ProductName
order by profit desc

-- Top 5 Best Seller Products
select top 5 ProductName, round(sum(od.sales),0) as sales
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.ProductName
order by sales desc

-- Top 5 Products by Quantity Sold
select top 5 ProductName, sum(od.Quantity) as quantity_sold
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.ProductName
order by quantity_sold desc

-- Total Lossing or Non-Profitable Products
select ProductName, round(sum(od.Profit),0) as profit
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.ProductName
having sum(od.Profit) <= 0
order by profit desc

-- Product Profitability Segmentation [CASE]+[CTE]
with C1 as
(
select ProductName, round(sum(od.sales),0) as sales,
round(sum(od.Profit),0) as profit
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.ProductName
)
select ProductName, Profit,
case
    when profit >= 10000 then 'Exceptional Profit'
    when profit >= 3000 then 'High Profit'
    when Profit >= 1000 then 'Medium Profit'
    when Profit > 0 then 'Low Profit'
    when Profit = 0 then 'No Profit'
    when Profit <= -3000 then 'Critical Loss'
    when Profit <= -500 then 'Big Loss'
    when Profit < 0 then 'Loss'
end as Profit_Category
from C1
order by profit desc

-- Sales & Profit by Category & Sub-Category
select Category, SubCategory, round(sum(od.sales),0) as sales,
round(sum(od.Profit),0) as profit
from DimProduct as P
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by p.Category, p.SubCategory
order by profit desc

-- Average Discount by Category & Sub-category
select p.Category, p.SubCategory,
round(avg(od.Discount)*100,0) as Avrg_Discount,
round(sum(od.profit),0) as profit
from DimProduct as p
left join FactOrderDetails as OD
on p.ProductID = od.ProductID
group by Category, SubCategory
order by avg(od.Discount) desc

------ Customer Analysis --------

-- Orders by Customer 
select C.customername, count(o.OrderID) as orders
from DimOrders as o
join DimCustomer as c
on c.customerID = o.customerID
join FactOrderDetails as od
on o.OrderID = od.OrderID
group by CustomerName
order by orders desc

-- Customer Classification [CASE]
select c.CustomerName, count(o.orderid) as Orders,
    CASE
        WHEN COUNT(o.orderid) >= 20 THEN 'VIP'
        WHEN COUNT(o.orderid) >= 10 THEN 'Loyal'
        WHEN COUNT(o.orderid) >= 2 THEN 'Active'
        WHEN COUNT(o.orderid) = 1 THEN 'New'
        ELSE                         'Potential'
    END AS Customer_Class
from dimcustomer c
left join  DimOrders as o
on c.customerid = o.customerid
group by c.customername

-- Sales & Profit by Customer
select C.customername,
round(sum(Sales),0) as sales,
round(sum(profit),0) as profit
from DimOrders as o
join DimCustomer as c
on c.customerID = o.customerID
join FactOrderDetails as od
on o.OrderID = od.OrderID
group by CustomerName

-- Top 5 Customers by Sales
select top 5 customername, round(sum(od.sales),0) as sales
from DimOrders as o
join DimCustomer as c
on c.customerID = o.customerID
join FactOrderDetails as od
on o.OrderID = od.OrderID
group by CustomerName
order by sales desc

-- Top 5 Customers by Profit
select top 5 customername, round(sum(od.Profit),0) as profit
from DimOrders as o
join DimCustomer as c
on c.customerID = o.customerID
join FactOrderDetails as od
on o.OrderID = od.OrderID
group by CustomerName
order by profit desc

-- Sales & Profit by Segment
select Segment,
round(sum(od.Profit),0) as profit,
round(sum(od.sales),0) as sales
from DimOrders as o
join DimCustomer as c
on c.customerID = o.customerID
join FactOrderDetails as od
on o.OrderID = od.OrderID
group by Segment
order by profit desc

-------- Geographic Analysis ----------

-- Customers by Region
select Region,
count(CustomerID) as Customers
from DimLocation as L
join DimOrders as O
on L.LocationID = O.LocationID
join FactOrderDetails as OD
on o.OrderID = od.OrderID
group by Region
order by count(CustomerID) desc

-- Sales & Profit by Region [Procedure]
create procedure Get_Region_Performance
@Region varchar(20)
as
begin
    select Region,
           ROUND(SUM(od.Profit),0) as profit,
           ROUND(SUM(od.sales),0) as sales
    FROM DimLocation as L
    join DimOrders as O
    on L.LocationID = O.LocationID
    join FactOrderDetails as OD
    on o.OrderID = od.OrderID
    where L.Region = @Region
    group by Region
end

--------- Time Analysis ---------

-- Avrage Shipping Days by ShipModde [View]
select ShipMode,
avg(DATEDIFF(day, OrderDate, ShipDate)) as Avg_Shipping_Days
from DimOrders as O
group by ShipMode

-- Shipping Days & Mode By Orders
select OrderID, ShipMode,
DATEDIFF(day, OrderDate, ShipDate) as Shipping_Days
from DimOrders
order by Shipping_Days 

-- Shipping Days Taken for each order [View]
select OrderID,
sum(DATEDIFF(day, OrderDate, ShipDate)) as Shipping_Days
from DimOrders as O
group by OrderID

-- Orders By Month
select
year(OrderDate) as Year,
month(OrderDate) as Month,
count(OrderID) as Orders
from DimOrders
group by year(OrderDate), month(OrderDate)
order by Year, Month

-- Orders By Quarter [CTE]
with C1 as
(   
    select
    year(OrderDate) as Year,
    datepart(quarter,OrderDate) as Quarter,
    count(OrderID) as Orders
    from DimOrders
    group by year(OrderDate), datepart(quarter,OrderDate)
)
select Year, 'Q'+ cast(Quarter as VARCHAR(1)) as Quarter_Name, Orders
from C1
group by Year, Quarter, Orders
order by Year, Quarter

-->> Views Call
select * from KPIs_View
select * from View_Shipping_Performance
select * from View_Orders_Shipping_Performance
select * from vw_Business_Recommendations

-->> Procedure Call
exec Get_Region_Performance @Region = 'East'





/* =====================================================================
   BUSINESS INSIGHTS & RECOMMENDATIONS
   Based on Central_Superstore Data & Analytical SQL Project
   =====================================================================

   The analysis of the Central_Superstore dataset provided valuable insights 
   into product performance, customer behavior, profitability, geographic 
   trends, shipping efficiency, and overall sales trends.
   
   ---------------------------------------------------------------------
   1. PRODUCT PERFORMANCE
   ---------------------------------------------------------------------
   [Insights]
   - A few products and sub-categories generate the majority of total sales and profit.
   - Some products have high sales but low or negative profit, mainly due to high discount rates.

   [Recommendations]
   - Focus on promoting high-margin products and consider discontinuing or repricing low-profit items.
   - Review discount strategy, especially for products with consistently low margins.

   ---------------------------------------------------------------------
   2. CUSTOMER BEHAVIOR
   ---------------------------------------------------------------------
   [Insights]
   - The majority of customers belong to the Consumer segment, followed by Corporate and Home Office.
   - A small number of customers contribute a large portion of total sales and profit.

   [Recommendations]
   - Build targeted marketing campaigns for high-value customers and the Consumer segment.
   - Improve customer retention strategies, such as loyalty programs and personalized offers.

   ---------------------------------------------------------------------
   3. GEOGRAPHIC ANALYSIS
   ---------------------------------------------------------------------
   [Insights]
   - Sales and profit are concentrated in a few regions and states, with significant variation across locations.
   - Some regions show strong sales but lower profitability.

   [Recommendations]
   - Invest more in high-performing regions and explore opportunities to grow in underperforming areas.
   - Analyze regional pricing and discount strategies to improve profitability in low-margin regions.

   ---------------------------------------------------------------------
   4. SHIPPING DURATION ANALYSIS
   ---------------------------------------------------------------------
   [Insights]
   - Standard shipping is the most used mode and has a good balance between cost and speed.
   - Express shipping has higher sales and profit per order, but longer delivery times.

   [Recommendations]
   - Continue promoting Standard shipping for cost efficiency.
   - Optimize logistics for Express shipping to reduce delivery time without increasing costs.
   - Monitor long shipping durations and address potential delays.

   ---------------------------------------------------------------------
   5. SALES TRENDS
   ---------------------------------------------------------------------
   [Insights]
   - Sales and profit show seasonal patterns, with higher performance in certain months and lower performance in others.
   - Overall trend indicates growth in sales over time, with some fluctuations in profit.

   [Recommendations]
   - Plan inventory and marketing campaigns around peak seasons.
   - Investigate the causes of profit dips (e.g., discounts, high-cost products, or regional factors) and take corrective actions.

   ---------------------------------------------------------------------
   6. KEY TAKEAWAYS
   ---------------------------------------------------------------------
   [Insights]
   - Profitability is not always aligned with sales volume.
   - Customer and product concentration risks exist.
   - Geography and shipping have a significant impact on performance.

   [Recommendations]
   - Use a balanced scorecard (Sales + Profit + Quantity) when evaluating performance.
   - Diversify the customer base and reduce dependency on a few high contributors.
   - Continuously monitor product, regional, and shipping performance to find new growth opportunities.

   =====================================================================
   Better Data -> Smarter Decisions -> Higher Profitability
   ===================================================================== */


-->> FINAL REPORT [View]+[Union]+[Go]
GO
CREATE VIEW vw_Business_Recommendations AS
SELECT 
    1 AS Section_ID,
    'Product Performance' AS Analysis_Area,
    'Few items drive most sales/profit; high discounts cause losses on some high-sales items.' AS Key_Insight,
    'Promote high-margin products, reprice or drop loss-makers, and cap excessive discounting.' AS Business_Recommendation
UNION ALL
SELECT 
    2,
    'Customer Behavior',
    'Consumer segment dominates; a small customer tier contributes disproportionate revenue.',
    'Launch targeted loyalty retention and customized campaigns for top-tier accounts.'
UNION ALL
SELECT 
    3,
    'Geographic Analysis',
    'Performance is clustered in key regions; certain regions have volume but weak margins.',
    'Scale investment in high-margin regions; review localized pricing and discount policies.'
UNION ALL
SELECT 
    4,
    'Shipping Duration',
    'Standard Class is the most cost-effective; Express shows longer delays relative to its cost.',
    'Keep Standard as primary default; streamline fulfillment pipelines to fix Express delays.'
UNION ALL
SELECT 
    5,
    'Sales Trends',
    'Clear seasonality and overall upward trajectory, accompanied by intermittent profit dips.',
    'Align inventory/marketing to peak seasons; audit margin drop-offs immediately.'
UNION ALL
SELECT 
    6,
    'Key Takeaways',
    'Volume does not equal profit; heavy concentration risks exist across clients and products.',
    'Adopt balanced KPIs (Sales + Profit) and diversify revenue drivers.';
GO