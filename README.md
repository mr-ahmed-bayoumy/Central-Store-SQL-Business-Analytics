# Central Superstore — SQL Business Analytics

## Project Overview

An advanced SQL Server data warehouse and business analytics project built using the Central Superstore dataset.

The project transforms a denormalized retail dataset into a relational analytical database using a Star Schema, then applies SQL queries and analytical techniques to evaluate sales, profitability, customer behavior, product performance, geographic performance, shipping efficiency, and sales trends.

## Objectives

* Normalize the operational dataset into fact and dimension tables.
* Build a Star Schema for analytical reporting.
* Establish primary and foreign key relationships.
* Calculate key business KPIs.
* Analyze product and customer performance.
* Evaluate geographic and shipping performance.
* Identify sales trends over time.
* Apply advanced SQL techniques for business analysis.

## Data Warehouse Design

The project uses a Star Schema consisting of:

* **FactOrderDetails** — transactional sales, quantity, discount, and profit measures.
* **DimProduct** — product, category, and sub-category information.
* **DimCustomer** — customer and segment information.
* **DimOrders** — order dates, shipping dates, shipping mode, and customer references.
* **DimLocation** — geographic information.
* **Staging_Superstore** — staging table used during the data preparation process.

## SQL Techniques Used

* SELECT & Aggregations
* GROUP BY / HAVING
* INNER JOIN / LEFT JOIN
* CTEs
* CASE Statements
* Subquery-based analysis
* Window/analytical concepts
* Views
* Stored Procedures
* Date Functions
* DATEDIFF
* DATEPART
* Data segmentation
* KPI calculations

## Business Analysis

### Product Analysis

* Sales and profit by product
* Top profitable products
* Best-selling products
* Top products by quantity sold
* Non-profitable products
* Product profitability segmentation
* Sales and profit by category and sub-category
* Average discount and profitability analysis

### Customer Analysis

* Orders per customer
* Customer classification
* Sales and profit per customer
* Top customers by sales
* Top customers by profit
* Sales and profit by customer segment

### Geographic Analysis

* Customers by region
* Regional sales and profitability analysis

### Shipping Analysis

* Shipping duration per order
* Average shipping duration by shipping mode
* Shipping performance analysis

### Time Analysis

* Orders by month
* Orders by quarter
* Sales and operational trend analysis

## Advanced SQL Components

### View

`KPIs_View`

Provides the main business KPIs:

* Total Sales
* Total Profit
* Total Quantity Sold

### Stored Procedure

`Get_Region_Performance`

Returns sales and profit performance for a selected region.

### CTEs & CASE

CTEs and CASE statements are used for product profitability segmentation, customer classification, and time-based analysis.

## Business Insights

The analysis is designed to identify:

* Differences between sales volume and actual profitability.
* High-performing and non-profitable products.
* Customer concentration and segment contribution.
* Regional differences in sales and profitability.
* Shipping duration patterns across shipping modes.
* Monthly and quarterly order trends.

## Business Recommendations

The analysis can support business decisions related to:

* Product portfolio and pricing strategy.
* Discount and margin management.
* Customer retention and segmentation.
* Regional sales strategy.
* Shipping and logistics optimization.
* Seasonal planning and performance monitoring.

## Tools

* **SQL Server**
* **SQL**
* **Relational Database Design**
* **Star Schema**
* **Data Warehousing**
* **Business Analytics**

## Project Skills Demonstrated

**SQL | Data Warehousing | Star Schema | Data Modeling | Business Analytics | KPI Analysis | Customer Analysis | Product Analysis | Profitability Analysis**
