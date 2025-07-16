{%- macro union_tables_by_prefix(database, schema, prefix) -%}

    {%- set tables = dbt_utils.get_relations_by_prefix(database=database, schema=schema, prefix=prefix) -%}
    
    {% do log("Found tables: " ~ tables, info=True) %}


    {% for table in tables %}
        {% if not loop.first %}
            union all
        {% endif %}
        select * from {{ table }}
    {% endfor %}

{%- endmacro -%}