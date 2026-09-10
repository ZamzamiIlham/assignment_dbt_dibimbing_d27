{% macro full_name(first_name_col, last_name_col) %}
    COALESCE({{first_name_col}}, '') || ' ' || COALESCE({{last_name_col}}, '')
{% endmacro %}