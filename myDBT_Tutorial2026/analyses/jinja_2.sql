{% set apples = ["Gala", "Fuji", "Honeycrisp", "Granny Smith"] %}
{%- for apple in apples %}
    {%- if apple != "Fuji" %}
        {{- apple -}}
    {% else -%}
        I hate {{ apple -}} 
    {% endif %}
{% endfor %}

