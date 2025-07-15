{# in dbt Develop #}

--------------------------------------------------------
{#
-- Macro: Modified compare_relations

{% set old_etl_relation=adapter.get_relation(
database=target.database,
schema= 'dbt_mtucker',
identifier= 'customer_orders'
) -%}

{% set dbt_relation=ref('fct_customer_orders') %}

{% if execute %}

{{ audit_helper.compare_relations(
a_relation=old_etl_relation,
b_relation=dbt_relation,
primary_key= 'order_id'
) }}

{% endif %}

#}
--------------------------------------------------------



-- Macro: Modified compare_and_classify_relation_rows

{% set old_relation = adapter.get_relation(
      database = target.database,
      schema = "dbt_mtucker",
      identifier = "customer_orders"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{% if execute %}

{{ audit_helper.compare_and_classify_relation_rows(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key_columns = ["order_id"],
    columns = None
) }}

{% endif %}



--------------------------------------------------------
{#
-- Macro: compare_and_classify_query_results


{% set old_query %}
  select
        *
  from {{ ref('customer_orders') }}
{% endset %}

{% set new_query %}
  select
        *
  from {{ ref('fct_customer_orders') }}
{% endset %}

{{ 
  audit_helper.compare_and_classify_query_results(
    old_query, 
    new_query, 
    primary_key_columns=['order_id'] 
  )
}}

#}
--------------------------------------------------------
{#

-- Macro: compare_queries

{% set old_query %}
  select
        *
  from {{ ref('customer_orders') }}
{% endset %}

{% set new_query %}
  select
        *
  from {{ ref('fct_customer_orders') }}
{% endset %}

{{ audit_helper.compare_queries(
    a_query = old_query,
    b_query = new_query,
    primary_key = "order_id"
) }}

#}