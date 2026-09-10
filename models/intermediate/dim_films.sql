WITH category_summary AS(
    SELECT
        film_id,
        string_agg(name, ', ') as category
    FROM {{ source('pagila', 'film_category') }} fc
    LEFT JOIN {{ source('pagila', 'category') }} c
        ON c.category_id = fc.category_id
    GROUP BY film_id
),
time_rentals AS(
    SELECT 
        i.film_id,
        COUNT(r.rental_id) as times_rented
    FROM {{ ref('stg_inventory') }} i
    LEFT JOIN {{ ref('stg_rentals') }} r
        ON i.inventory_id = r.inventory_id
    GROUP BY i.film_id
),
inventory_counts AS (
    SELECT 
        film_id,
        COUNT(*) as inventory_count
    FROM {{ ref('stg_inventory') }}
    GROUP BY film_id

),
rating_description AS (
    SELECT * FROM {{ ref('rating_descriptions') }}
)
SELECT 
    f.film_id,
    f.title,
    cs.category,
    f.rating,
    rd.description as rating_description,
    f.rental_rate,

    COALESCE(i.inventory_count, 0) AS inventory_count,
    COALESCE(tr.times_rented, 0) AS times_rented,

    CASE
        WHEN COALESCE(i.inventory_count, 0) > 0 THEN TRUE
        ELSE FALSE
    END AS is_available
FROM {{ ref('stg_films') }} f
LEFT JOIN category_summary cs
    ON cs.film_id = f.film_id
LEFT JOIN time_rentals tr
    ON tr.film_id   = f.film_id 
LEFT JOIN inventory_counts i
    ON i.film_id =  f.film_id
LEFT JOIN rating_description rd
    ON rd.rating = f.rating
ORDER BY film_id ASC