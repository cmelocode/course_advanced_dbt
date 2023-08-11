{% macro rolling_agg_n_periods(column_name,agg_func="avg", n_periods=4, partition_by="user_id , subscription_id", order_by="date_month") -%}
    {{agg_func}}( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{n_periods-1}} PRECEDING AND CURRENT ROW
            ) AS avg_{{n_periods}}_periods_{{ column_name }}
{% endmacro %}
