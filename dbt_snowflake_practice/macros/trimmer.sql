{% macro trimmer(col_name) %}
    UPPER(TRIM({{ col_name }}))
{% endmacro %}