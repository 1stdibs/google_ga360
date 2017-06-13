view: ga_pageviews {
  sql_table_name: google_analytics.pageviews ;;

  dimension: app_screen_name {
    type: string
    sql: ${TABLE}.appScreenName ;;
  }

  dimension: condition {
    type: string
    sql: ${TABLE}.condition ;;
  }

  dimension: content_module {
    type: string
    sql: ${TABLE}.contentModule ;;
  }

  dimension: count_of_items {
    type: number
    sql: ${TABLE}.countOfItems ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
  }

  dimension: dealer_id {
    type: string
    sql: ${TABLE}.dealerId ;;
  }

  dimension: dealer_name {
    type: string
    sql: ${TABLE}.dealerName ;;
  }

  dimension: dealer_price {
    type: number
    sql: ${TABLE}.dealerPrice ;;
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
    convert_tz: yes
    sql: ${TABLE}.hitTime ;;
  }

  dimension: hit_type {
    type: string
    sql: ${TABLE}.hitType ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.hostname ;;
  }

  dimension: is_entrance {
    type: yesno
    sql: ${TABLE}.isEntrance ;;
  }

  dimension: is_exit {
    type: yesno
    sql: ${TABLE}.isExit ;;
  }

  dimension: is_interaction {
    type: yesno
    sql: ${TABLE}.isInteraction ;;
  }

  dimension: item_id {
    type: string
    sql: ${TABLE}.itemId ;;
  }

  dimension: item_posting_location {
    type: string
    sql: ${TABLE}.itemPostingLocation ;;
  }

  dimension: number_of_images {
    type: number
    sql: ${TABLE}.numberOfImages ;;
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.orderType ;;
  }

  dimension: page_number_viewed {
    type: number
    sql: ${TABLE}.pageNumberViewed ;;
  }

  dimension: page_sort {
    type: string
    sql: ${TABLE}.pageSort ;;
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.pageTitle ;;
  }

  dimension: place_of_origin {
    type: string
    sql: ${TABLE}.placeOfOrigin ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: price_type {
    type: string
    sql: ${TABLE}.priceType ;;
  }

  dimension: purchase_status {
    type: string
    sql: ${TABLE}.purchaseStatus ;;
  }

  dimension: release_or_sold_date {
    type: string
    sql: ${TABLE}.releaseOrSoldDate ;;
  }

  dimension: search_term {
    type: string
    sql: ${TABLE}.searchTerm ;;
  }

  dimension: shipping_status {
    type: string
    sql: ${TABLE}.shippingStatus ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.userId ;;
  }

  dimension: view_mode {
    type: string
    sql: ${TABLE}.viewMode ;;
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
  }

  dimension: web_page_path {
    type: string
    sql: ${TABLE}.webPagePath ;;
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
    hidden: yes
  }
  # measure: count {
  #   type: count
  #   # approximate_threshold: 100000
  # }

  dimension: sessionid {
      type: string
      # sql: ${full_visitor_id}||${visit_id}||${hit_date};;
      sql: CONCAT(${full_visitor_id},CAST(${visit_id} AS STRING),CAST(${ga_date} AS STRING));;
  }

  dimension: isPDP {
    type: yesno
    sql:  REGEXP_CONTAINS(${web_page_path}, '/vpv/pdp');;
  }

  dimension: is_searchbrowse{
    type: yesno
    description: "Looker is reporting lower numbers than GA - needs further review"
    sql: REGEXP_CONTAINS(${web_page_path}, '/(search|furniture|art|fashion|jewelry|creators|dealers|collections|locations|sale|contemporary|associations|recognized|shopping-with|buy|(vpv/designers/.+/collections))') AND not REGEXP_CONTAINS(${web_page_path}, '/vpv/pdp');;
  }

  measure: searchbrowse_sessions{
    type: count_distinct
    sql: ${sessionid} ;;
    filters: {
      field: is_searchbrowse
      value: "Yes"
    }
    filters: {
      field: isPDP
      value: "No"
    }
  }

  measure: sessions_count{
    type: count_distinct
    sql: ${sessionid} ;;

  }


}
