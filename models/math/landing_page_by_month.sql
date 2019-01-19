SELECT
yyyymm, 
recipeid,
recipeinstanceid,
site,
domain,
landing_page_url,
impressions,
clicks,
ctr,
min_position,
sessions,
sum(sessions) OVER w1 total_sessions,
goal_completions_all,
sum(goal_completions_all) OVER w1 total_goal_completions
FROM (
    SELECT 
    FORMAT_DATE("%Y-%m", date) AS yyyymm,
    recipeid,
    recipeinstanceid,
    site,
    domain,
    landing_page_url,
    sum(sessions) sessions,
    sum(goal_completions_all) goal_completions_all,
    sum(clicks) clicks,
    sum(impressions) impressions,
    sum(clicks)/sum(impressions) as ctr,
    min(position) as min_position
    FROM {{ ref('agg_platforms_ga') }}
    GROUP BY date, recipeid, recipeinstanceid, site, domain, landing_page_url
)
WINDOW w1 as (PARTITION BY yyyymm, recipeinstanceid)