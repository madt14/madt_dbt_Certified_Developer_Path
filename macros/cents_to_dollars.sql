{%- macro cents_to_dollars (column_name, precision=2) -%}
    round( (1.0 * {{ column_name }} ) / 100.0, {{ precision }})
{%- endmacro -%}