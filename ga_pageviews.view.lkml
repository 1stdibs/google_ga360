view: ga_pageviews {
  sql_table_name: google_analytics.pageviews ;;

  dimension: app_screen_name {
    type: string
    sql: ${TABLE}.appScreenName ;;
    view_label: "App details"
    group_label: "Screen details"
  }

  dimension: condition {
    type: string
    sql: ${TABLE}.condition ;;
    hidden: yes
  }

  dimension: content_module {
    type: string
    sql: ${TABLE}.contentModule ;;
    hidden: yes
  }

  dimension: count_of_items {
    type: number
    sql: ${TABLE}.countOfItems ;;
    hidden: yes
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
    view_label: "Item details"
    group_label: "Attributes"
  }

  dimension: dealer_id {
    type: string
    sql: ${TABLE}.dealerId ;;
    view_label: "Dealer details"
    label: ".Dealer pk"
  }

  dimension: dealer_name {
    type: string
    sql: ${TABLE}.dealerName ;;
    view_label: "Dealer details"
    label: ".Dealer Name"
  }

  dimension: dealer_price {
    type: number
    sql: ${TABLE}.dealerPrice ;;
    view_label: "Dealer details"
    hidden: yes
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
    hidden: yes
  }

  dimension: ga_date {
    type: string
    sql: ${TABLE}.gaDate ;;
    hidden: yes
  }

  dimension: guest_id {
    type: string
    sql: ${TABLE}.guestId ;;
    view_label: "User details"
    group_label: "Other"
  }

  dimension: hit_number {
    type: number
    sql: ${TABLE}.hitNumber ;;
    view_label: "Pageview details"
  }

  dimension_group: hit {
    type: time
    convert_tz: yes
    sql: ${TABLE}.hitTime ;;
    view_label: "Pageview details"
  }

  dimension: hit_type {
    type: string
    sql: ${TABLE}.hitType ;;
    hidden: yes
  }

  dimension: hostname {
    type: string
    view_label: "Pageview details"
    case: {
      when: {
        sql: ${TABLE}.host like '%.com' ;;
        label: "1stdibs.com"
      }
      when: {
        sql: ${TABLE}.host like '%.de' ;;
        label: "1stdibs.de"
      }
      when: {
        sql: ${TABLE}.host like '%.uk' ;;
        label: "1stdibs.co.uk"
      }
      else: "Other"
    }
  }

  dimension: is_entrance {
    type: yesno
    sql: ${TABLE}.isEntrance ;;
    view_label: "Pageview details"
  }

  dimension: is_exit {
    type: yesno
    sql: ${TABLE}.isExit ;;
    view_label: "Pageview details"
  }

  dimension: is_interaction {
    type: yesno
    sql: ${TABLE}.isInteraction ;;
    hidden: yes
  }

  dimension: item_id {
    type: string
    sql: ${TABLE}.itemId ;;
    view_label: "Item details"
    label: ".Item pk"
  }

  dimension: item_posting_location {
    type: string
    sql: ${TABLE}.itemPostingLocation ;;
    hidden: yes
  }

  dimension: number_of_images {
    type: number
    sql: ${TABLE}.numberOfImages ;;
    group_label: "PDP details"
    view_label: "Item details"
    hidden: yes
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.orderType ;;
    hidden: yes
  }

  dimension: page_number_viewed {
    type: number
    sql: ${TABLE}.pageNumberViewed ;;
    hidden: yes
  }

  dimension: page_sort {
    type: string
    sql: ${TABLE}.pageSort ;;
    hidden: yes
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.pageTitle ;;
    view_label: "Pageview details"
  }

  dimension: place_of_origin {
    type: string
    sql: ${TABLE}.placeOfOrigin ;;
    hidden: yes
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
    view_label: "Pageview details"
    label: "Platform (Web/App)"
  }

  dimension: price_type {
    type: string
    sql: ${TABLE}.priceType ;;
    hidden: yes
  }

  dimension: purchase_status {
    type: string
    sql: ${TABLE}.purchaseStatus ;;
    hidden: yes
  }

  dimension: release_or_sold_date {
    type: string
    sql: ${TABLE}.releaseOrSoldDate ;;
    hidden: yes
  }

  dimension: search_term {
    type: string
    sql: ${TABLE}.searchTerm ;;
    hidden: yes
  }

  dimension: shipping_status {
    type: string
    sql: ${TABLE}.shippingStatus ;;
    hidden: yes
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.userId ;;
    view_label: "User details"
    label: ".User ID"
  }

  dimension: view_mode {
    type: string
    sql: ${TABLE}.viewMode ;;
    hidden: yes
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
    hidden: yes
  }

  dimension: web_page_path {
    type: string
    sql: ${TABLE}.webPagePath ;;
    hidden: yes
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
    view_label: "Date details"
    label: "Time of Pageview"
  }


  dimension: sessionid {
      type: string
      # sql: ${full_visitor_id}||${visit_id}||${hit_date};;
      sql: CONCAT(${full_visitor_id},CAST(${visit_id} AS STRING),CAST(${ga_date} AS STRING));;
      view_label: "Pageview details"
      group_label: "Other"
  }

  dimension: pageview_id {
    type: string
    sql: CONCAT(${sessionid}, "-", CAST(${hit_number} AS STRING)) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: isPDP {
    type: yesno
    sql:  ${pageType} = 'Products' or REGEXP_CONTAINS(${web_page_path}, '/vpv/pdp');;
    view_label: "Pageview details"
    group_label: "PDP"
  }

  dimension: is_searchbrowse{
    type: yesno
    description: "Looker is reporting lower numbers than GA - needs further review"
    sql:${pageSubType} IN ("Search", "Browse") or  REGEXP_CONTAINS(${web_page_path}, '/(search|furniture|art|fashion|jewelry|creators|dealers|collections|locations|sale|contemporary|associations|recognized|shopping-with|buy|(vpv/designers/.+/collections))') AND not REGEXP_CONTAINS(${web_page_path}, '/vpv/pdp');;
    view_label: "Pageview details"
    group_label: "Search/Browse"
  }

  dimension: pageType {
    type: string
    sql: ${TABLE}.contentGroup1 ;;
    label: "Page Type"
    group_label: "Content Grouping"
    view_label: "Pageview details"
  }

  dimension: pageSubType {
    type: string
    sql: ${TABLE}.contentGroup2 ;;
    label: "Page SubType"
    group_label: "Content Grouping"
    view_label: "Pageview details"
  }

  measure: total_pageviews {
    type: count_distinct
    sql: ${pageview_id} ;;
    view_label: "Pageview details"
    group_label: "Pageview metrics"
  }


  measure: pdp_pageviews {
    type: number
    sql: SUM(IF(${isPDP}, 1, 0)) ;;
    view_label: "Pageview details"
    group_label: "Pageview metrics"
    label: "Total PDP Pageviews"
  }

  measure: search_browse_pageviews {
    type: number
    sql: SUM(IF(${is_searchbrowse}, 1, 0)) ;;
    view_label: "Pageview details"
    group_label: "Pageview metrics"
    label: "Total S/B Pageviews"
  }

  measure: searchbrowse_sessions{
    type: count_distinct
    sql: ${sessionid} ;;
    view_label: "Pageview details"
    group_label: "Pageview metrics"
    filters: {
      field: is_searchbrowse
      value: "Yes"
    }
    filters: {
      field: isPDP
      value: "No"
    }
  }




}
