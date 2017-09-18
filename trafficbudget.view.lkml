view: trafficbudget {
  sql_table_name: testing.trafficbudget ;;

  dimension_group: date {
    type: time
    timeframes: [date, week, month]
    sql: TIMESTAMP(${TABLE}.Date);;
    convert_tz: no
  }

  dimension: primary {
    type: string
    sql: ${TABLE}.Date ;;
    hidden: yes
  }

  measure: budget_total_sessions {
    type: sum
    sql: ${TABLE}.Budget_total_sessions ;;
    view_label: "Budget"
    label: "Budget Sessions"
  }

  measure: budget_organic_sources {
    type: sum
    sql: ${TABLE}.Budget_organic_sources ;;
    view_label: "Budget"
    label: "Organic Sources"
  }

  measure: budget_paid_sources {
    type: sum
    sql: ${TABLE}.Budget_paid_sources ;;
    view_label: "Budget"
    label: "Paid Sources"
  }

  measure: reforecast_total_sessions {
    type: sum
    sql: ${TABLE}.Reforecast_total_sessions ;;
    view_label: "Reforecast"
    label: "Sessions"
  }

  measure: reforecast_organic_sources {
    type: sum
    sql: ${TABLE}.Reforecast_organic_sources ;;
    view_label: "Reforecast"
    label: "Organic Sources"
  }

  measure: reforecast_paid_sources {
    type: sum
    sql: ${TABLE}.Reforecast_paid_sources ;;
    view_label: "Reforecast"
    label: "Paid Sources"
  }


}
