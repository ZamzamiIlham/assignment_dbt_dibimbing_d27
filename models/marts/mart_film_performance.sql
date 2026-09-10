WITH total_revenue AS (
    SELECT 
        film_id,
        SUM(amount) as total_revenue
    FROM {{ ref('fact_payments') }}
    GROUP BY film_id 
)
SELECT
    f.film_id,
    f.title,
    f.category,
    f.rental_rate,
    f.inventory_count,
    COALESCE(f.times_rented,0) as times_rented,
    COALESCE(tr.total_revenue, 0) as total_revenue
FROM {{ ref('dim_films') }} f
LEFT JOIN total_revenue tr
    ON tr.film_id = f.film_id