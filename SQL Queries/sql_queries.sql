--1. Stock level calculations
SELECT product_id, store_id, AVG(inventory_level) AS avg_inventory
FROM Sales
GROUP BY product_id, store_id;

--2. Low inventory detection
SELECT store_id, product_id, inventory_level
FROM Sales
WHERE inventory_level < demand_forecast * 0.75;

--3. Reorder point estimation
SELECT product_id, store_id,
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY inventory_level) AS reorder_point
FROM Sales
GROUP BY product_id, store_id;

--4. Inventory turnover ratio
SELECT product_id, store_id,
       SUM(units_sold) / NULLIF(AVG(inventory_level), 0) AS turnover_ratio
FROM Sales
GROUP BY product_id, store_id;

--5. Summary KPI report
SELECT
    store_id,
    COUNT(*) FILTER (WHERE inventory_level < demand_forecast * 0.75) AS stockouts,
    COUNT(*) FILTER (WHERE inventory_level > demand_forecast * 1.25) AS overstocked,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(discount), 2) AS avg_discount
FROM Sales
GROUP BY store_id;
