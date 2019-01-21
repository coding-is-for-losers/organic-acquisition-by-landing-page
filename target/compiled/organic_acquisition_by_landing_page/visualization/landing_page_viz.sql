SELECT 
yyyymm Month, 
site Site,
domain Domain,
landing_page_url LandingPage,
ifnull(impressions, 0) Impressions,
ifnull(clicks, 0) Clicks,
ifnull(ctr, 0) CTR,
ifnull(min_position, 0) MinPosition,
ifnull(sessions, 0) Sessions,
ifnull(pct_sessions, 0) PctSessions,
ifnull(goal_completions_all, 0) GoalCompletions,
ifnull(pct_goal_completions, 0) PctGoalCompletions,
ifnull(conversion_index, 0) ConversionIndex
FROM `data-pipeline-api-integrations`.`agency_data_pipeline`.`landing_page_index`