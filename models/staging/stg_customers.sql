WITH customers AS(
    SELECT * FROM {{ source('pagila', 'customer') }}
)
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    active as is_active,
    CAST(create_date as timestamp) as created_at,
    last_update
FROM customers