{% macro month_trunc(exact_date='date_month') -%}
 DATE(DATE_TRUNC('month', {{exact_date}}))
{% endmacro -%}
