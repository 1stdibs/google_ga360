view: looker_ga_sessions_by_day {
  derived_table: {
    sql_trigger_value: SELECT FLOOR(EXTRACT(epoch from GETDATE()) / (3*60*60)); ;;
    sql: SELECT
        DATE(ga_sessions.sessionStartTime ) AS ga_sessions_session_start_date,
        COUNT(1) AS ga_sessions_count
      FROM google_analytics.sessions  AS ga_sessions
      WHERE ((((ga_sessions.sessionStartTime ) >= ((USEC_TO_TIMESTAMP(UTC_USEC_TO_YEAR(TIMESTAMP_TO_USEC(TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00'))))))) AND (ga_sessions.sessionStartTime ) < ((DATE_ADD(USEC_TO_TIMESTAMP(UTC_USEC_TO_YEAR(TIMESTAMP_TO_USEC(TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00'))))), 1, 'YEAR')))))) AND (ga_sessions._PARTITIONTIME BETWEEN TIMESTAMP('2017-01-01') AND TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00')))
      GROUP BY 1
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
