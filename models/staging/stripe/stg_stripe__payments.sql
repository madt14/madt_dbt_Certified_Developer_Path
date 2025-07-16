with source as (

    select * from {{ source('stripe', 'payment') }}

),


transformed as (

    select
        id as payment_id,
        orderid as order_id,
        status as payment_status,
        created as payment_made_on,
        {{cents_to_dollars('amount',0)}} as payment_amount
    from source

)

select * from transformed

{{ limit_data_in_dev('payment_made_on', 10000) }}