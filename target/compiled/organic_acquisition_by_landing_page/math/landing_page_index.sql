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
pct_sessions,
goal_completions_all,
pct_goal_completions,
case when pct_sessions > 0 then pct_goal_completions / pct_sessions else null end as conversion_index
FROM (
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
    total_sessions,
    total_goal_completions,
    case when total_sessions > 0 then sessions / total_sessions else null end as pct_sessions,
    goal_completions_all,
    case when total_goal_completions > 0 then goal_completions_all / total_goal_completions else null end as pct_goal_completions
    FROM `data-pipeline-api-integrations`.`agency_data_pipeline`.`landing_page_by_month`
)