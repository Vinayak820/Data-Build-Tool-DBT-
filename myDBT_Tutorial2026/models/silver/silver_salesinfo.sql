with 
sales as
(
    SELECT 
        sales_id,
        gross_amount,
        product_sk,
        customer_sk,
        {{multiply('unit_price', 'quantity')}} as calculated_gross_amount,
        payment_method
    FROM
        {{ref('bronze_sales')}}
),
product as
(
    SELECT
        product_sk,
        category
    FROM
        {{ref("bronze_product")}}
),
customer as
(
    SELECT 
        customer_sk,
        gender
    FROM
        {{ref("bronze_customer")}}
),

joined_query as
(
    SELECT 
        s.sales_id,
        s.gross_amount,
        s.calculated_gross_amount,
        p.category,
        c.gender,
        s.payment_method
    FROM
        sales s
    JOIN
        product p
    ON
        s.product_sk = p.product_sk
    JOIN
        customer c
    ON
        s.customer_sk = c.customer_sk
)

{# We want to find which category per gender performs well. #}
SELECT 
    category,
    gender,
    SUM(gross_amount) as total_gross_amount,
    SUM(calculated_gross_amount) as total_calculated_gross_amount
FROM
    joined_query
GROUP BY
    category,
    gender
ORDER BY
    total_gross_amount DESC