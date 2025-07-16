{%- set tables=['union__part1', 'union__part2'] -%}

---- creating 2 tables hat can be unioned together. 
---- A begin/end block is needed to allow multiple DDL (CREATE) or DML (INSERT) statements in a single SQL execution

begin;

{%- for table in tables -%}
    create table if not exists {{ table }} (
        id int primary key,
        name varchar
    );

insert into {{ table }} values (1, 'test_{{ table }}');

{% endfor %}

end;

------------------------------

{{
    union_tables_by_prefix(
        database="TIL_PORTFOLIO_PROJECTS", schema="dbt_mtucker", prefix="union__"
    )
}}
