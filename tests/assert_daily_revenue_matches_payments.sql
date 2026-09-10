WITH mart_revenues AS (
    SELECT 
        COALESCE(SUM(total_revenue),0) as total_revenue,
        COALESCE(SUM(total_payments),0) as total_payments
    FROM {{ref('mart_daily_revenue')}}
),
stg_payment AS (
    SELECT 
        COALESCE(SUM(amount),0) as sum_amounts,
        COALESCE(COUNT(payment_id),0) as total_payments
    FROM {{ref('stg_payments')}}
)
SELECT 
    mr.total_revenue as mart_total_revenue,
    sp.sum_amounts as stg_total_amounts,
    mr.total_payments as mart_total_payments,
    sp.total_payments as stg_total_payments
FROM mart_revenues mr
CROSS JOIN stg_payment sp
WHERE 
    ABS(mr.total_revenue - sp.sum_amounts) > 0.01
    OR mr.total_payments != sp.total_payments