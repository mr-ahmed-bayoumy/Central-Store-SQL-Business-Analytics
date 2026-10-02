# Central Superstore — SQL Business Analytics

## Project Overview

An advanced SQL Server data warehouse and business analytics project built using the Central Superstore dataset.

The project transforms a denormalized retail dataset into a relational analytical database using a Star Schema, then applies SQL queries and analytical techniques to evaluate sales, profitability, customer behavior, product performance, geographic performance, shipping efficiency, and sales trends.

## 📌 Objectives

* Normalize the operational dataset into fact and dimension tables.
* Build a Star Schema for analytical reporting.
* Establish primary and foreign key relationships.
* Calculate key business KPIs.
* Analyze product and customer performance.
* Evaluate geographic and shipping performance.
* Identify sales trends over time.
* Apply advanced SQL techniques for business analysis.

## 🏗️ Data Warehouse Design

The project uses a Star Schema consisting of:

* **FactOrderDetails** — transactional sales, quantity, discount, and profit measures.
* **DimProduct** — product, category, and sub-category information.
* **DimCustomer** — customer and segment information.
* **DimOrders** — order dates, shipping dates, shipping mode, and customer references.
* **DimLocation** — geographic information.
* **Staging_Superstore** — staging table used during the data preparation process.
<img width="1055" height="580" alt="Diagram" src="https://github.com/user-attachments/assets/2fa58cda-2bc9-436e-88f7-4851ae1a0c0c" />

## 💡 SQL Techniques Used

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

## 📈 Business Analysis

### Product Analysis

* Sales and profit by product
* Top profitable products
* Best-selling products
* Top products by quantity sold
* Non-profitable products
* Product profitability segmentation
* Sales and profit by category and sub-category
* Average discount and profitability analysis
<img width="479" height="606" alt="3" src="https://github.com/user-attachments/assets/666a0ec1-fa70-41f9-8d38-3aa39c7a59dc" />

### Customer Analysis

* Orders per customer
* Customer classification
* Sales and profit per customer
* Top customers by sales
* Top customers by profit
* Sales and profit by customer segment
<img width="479" height="606" alt="3" src="https://github.com/user-attachments/assets/5806bbb1-ec8a-404a-81ef-0f74d04e901f" />

### Geographic Analysis

* Customers by region
* Regional sales and profitability analysis
<img width="399" height="603" alt="5" src="https://github.com/user-attachments/assets/87127583-cb75-42ba-bddc-281c8cfc4aab" />

### Shipping Analysis

* Shipping duration per order
* Average shipping duration by shipping mode
* Shipping performance analysis
<img width="514" height="574" alt="6" src="https://github.com/user-attachments/assets/7b51e17a-cfac-4192-bb63-31348e6d9851" />

### Time Analysis

* Orders by month
* Orders by quarter
* Sales and operational trend analysis
<img width="585" height="599" alt="7" src="https://github.com/user-attachments/assets/58be5d56-c4a3-468e-806a-194563522bef" />

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
<img width="1536" height="1024" alt="Business Insights   Recommendation" src="https://github.com/user-attachments/assets/f5524db2-b5bc-472e-bf40-a0490886933c" />

## 🛠️ Tools

* **SQL Server**
* **SQL**
* **Relational Database Design**
* **Star Schema**
* **Data Warehousing**
* **Business Analytics**

## Project Skills Demonstrated

**SQL | Data Warehousing | Star Schema | Data Modeling | Business Analytics | KPI Analysis | Customer Analysis | Product Analysis | Profitability Analysis**
