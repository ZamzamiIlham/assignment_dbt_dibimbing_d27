{% snapshot films_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='film_id',
    strategy='check',
    check_cols=['title', 'rental_rate', 'rating', 'description']
  )
}}

select
    film_id,
    title,
    rental_rate,
    rating,
    description
from {{ ref('stg_films') }}

{% endsnapshot %}