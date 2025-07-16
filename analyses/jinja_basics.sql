{#-

---- Strings --

{% set my_cool_string = "wow! cool!" %} 
{% set my_second_cool_string='this is jinja!' %} 
{% set my_cool_number = 100 %} 

{{ my_cool_string }} {{ my_second_cool_string }} I want to write Jinja for {{ my_cool_number }} years!


-#}



{#-

---- Lists --

{% set my_animals=['lemur', 'wolf', 'panther', 'tardigrade'] %}

{{ my_animals[0] }}
{{ my_animals[1] }}
{{ my_animals[2] }}
{{ my_animals[3] }}

-#}



{#-

---- "For" loop --

{% set my_animals=['lemur', 'wolf', 'panther', 'tardigrade'] %}

{% for animal in my_animals %}

    My favorite animal is the {{ animal }} !
    
{% endfor %}

-#}


{#-

---- "If" statements --

{% set temperature= 45 %}

{% if temperature < 65 %}
    Time for a cuppuccino!
{% else %}
    Time for a cold brew!
{% endif %}

-#}


{#

---- Nesting and Using "If" and "For" statements together --

{%- set foods = ['carrot', 'hotdog', 'cucumber', 'bell pepper' ] -%}

{% for food in foods %}
    {%- if food == 'hotdog' -%}
        {%- set food_type = 'snack' -%}
    {%- else -%}
        {%- set food_type = 'vegetable' -%}
    {%- endif -%}

    The humble {{ food }} is my favorite {{ food_type }}

{% endfor %}

#}



{#-

---- Dictionaries --

{%- set websters_dict = {
    'word' : 'data',
    'speech_part' : 'noun',
    'definition' : 'if you know you know'
} -%}

{{ websters_dict['word'] }} ({{ websters_dict['speech_part'] }}): defined as "{{ websters_dict['definition'] }}" 

-#}