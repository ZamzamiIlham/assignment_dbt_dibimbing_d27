WITH payments AS(
    SELECT * FROM {{ source('pagila', 'payment') }}
)
SELECT
    payment_id,
    customer_id,
    rental_id,
    staff_id,
    amount,
    payment_date as paid_at
FROM payments