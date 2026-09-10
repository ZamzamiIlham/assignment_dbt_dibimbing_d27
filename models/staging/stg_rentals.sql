WITH rentals AS(
    SELECT * FROM {{ source('pagila', 'rental') }}
)
SELECT
    rental_id,
    customer_id,
    inventory_id,
    staff_id,
    rental_date as rented_at,
    return_date as returned_at
FROM rentals