WITH stg_customers as (
    SELECT * FROM {{ ref('stg_customers') }}
),
rentals_summary as(
    SELECT
        customer_id,
        COUNT(rental_id) as total_rental,
        MIN(rented_at) AS first_rented_at,
        MAX(rented_at) AS last_rented_at
    FROM {{ ref('stg_rentals') }}
    GROUP BY customer_id
),
payment_summary as (
    SELECT
        customer_id, 
        SUM(amount) as lifetime_payment_total
    FROM {{ ref('stg_payments') }}
    GROUP BY customer_id
)
SELECT
    sc.customer_id,
    {{ full_name('sc.first_name','sc.last_name') }} AS customer_name,
    COALESCE(rs.total_rental,0) as total_rentals,
    rs.first_rented_at,
    rs.last_rented_at,
    COALESCE(ps.lifetime_payment_total,0) as lifetime_payment_total
FROM stg_customers sc
LEFT JOIN rentals_summary rs
    ON sc.customer_id = rs.customer_id
LEFT JOIN payment_summary ps
    ON sc.customer_id = ps.customer_id
ORDER BY sc.customer_id ASC