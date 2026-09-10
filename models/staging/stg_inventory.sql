WITH inventory AS(
    SELECT * FROM {{ source('pagila', 'inventory') }}
)
SELECT
    inventory_id,
    film_id,
    store_id
FROM inventory