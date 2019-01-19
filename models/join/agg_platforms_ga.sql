with ga as (

	select
	date, 
	recipeid,
	recipeinstanceid,
	site,
	domain,
	landing_page_url,
	sessions,
	goal_completions_all,
	0 as clicks,
	0 as impressions,
	0 as ctr,
	0 as position
	from {{ref('ga_proc')}}

),

platforms as (

	select 
	date, 
	recipeid,
	recipeinstanceid,
	site,
	domain,
	landing_page_url,
	0 as sessions,
	0 as goal_completions_all,
	clicks,
	impressions,
	ctr,
	position
	from {{ref('agg_platforms_union')}}

)


SELECT
date, 
recipeid,
recipeinstanceid,
site,
domain,
landing_page_url,
sum(sessions) sessions,
sum(goal_completions_all) goal_completions_all,
sum(clicks) clicks,
sum(impressions) impressions,
max(ctr) ctr,
max(position) position
FROM
(
    SELECT *
    FROM 
      ga
    UNION ALL
    SELECT *
    FROM 
      platforms 
) 
GROUP BY date, recipeid, recipeinstanceid, site, domain, landing_page_url