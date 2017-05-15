view: looker_ga_sessions_by_day {
  derived_table: {
#     sql_trigger_value: SELECT FLOOR(EXTRACT(epoch from TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY)) / (3*60*60)); ;;
    sql:
    SELECT
  CAST(DATETIME(ga_sessions.sessionStartTime, "America/New_York")   AS DATE) AS ga_sessions_session_start_date,
  COUNT(DISTINCT (CONCAT(ga_sessions.fullVisitorId,CAST(ga_sessions.visitId AS STRING),ga_sessions.gaDate)) ) AS ga_sessions_count
FROM google_analytics.sessions  AS ga_sessions

WHERE
  (((ga_sessions._PARTITIONTIME ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY))) AND (ga_sessions._PARTITIONTIME ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 30 DAY)))))
GROUP BY 1
ORDER BY 1 DESC
       ;;
  }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}.ga_sessions_session_start_date ;;
  }


  measure: ga_sessions_count {
    type: sum
    sql: ${TABLE}.ga_sessions_count ;;
  }


}
