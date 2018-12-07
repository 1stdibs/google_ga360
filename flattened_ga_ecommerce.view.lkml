view: flattened_ga_ecommerce {
  sql_table_name: google_analytics.ecommerce ;;

  dimension: app_screen_name {
    type: string
    sql: ${TABLE}.appScreenName ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
  }

  dimension: dealer_id {
    type: string
    sql: ${TABLE}.dealerId ;;
  }

  dimension: dealer_location {
    type: string
    sql: ${TABLE}.dealerLocation ;;
  }

  dimension: dealer_name {
    type: string
    sql: ${TABLE}.dealerName ;;
  }

  dimension: dealer_price {
    type: number
    sql: ${TABLE}.dealerPrice ;;
  }

  dimension: ecom_action_step {
    type: number
    sql: ${TABLE}.ecomActionStep ;;
  }

  dimension: ecom_action_type {
    type: string
    sql: ${TABLE}.ecomActionType ;;
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: ga_date {
    type: string
    sql: ${TABLE}.gaDate ;;
  }

  dimension: guest_id {
    type: string
    sql: ${TABLE}.guestId ;;
  }

  dimension: hit_number {
    type: number
    sql: ${TABLE}.hitNumber ;;
  }

  dimension_group: hit {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      hour_of_day,
      year
    ]
    sql: DATETIME(${TABLE}.hitTime, "America/New_York")  ;;
  }

  dimension: hit_type {
    type: string
    sql: ${TABLE}.hitType ;;
  }

  dimension: is_interaction {
    type: yesno
    sql: ${TABLE}.isInteraction ;;
  }

  dimension: new_listing {
    type: string
    sql: ${TABLE}.newListing ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: posting_location {
    type: string
    sql: ${TABLE}.postingLocation ;;
  }

  dimension: price_type {
    type: string
    sql: ${TABLE}.priceType ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.productBrand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.productCategory ;;
  }

  dimension: product_list_name {
    type: string
    sql: ${TABLE}.productListName ;;
  }

  dimension: product_list_position {
    type: number
    sql: ${TABLE}.productListPosition ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: product_price {
    type: number
    sql: ${TABLE}.productPrice ;;
  }

  dimension: product_quantity {
    type: number
    sql: ${TABLE}.productQuantity ;;
  }

  dimension: product_revenue {
    type: number
    sql: ${TABLE}.productRevenue ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.productSku ;;
  }

  dimension: product_variant {
    type: string
    sql: ${TABLE}.productVariant ;;
  }

  dimension: purchase_status {
    type: string
    sql: ${TABLE}.purchaseStatus ;;
  }

  dimension: time_period {
    type: string
    sql: ${TABLE}.timePeriod ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.userId ;;
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
  }

  dimension: web_page_path {
    type: string
    sql: ${TABLE}.webPagePath ;;
  }

  dimension: transactionId {
    type: string
    sql: ${TABLE}.transactionId ;;
  }

  dimension_group: partition {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._PARTITIONTIME ;;
  }

  set: ecom_purchase {
    fields: [
      web_page_path,
      product_brand,
      product_category,
      product_quantity,
      product_price,
      product_revenue,
      product_name,
      price_type
#       ,order_type,
#       , transactionID


    ]
  }

  set: ecom_productclicks {
    fields: [
      web_page_path,
      product_brand,
      product_category,
      product_sku,
      product_name,
      product_list_name
    ]
  }

  set: ecom_productdetailviews {
    fields: [
      web_page_path,
      product_brand,
      product_category,
      product_name,
      product_sku,
      product_price,
      price_type
    ]
  }

#   measure: count {
#     type: count
#     approximate_threshold: 100000
#     drill_fields: [app_screen_name, product_name, dealer_name, product_list_name]
#   }

  dimension: sessionid {
    type: string
    sql: CONCAT(${full_visitor_id},CAST(${visit_id} AS STRING),CAST(${hit_date} AS STRING));;
  }

  measure: sessions_with_transaction {
    type: count_distinct
    sql: ${sessionid} ;;
    filters: {
      field: ecom_action_type
      value: "completed_purchase"
    }
  }

  measure: transactions_count {
    type: count_distinct
    sql: ${transactionId} ;;
    filters: {
      field: ecom_action_type
      value: "completed_purchase"
    }
  }

  measure: sessions_with_pdp_view{
    type: count_distinct
    sql: ${sessionid} ;;
    filters: {
      field: ecom_action_type
      value: "product_detail_view"
    }
  }
}