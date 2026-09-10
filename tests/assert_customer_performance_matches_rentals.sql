WITH stg_rentals AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS total_rentals
    FROM {{ ref('stg_rentals') }}
    GROUP BY customer_id
),
stg_payments AS (
    SELECT 
        customer_id,
        SUM(amount) as total_payment
    FROM {{ ref('stg_payments') }}
    GROUP BY customer_id
)
SELECT 
    mc.customer_id,
    mc.total_rentals AS mart_rentals,
    COALESCE(sr.total_rentals, 0) AS stg_rentals,
    mc.lifetime_payment_total AS mart_payments,
    COALESCE(sp.total_payment, 0) AS stg_payments
FROM {{ ref('mart_customer_performance') }} mc
LEFT JOIN stg_rentals sr
    ON mc.customer_id = sr.customer_id
LEFT JOIN stg_payments sp
    ON mc.customer_id = sp.customer_id
WHERE 
    COALESCE(mc.total_rentals, 0) != COALESCE(sr.total_rentals, 0)
    OR COALESCE(mc.lifetime_payment_total, 0) != COALESCE(sp.total_payment, 0)