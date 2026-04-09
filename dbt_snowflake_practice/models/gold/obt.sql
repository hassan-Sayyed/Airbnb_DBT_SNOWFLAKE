{{
  config(
    materialized = 'table'
  )
}}

{% set congigs = [
    {
        "table" : ref('silver_bookings'),
        "columns" : "SILVER_bookings.*",
        "alias" : "SILVER_bookings"
    },
    { 
        "table" : ref('silver_lisitngs'),
        "columns" : "SILVER_lisitngs.HOST_ID, SILVER_lisitngs.PROPERTY_TYPE, SILVER_lisitngs.ROOM_TYPE, SILVER_lisitngs.CITY, SILVER_lisitngs.COUNTRY, SILVER_lisitngs.ACCOMMODATES, SILVER_lisitngs.BEDROOMS, SILVER_lisitngs.BATHROOMS, SILVER_lisitngs.PRICE_PER_NIGHT, silver_lisitngs.PRICE_PER_NIGHT_TAG, SILVER_lisitngs.CREATED_AT AS LISTING_CREATED_AT",
        "alias" : "SILVER_lisitngs",
        "join_condition" : "SILVER_bookings.listing_id = SILVER_lisitngs.listing_id"
    },
    {
        "table" : ref('silver_hosts'),
        "columns" : "SILVER_hosts.HOST_NAME, SILVER_hosts.HOST_SINCE, SILVER_hosts.IS_SUPERHOST, SILVER_hosts.RESPONSE_RATE, SILVER_hosts.RESPONSE_QUALITY_remarks, SILVER_hosts.CREATED_AT AS HOST_CREATED_AT",
        "alias" : "SILVER_hosts",
        "join_condition" : "SILVER_lisitngs.host_id = SILVER_hosts.host_id"
    }
] %}

SELECT 
    {% for config in congigs %}
        {{ config['columns'] }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in congigs %}
        {% if loop.first %}
            {{ config['table'] }} AS {{ config['alias'] }}
        {% else %}
            LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
            ON {{ config['join_condition'] }}
        {% endif %}
    {% endfor %}