{%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%} -- Best to place set statements at the top when appropriate

with payments as (

    select * from {{ source('stripe', 'payment') }}

) ,

{#-

---- Normal SQL method --

pivoted as (

    select
        orderid as order_id,
        
        sum(case
         when paymentmethod = 'bank_transfer' 
         then amount else 0
         end) as bank_transfer_amount,
        
        sum(case
         when paymentmethod = 'coupon' 
         then amount else 0
         end) as coupon_transfer_amount,
        
        sum(case
         when paymentmethod = 'credit_card' 
         then amount else 0
         end) as credit_card_transfer_amount,
        
        sum(case
         when paymentmethod = 'gift_card' 
         then amount else 0
         end) as gift_card_transfer_amount

    from payments
    where status = 'success'
    group by 1
    
)

-------------------------

#}


---- Using Jinja

pivoted as (

    select
        orderid as order_id,
        
        {%- for payment_method in payment_methods %}
        
        sum(case
         when paymentmethod = '{{ payment_method }}' 
         then amount else 0
         end) as {{ payment_method }}_amount

            {%- if not loop.last -%}
                ,
            {%- endif %}
        {%- endfor %}
        
    from payments
    where status = 'success'
    group by 1
)

select * from pivoted