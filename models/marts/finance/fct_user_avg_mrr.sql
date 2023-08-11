with fct_mrr as ( select * from {{ ref('fct_mrr') }})

select user_id,
       subscription_id,
       date_month,
        {{ dbt_utils.generate_surrogate_key(['date_month', 'user_id','subscription_id']) }} as surrogate_key,
     {{ rolling_agg_n_periods('mrr_amount') }}
     from fct_mrr
