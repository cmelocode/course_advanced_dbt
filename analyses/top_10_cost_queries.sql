with
max_date as (
    select max(date(end_time)) as date
    from query_history_enriched
)
select
    md5(query_history_enriched.query_text_no_comments) as query_signature,
    any_value(query_history_enriched.query_text) as query_text,
    sum(query_history_enriched.query_cost) as total_cost_last_60d,
    total_cost_last_60d*12 as estimated_annual_cost,
    max_by(warehouse_name, start_time) as latest_warehouse_name,
    max_by(warehouse_size, start_time) as latest_warehouse_size,
    max_by(query_id, start_time) as latest_query_id,
    avg(execution_time_s) as avg_execution_time_s,
    count(*) as num_executions
from query_history_enriched
cross join max_date
where
    query_history_enriched.start_time >= dateadd('day', -60, max_date.date)
    and query_history_enriched.start_time < max_date.date -- don't include partial day of data
group by 1
order by total_cost_last_60d desc
limit 10
bh