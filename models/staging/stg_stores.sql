WITH stores AS(
    SELECT * FROM {{ source('pagila', 'store') }}
)
SELECT
    store_id,
    manager_staff_id,
    address_id
FROM stores