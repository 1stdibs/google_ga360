view: bq_budget_gmv_rev {
  sql_table_name: testing.bq_budget_gmv_rev ;;

  measure: Budget_Total_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Budget_Total_Confirmed_Orders ;;
  }

  measure: Budget_Consumer_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Budget_Consumer_Confirmed_Orders ;;
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

  measure: Budget_Trade_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Budget_Trade_Confirmed_Orders ;;
  }

  measure: Budget_Off_Platform_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Budget_Off_Platform_Confirmed_Orders ;;
  }

  measure: Budget_Total_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Budget_Total_Confirmed_GMV ;;
  }

  measure: Budget_Consumer_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Budget_Consumer_Confirmed_GMV ;;
  }

  measure: Budget_Trade_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Budget_Trade_Confirmed_GMV ;;
  }

  measure: Budget_Off_Platform_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Budget_Off_Platform_Confirmed_GMV ;;
  }

  measure: Reforecast_Total_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Total_Confirmed_Orders ;;
  }

  measure: Reforecast_Consumer_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Consumer_Confirmed_Orders ;;
  }

  measure: Reforecast_Trade_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Trade_Confirmed_Orders ;;
  }

  measure: Reforecast_Off_Platform_Confirmed_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Off_Platform_Confirmed_Orders ;;
  }

  measure: Reforecast_Total_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Total_Confirmed_GMV ;;
  }

  measure: Reforecast_Consumer_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Consumer_Confirmed_GMV ;;
  }

  measure: Reforecast_Trade_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Trade_Confirmed_GMV ;;
  }

  measure: Reforecast_Off_Platform_Confirmed_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Off_Platform_Confirmed_GMV ;;
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
