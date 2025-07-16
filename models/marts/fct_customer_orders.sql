with 

--- Import CTEs ---

customers as (

  select * from {{ ref('stg_jaffle_shop__customers') }}

) ,

orders as (

  select * from {{ ref('stg_jaffle_shop__orders') }}

),

paid_orders as (

    select 
        *
    FROM {{ ref('int_orders') }}

) ,

--- Logical CTEs ---

customer_orders as (
    
    select 
        customers.customer_id,
        min(orders.order_placed_at) as first_order_date,
        max(orders.order_placed_at) as most_recent_order_date,
        count(orders.order_id) as number_of_orders
    from customers
    left join orders on orders.customer_id = customers.customer_id 
    group by 1

) ,

clv_by_order as (

        (
        select
            order_id,
            sum(total_amount_paid) over (
                partition by customer_id
                order by order_id
            ) as customer_lifetime_value
        from paid_orders
    )

) ,

--- Final CTE ---

final as (

    select
        paid_orders.order_id,
        paid_orders.customer_id,
        paid_orders.order_placed_at,
        paid_orders.order_status,
        paid_orders.total_amount_paid,
        paid_orders.payment_finalized_date,
        customers.customer_first_name,
        customers.customer_last_name,
        row_number() over 
            (
                order by paid_orders.order_id
            ) as transaction_seq,
        row_number() over (
            partition by paid_orders.customer_id 
            order by paid_orders.order_id
        ) as customer_sales_seq,
        case 
            when customer_orders.first_order_date = paid_orders.order_placed_at
            then 'new'
            else 'return' 
        end as nvsr,
        clv_by_order.customer_lifetime_value,
        customer_orders.first_order_date as fdos
    from paid_orders
    left join customer_orders using (customer_id)
    left outer join clv_by_order on clv_by_order.order_id = paid_orders.order_id
    left join customers on paid_orders.customer_id = customers.customer_id
    order by order_id

)

--- Simple Select Statement ---

select * from final