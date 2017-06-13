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
    sql: ${TABLE}.Date} ;;
    hidden: yes
  }

  measure: organicsearch {
    type: sum
    sql: ${TABLE}.organicsearch ;;
  }

  measure: paidSearch {
    type: sum
    sql: ${TABLE}.paidSearch ;;
  }

  measure: direct {
    type: sum
    sql: ${TABLE}.direct ;;
  }

  measure: referrals {
    type: sum
    sql: ${TABLE}.referrals ;;
  }

  measure: email {
    type: sum
    sql: ${TABLE}.email ;;
  }
  measure: paidDisplayAd {
    type: sum
    sql: ${TABLE}.paidDisplayAds ;;
  }

  measure: productListing {
    type: sum
    sql: ${TABLE}.productListingAds ;;
  }

  measure: appSessions {
    type: sum
    sql: ${TABLE}.appSessions ;;
  }

  measure: unattributed {
    type: sum
    sql: ${TABLE}.unattributed ;;
  }

}
