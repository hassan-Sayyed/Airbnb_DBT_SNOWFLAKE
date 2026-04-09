{{
  config(
    materialized = 'incremental',
    unique_key = 'Host_Id',
    )
}}

select host_id,
replace(host_name,' ','_') as host_name,
host_since,
is_superhost,
response_rate,
case 
when response_rate > 95 then 'very good'
when response_rate > 90 then 'good'
when response_rate > 80 then 'medium'
else 'poor'
end as response_Quality_remarks,
created_at
from {{ ref('bronze_hosts') }}
