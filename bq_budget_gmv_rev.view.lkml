view: bq_budget_gmv_rev {
  sql_table_name: testing.bq_budget_gmv_rev ;;

  measure: consumer_confirmed_gmv {
    type: sum
    sql: ${TABLE}.consumer_confirmed_gmv ;;
  }

  measure: consumer_confirmed_orders {
    type: sum
    sql: ${TABLE}.consumer_confirmed_orders ;;
  }

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

  measure: trade_confirmed_gmv {
    type: sum
    sql: ${TABLE}.trade_confirmed_gmv ;;
  }

  measure: trade_confirmed_orders {
    type: sum
    sql: ${TABLE}.trade_confirmed_orders ;;
  }

  measure: transactional_revenue {
    type: sum
    sql: ${TABLE}.transactional_revenue ;;
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
