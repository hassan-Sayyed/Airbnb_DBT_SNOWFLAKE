{{
  config(
    materialized = 'incremental',
    unique_key = 'LISTING_ID',
    )
}}

select Listing_id,
HOST_ID,
PROPERTY_TYPE,
ROOM_TYPE,
CITY,
ACCOMMODATES,BATHROOMS,
BEDROOMS,{{trimmer('Country')}} as Country,
PRICE_PER_NIGHT,
{{tag('cast (price_per_night as int)')}} as price_per_night_tag,
CREATED_AT
from {{ref('bronze_listings') }}