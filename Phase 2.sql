use Second_Phase

select Region,
Round(Sum(Sales),2) as Sum_of_Sales,
Round(Sum(Profit),2) as Sum_of_Profit
from [retail_sales_2023]
Group By Region;


Select c.Segment,
       c.City,
       Round(AVG(r.Sales),2) as Avg_Spend
from dbo.retail_sales_2023 r
JOIN dbo.customers c
       on c.Customer_id = r.Customer_id
Group by
       c.Segment,
       c.city;

select
    s.Product_Name,
    Round(s.Sales,2) as Sales,
    Round(p.Cost_Price,2) as Cost_Price,
    Round((s.Sales - p.Cost_Price),2) as Actual_Margin
from dbo.retail_sales_2023 s
JOIN dbo.products p
    on s.Product_Name = p.Product_Name;

SELECT
    s.Category,
    r.Return_Reason,
    COUNT(CASE
        WHEN r.Status = 'Approved' THEN r.Order_ID
    END) AS Returned_Orders,
    COUNT(s.Order_ID) AS Total_Orders,
    (COUNT(CASE
        WHEN r.Status = 'Approved' THEN r.Order_ID
    END) * 100.0 / COUNT(s.Order_ID)) AS Return_Rate_Percentage
FROM dbo.retail_sales_2023 s
JOIN dbo.returns r
    ON s.Order_ID = r.Order_ID
GROUP BY
    s.Category,
    r.Return_Reason;



SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(s.Order_ID) AS Total_Orders,
    COUNT(CASE
        WHEN r.Status = 'Approved' THEN r.Order_ID
    END) AS Returned_Orders
FROM dbo.retail_sales_2023 s
JOIN dbo.customers c
    ON s.Customer_ID = c.Customer_ID
left JOIN dbo.returns r
    ON s.Order_ID = r.Order_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name;


SELECT
    MONTH(Order_Date) AS Month,
    Round(SUM(Sales),2) AS Monthly_Sales
FROM dbo.retail_sales_2023
GROUP BY MONTH(Order_Date)
ORDER BY Month;

SELECT
    MONTH(Order_Date) AS Month,
    Category,
    ROUND(SUM(Sales), 2) AS Sales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS Sales_Rank
FROM dbo.retail_sales_2023
GROUP BY
    MONTH(Order_Date),
    Category;