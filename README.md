# Amazon Data Analysis Using SQL

<div align="center">
    <img src="https://github.com/user-attachments/assets/5610fbcf-06d9-4dc3-b538-9cd45136cc56" alt="Amazon Logo" height="200" width="400">
</div>

## Overview
This project is a comprehensive analysis of an Amazon-like e-commerce platform using SQL. The dataset simulates real-world data, capturing the complexities of e-commerce operations, including orders, products, customers, payments, shipping, inventory, and more. Through advanced SQL queries, the project aims to derive actionable business insights and solve critical operational challenges.

## Key Business Problems Solved
## Key Business Problems Solved

1. **Top-selling products and categories**: Identified top 10 products and categories based on total sales and revenue.  
2. **Revenue trends and category performance**: Analyzed revenue trends across categories to find the most profitable ones.  
3. **Customer lifetime value (CLV) calculation**: Computed total customer spending to highlight high-value clients.  
4. **Average order value analysis**: Evaluated average order value to understand customer purchasing behavior.  
5. **Monthly sales trends**: Monitored monthly sales trends to identify peak and low-performing periods.  
6. **Customer segmentation**: Categorized customers as "Returning" or "New" based on purchase history.  
7. **Cross-selling opportunities**: Identified frequently bought-together products to enhance cross-selling strategies.  
8. **Inventory stock alerts**: Detected critically low stock levels for timely restocking.  
9. **Shipping performance and delays**: Evaluated shipping delays to optimize delivery processes.  
10. **Payment success and failure rates**: Analyzed payment transaction success and failure rates.  
11. **Top-performing sellers**: Ranked sellers based on revenue contributions to prioritize partnerships.  
12. **Product margin analysis**: Evaluated product margins to identify the most profitable items.  
13. **Most returned products**: Highlighted products with high return rates for quality improvement.  
14. **Pending shipments**: Identified orders with payments completed but shipments pending.  
15. **Inactive sellers**: Flagged sellers with no sales in the past 6 months.  
16. **Predictive analysis for sales trends**: Proposed solutions to forecast sales trends using historical data.  
17. **Real-time inventory updates**: Suggested trigger-based inventory updates for better stock management.  
18. **Customer segmentation for targeted marketing**: Segmented customers by spending patterns for marketing campaigns.  
19. **Supply chain optimization**: Developed queries to enhance delivery efficiency and reduce shipping delays.  
20. **Sentiment analysis using customer feedback**: Explored customer reviews for satisfaction and churn prediction.  

## Objectives
- Perform detailed data analysis on an e-commerce dataset.
- Use SQL queries to solve real-world business problems.
- Improve proficiency in advanced SQL techniques like CTEs, window functions, and joins.
- Develop insights for revenue optimization, operational efficiency, and customer satisfaction.

## ER Diagram
![ER-diagram](https://github.com/user-attachments/assets/7f43e8d8-7e61-4023-8357-6adfd8d55ad2)

## Tech Stack Used
- **Database**: MySQL
- **Development Tool**: MySQL Workbench
- **Other Tools**: GitHub for version control

## Dataset Overview
The dataset contains approximately **25,000 records** spread across 9 tables. Below is a detailed breakdown of the dataset structure:

### Tables and Attributes
1. **category**
   - `category_id`: Unique identifier for categories.
   - `category_name`: Name of the category.
   
2. **customer**
   - `customer_id`: Unique identifier for customers.
   - `first_name`, `last_name`: Customer names.
   - `state`: Customer's state.
   - `address`: Customer address.
   
3. **seller**
   - `seller_id`: Unique identifier for sellers.
   - `seller_name`: Name of the seller.
   - `country`: Seller's country.

4. **product**
   - `product_id`: Unique identifier for products.
   - `product_name`: Name of the product.
   - `price`, `cogs`: Price and cost of goods sold.
   - `category_id`: Foreign key referencing `category`.

5. **orders**
   - `order_id`: Unique identifier for orders.
   - `order_date`: Date of the order.
   - `customer_id`: Foreign key referencing `customer`.
   - `seller_id`: Foreign key referencing `seller`.
   - `order_status`: Status of the order (e.g., Delivered, Returned).

6. **order_item**
   - `order_item_id`: Unique identifier for each item in an order.
   - `order_id`: Foreign key referencing `orders`.
   - `product_id`: Foreign key referencing `product`.
   - `quantity`: Quantity of the product ordered.
   - `price`: Price per unit of the product.

7. **payment**
   - `payment_id`: Unique identifier for payments.
   - `order_id`: Foreign key referencing `orders`.
   - `payment_status`: Status of the payment (e.g., Success, Refunded).
   - `payment_date`: Date of the payment.

8. **shipping**
   - `shipping_id`: Unique identifier for shipping records.
   - `order_id`: Foreign key referencing `orders`.
   - `shipping_date`: Date of shipping.
   - `return_date`: Date of return (if applicable).
   - `shipping_provider`: Shipping provider name.
   - `shipping_status`: Status of the shipping.

9. **inventory**
   - `inventory_id`: Unique identifier for inventory records.
   - `product_id`: Foreign key referencing `product`.
   - `warehouse_id`: Warehouse identifier.
   - `stock`: Stock quantity.
   - `last_stock_date`: Date of the last stock update.

## List of Business Problems and Solutions

1. **Top-selling products and their total revenue**
    ```sql
    SELECT 
        p.product_name, 
        SUM(oi.quantity) AS total_quantity_sold, 
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM order_item oi
    JOIN product p ON oi.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY total_revenue DESC
    LIMIT 10;
    ```

2. **Revenue by category**
    ```sql
    SELECT 
        c.category_name, 
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM order_item oi
    JOIN product p ON oi.product_id = p.product_id
    JOIN category c ON p.category_id = c.category_id
    GROUP BY c.category_name
    ORDER BY total_revenue DESC;
    ```

3. **Average order value**
    ```sql
    SELECT 
        o.order_id, 
        SUM(oi.quantity * oi.price) AS total_order_value
    FROM orders o
    JOIN order_item oi ON o.order_id = oi.order_id
    GROUP BY o.order_id;
    ```

4. **Monthly sales trends**
    ```sql
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month, 
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM orders o
    JOIN order_item oi ON o.order_id = oi.order_id
    GROUP BY sales_month
    ORDER BY sales_month;
    ```

5. **Customers with no purchases**
    ```sql
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name
    FROM customer c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_id IS NULL;
    ```

6. **Best-selling categories by state**
    ```sql
    SELECT 
        c.category_name, 
        cu.state, 
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM order_item oi
    JOIN product p ON oi.product_id = p.product_id
    JOIN category c ON p.category_id = c.category_id
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customer cu ON o.customer_id = cu.customer_id
    GROUP BY c.category_name, cu.state
    ORDER BY total_revenue DESC;
    ```

7. **Customer lifetime value**
    ```sql
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(oi.quantity * oi.price) AS lifetime_value
    FROM customer c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_item oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY lifetime_value DESC;
    ```

8. **Inventory stock alerts**
    ```sql
    SELECT 
        p.product_name, 
        i.stock 
    FROM inventory i
    JOIN product p ON i.product_id = p.product_id
    WHERE i.stock < 10;
    ```

9. **Shipping delays**
    ```sql
    SELECT 
        o.order_id, 
        DATEDIFF(s.shipping_date, o.order_date) AS delay_days
    FROM orders o
    JOIN shipping s ON o.order_id = s.order_id
    WHERE DATEDIFF(s.shipping_date, o.order_date) > 7;
    ```

10. **Payment success rates**
    ```sql
    SELECT 
        p.payment_status, 
        COUNT(*) AS total_payments
    FROM payment p
    GROUP BY p.payment_status;
    ```

11. **Top-performing sellers**
    ```sql
    SELECT 
        s.seller_name, 
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM seller s
    JOIN orders o ON s.seller_id = o.seller_id
    JOIN order_item oi ON o.order_id = oi.order_id
    GROUP BY s.seller_name
    ORDER BY total_revenue DESC
    LIMIT 5;
    ```

12. **Product margin analysis**
    ```sql
    SELECT 
        p.product_name, 
        (p.price - p.cogs) / p.price * 100 AS margin_percentage
    FROM product p
    ORDER BY margin_percentage DESC;
    ```

13. **Most returned products**
    ```sql
    SELECT 
        p.product_name, 
        COUNT(s.return_date) AS total_returns
    FROM shipping s
    JOIN orders o ON s.order_id = o.order_id
    JOIN order_item oi ON o.order_id = oi.order_id
    JOIN product p ON oi.product_id = p.product_id
    WHERE s.return_date IS NOT NULL
    GROUP BY p.product_name
    ORDER BY total_returns DESC;
    ```

14. **Orders pending shipment**
    ```sql
    SELECT 
        o.order_id, 
        o.order_date, 
        p.payment_status
    FROM orders o
    JOIN payment p ON o.order_id = p.order_id
    LEFT JOIN shipping s ON o.order_id = s.order_id
    WHERE p.payment_status = 'Success' AND s.shipping_date IS NULL;
    ```

15. **Inactive sellers**
    ```sql
    SELECT 
        s.seller_name 
    FROM seller s
    LEFT JOIN orders o ON s.seller_id = o.seller_id
    WHERE o.order_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
    ```

16. **Categorize customers as returning or new**
    ```sql
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        CASE 
            WHEN COUNT(s.return_date) > 0 THEN 'Returning'
            ELSE 'New'
        END AS customer_category
    FROM customer c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN shipping s ON o.order_id = s.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
    ```

17. **Cross-selling opportunities**
    ```sql
    SELECT 
        oi1.product_id AS product_id_1,
        p1.product_name AS product_name_1,
        oi2.product_id AS product_id_2,
        p2.product_name AS product_name_2,
        COUNT(*) AS times_bought_together
    FROM order_item oi1
    JOIN order_item oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id < oi2.product_id
    JOIN product p1 ON oi1.product_id = p1.product_id
    JOIN product p2 ON oi2.product_id = p2.product_id
    GROUP BY oi1.product_id, p1.product_name, oi2.product_id, p2.product_name
    ORDER BY times_bought_together DESC
    LIMIT 10;
    ```

18. **Top customers by state**
    ```sql
    WITH ranked_customers AS (
        SELECT 
            c.state, 
            c.customer_id, 
            c.first_name, 
            c.last_name, 
            COUNT(o.order_id) AS total_orders,
            RANK() OVER (PARTITION BY c.state ORDER BY COUNT(o.order_id) DESC) AS rank
        FROM customer c
        JOIN orders o ON c.customer_id = o.customer_id
        GROUP BY c.state, c.customer_id, c.first_name, c.last_name
    )
    SELECT 
        state, 
        customer_id, 
        first_name, 
        last_name, 
        total_orders
    FROM ranked_customers
    WHERE rank <= 5;
    ```

19. **Revenue by shipping provider**
    ```sql
    SELECT 
        s.shipping_provider, 
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM shipping s
    JOIN orders o ON s.order_id = o.order_id
    JOIN order_item oi ON o.order_id = oi.order_id
    WHERE s.shipping_status = 'Delivered'
    GROUP BY s.shipping_provider
    ORDER BY total_revenue DESC;
    ```

20. **Products with the highest revenue decline**
    ```sql
    WITH yearly_revenue AS (
        SELECT 
            p.product_id, 
            p.product_name, 
            YEAR(o.order_date) AS year, 
            SUM(oi.quantity * oi.price) AS revenue
        FROM product p
        JOIN order_item oi ON p.product_id = oi.product_id
        JOIN orders o ON oi.order_id = o.order_id
        GROUP BY p.product_id, p.product_name, YEAR(o.order_date)
    ),
    revenue_change AS (
        SELECT 
            yr1.product_id, 
            yr1.product_name, 
            yr1.revenue AS current_year_revenue,
            yr2.revenue AS previous_year_revenue,
            (yr1.revenue - yr2.revenue) / yr2.revenue * 100 AS revenue_decline_percentage
        FROM yearly_revenue yr1
        JOIN yearly_revenue yr2 ON yr1.product_id = yr2.product_id AND yr1.year = yr2.year + 1
    )
    SELECT 
        product_id, 
        product_name, 
        revenue_decline_percentage
    FROM revenue_change
    ORDER BY revenue_decline_percentage DESC
    LIMIT 10;
    ```


## Future Business Problems to Solve
- Predictive analysis for sales trends.
- Real-time inventory updates with trigger-based SQL functions.
- Advanced customer segmentation and targeting.
- Sentiment analysis using customer feedback data (if available).
- Supply chain optimization for better shipping efficiency.

## Conclusion
This project demonstrates the power of SQL in solving complex business problems for an e-commerce platform. By simulating a real-world dataset, it showcases advanced querying techniques and offers actionable insights into operations, sales, and customer behavior.

Feel free to explore the repository and contribute by suggesting new problems or enhancements. Happy analyzing!
