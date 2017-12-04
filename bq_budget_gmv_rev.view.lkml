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

  measure: Budget_Total_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Budget_Total_Submitted_Orders ;;
  }

  measure: Budget_Furniture_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Budget_Furniture_Submitted_Orders ;;
  }

  measure: Budget_Jewelry_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Budget_Jewelry_Submitted_Orders ;;
  }

  measure: Budget_Fashion_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Budget_Fashion_Submitted_Orders ;;
  }

  measure: Budget_Art_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Budget_Art_Submitted_Orders ;;
  }

  measure: Budget_Total_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Budget_Total_Submitted_GMV ;;
  }

  measure: Budget_Furniture_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Budget_Furniture_Submitted_GMV ;;
  }

  measure: Budget_Jewelry_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Budget_Jewelry_Submitted_GMV ;;
  }

  measure: Budget_Fashion_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Budget_Fashion_Submitted_GMV ;;
  }

  measure: Budget_Art_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Budget_Art_Submitted_GMV ;;
  }

  measure: Reforecast_Total_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Total_Submitted_Orders ;;
  }

  measure: Reforecast_Furniture_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Furniture_Submitted_Orders ;;
  }

  measure: Reforecast_Jewelry_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Jewelry_Submitted_Orders ;;
  }

  measure: Reforecast_Fashion_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Fashion_Submitted_Orders ;;
  }

  measure: Reforecast_Art_Submitted_Orders {
    type: sum
    sql: ${TABLE}.Reforecast_Art_Submitted_Orders ;;
  }

  measure: Reforecast_Total_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Total_Submitted_GMV ;;
  }

  measure: Reforecast_Furniture_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Furniture_Submitted_GMV ;;
  }

  measure: Reforecast_Jewelry_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Jewelry_Submitted_GMV ;;
  }

  measure: Reforecast_Fashion_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Fashion_Submitted_GMV ;;
  }

  measure: Reforecast_Art_Submitted_GMV {
    type: sum
    sql: ${TABLE}.Reforecast_Art_Submitted_GMV ;;
  }




  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }

}
