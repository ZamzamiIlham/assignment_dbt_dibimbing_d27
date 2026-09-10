WITH film_summary as (
    SELECT 
        i.store_id,
        r.rental_id,
        i.film_id,
        f.title as film_title
    FROM {{ ref('stg_rentals') }} r
    LEFT JOIN {{ ref('stg_inventory') }} i
        ON i.inventory_id = r.inventory_id
    LEFT JOIN {{ ref('stg_films') }} f
        ON i.film_id = f.film_id
)
SELECT
    p.payment_id,
    p.paid_at,
    p.paid_at::DATE as paid_date,
    c.customer_id,
    {{ full_name('c.first_name','c.last_name') }} as customer_name,
    p.staff_id,
    f.store_id,
    f.rental_id,
    f.film_id,
    f.film_title,
    p.amount

FROM {{ ref('stg_payments') }} p
LEFT JOIN {{ ref('stg_customers') }} c
    ON c.customer_id = p.customer_id
LEFT JOIN film_summary f 
    ON f.rental_id = p.rental_id 