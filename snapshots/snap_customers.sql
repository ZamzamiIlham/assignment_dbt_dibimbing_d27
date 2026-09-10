{% snapshot customers_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='customer_id',
    strategy='check',
    check_cols=['customer_name']
  )
}}

select 
    customer_id,
    CONCAT(first_name,' ',last_name) as customer_name
from {{ ref('stg_customers') }}

{% endsnapshot %}