SELECT
    paid_date,
    store_id,
    COUNT(*) as total_payments,
    COUNT(DISTINCT customer_id) as unique_customers,
    SUM(amount) as total_revenue
FROM {{ ref('fact_payments') }}
GROUP BY paid_date, store_id