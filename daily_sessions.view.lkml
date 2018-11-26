view: daily_sessions {
  sql_table_name: google_analytics_fact.daily_sessions ;;

  dimension: app_pageviews_count {
    type: number
    sql: ${TABLE}.app_pageviews_count ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.gadate ;;
  }

  dimension: host {
    type: string
    sql: ${TABLE}.host ;;
  }

  measure: pageviews_count {
    type: sum
    sql: ${TABLE}.pageviews_count ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: sessions_count {
    type: number
    sql: ${TABLE}.sessions_count ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
