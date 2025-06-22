# Urban Retail Co. Inventory Management Solution
This project delivers a comprehensive, SQL-driven inventory monitoring and optimization solution for Urban Retail Co., a rapidly expanding retail chain. The primary objective is to transform raw inventory and sales data into actionable insights that address key operational challenges, including:

Frequent stockouts

Overstocking

Limited real-time visibility across the supply chain

Key Features & Solutions
1.  Database Design & Optimization
Normalized Relational Schema:
A robust schema designed in Third Normal Form (3NF) to ensure data integrity, eliminate redundancy, and optimize performance.

Indexing Strategy:
Conceptual indexing recommendations to improve query speed and overall data access efficiency.

2.  Advanced SQL Queries
A comprehensive set of SQL queries supports critical inventory management functions:

Stock Level Calculations: Track inventory at store and warehouse levels.

Low Inventory Detection: Identify products nearing reorder thresholds.

Reorder Point Estimation: Estimate optimal reorder points using historical sales and lead time data.

Inventory Turnover Analysis: Evaluate product turnover to measure inventory efficiency.

KPI Reports: Generate key metrics like stockout rates, inventory age, and average stock levels.

3.  Analytical Insights via Python
Python scripts provide deeper analysis and decision-making support:

Product Performance Analysis: Classify fast-selling vs. slow-moving items to inform stocking and promotions.

Stock Adjustment Recommendations: Suggest optimal adjustments to minimize holding costs and avoid stockouts.

Supplier Performance Analysis: Detect inconsistencies between ordered and sold units, highlighting supply chain issues.

Demand Forecasting: Predict future demand trends using seasonal decomposition and historical data.

 Getting Started
1.  Database Setup
Execute schema.sql to create the database structure in your preferred SQL engine (e.g., MySQL, PostgreSQL, SQLite).

Load the data from inventory_forecasting.csv using a data import tool or a custom loading script.

2.  Run SQL Queries
Use the queries in sql_queries.sql to:

Monitor stock levels

Detect low inventory

Estimate reorder points

Analyze inventory turnover

Generate KPI-based summary reports

3.  Review Reports & Visuals
Dashboard Design: See kpi_dashboard_mockup.md for conceptual layout.

Business Summary: Read executive_summary.md for data-driven insights and business recommendations.

Expected Business Impact
By adopting this solution, Urban Retail Co. can expect to:

 Make smarter, data-informed inventory decisions

 Reduce both stockouts and overstocking

 Improve supply chain visibility and responsiveness

 Increase customer satisfaction and profitability


