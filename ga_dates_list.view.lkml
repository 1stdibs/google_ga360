view: ga_dates_list {
  sql_table_name: `api-project-1065928543184.96922533.ga_sessions_*`;;

  dimension: date {
    type: string
    sql: DISTINCT PARSE_DATE('%Y%m%d', ${TABLE}.date) ;;
  }

}
