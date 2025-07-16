{%- set tables=['union__part1', 'union__part2'] -%}


{%- for table in tables -%}
    create table if not exists {{ table }} (
        id int primary key,
        name varchar
    );

insert into {{ table }} values (1, 'test_{{ table }}');

{% endfor %}


{{
    union_tables_by_prefix(
        database="TIL_PORTFOLIO_PROJECTS", schema="dbt_mtucker", prefix="union__"
    )
}}
