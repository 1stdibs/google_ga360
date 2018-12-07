view: ga_sessions_full {
  sql_table_name:
   `api-project-1065928543184.96922533.ga_sessions_20*`    ;;
## Add the 20 to avoid including intraday tables
#{% parameter ga_year %}
#   # added time partitioned filter



#### Session Level Information

    dimension: _table_suffix {
      type: string
      sql: ${TABLE}._TABLE_SUFFIX ;;
      hidden: yes
      # Useful for testing
    }

    dimension_group: partition_date {
      type: time
      sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d')))  ;;
      timeframes: [time, date, week, month]
      view_label: "Session Details"
      hidden: yes
      ## Note: This is less performant than concat alternative (scanning less tables to begin with"
      ## Note 2: This method can be used, after the year 2100, but by then...... ^_^"
    }


    dimension_group: date_suffix {
      type: time
      sql:
          TIMESTAMP(PARSE_DATE('%Y%m%d',CONCAT('20',${TABLE}._TABLE_SUFFIX))) ;;
      label: ".Session"
      timeframes: [time, date, week, quarter, month]
      description: "Date of the session - used to scan tables and return only specific partitioned tables"
      view_label: "Session Details"
    }


  dimension: visitStartSeconds {
    label: "Visit Start Seconds"
    type: number
    sql: ${TABLE}.visitStarttime ;;
    hidden: yes
  }


  dimension: sessionid {
    primary_key: yes
    type: string
    sql:concat(${date}, "|", cast(${visit_id} AS string),"|", ${full_visitor_id}) ;;
    description: "Specific identifier for session, unique per user/device."
    group_label: "Session Identifiers"
    view_label: "Session Details"
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
    hidden: yes
  }

  dimension_group: time_of_session {
    type: time
    timeframes: [time, time_of_day]
    sql: cast(PARSE_DATE('%Y%m%d', ${date}) as TIMESTAMP) ;;
    view_label: "Session Details"
  }


  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
    group_label: "Session Identifiers"
    view_label: "Session Details"
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
    group_label: "Session Identifiers"
    view_label: "Session Details"
  }

  dimension: visitnumber {
    type: number
    sql: ${TABLE}.visitNumber ;;
    view_label: "Session Details"
    group_label: "Session Attributes"
    label: "User Session Number"
    description: "The session number for this user. If this is the first session, then this is set to 1."
  }

  dimension:  first_time_visitor {
    type: yesno
    sql: ${visitnumber} = 1 ;;
    view_label: "Session Details"
    group_label: "Visitor Attributes"
    description: "Is this the first session of the visitor?"
  }

  dimension: repeat_visitor {
    type: yesno
    sql: ${visitnumber} > 1 ;;
    view_label: "Session Details"
    group_label: "Visitor Attributes"
  }

  dimension: visitor_type_new_vs_repeat {
    type: string
    sql: if(${first_time_visitor}, "New", "Repeat") ;;
    view_label: "Session Details"
    group_label: "Visitor Attributes"
    label: "Session Visitor Type (New/Repeat)"
  }

  dimension: visitnumbertier {
    type: tier
    sql: ${visitnumber} ;;
    tiers: [1,2,5,10,15,20,50,100]
    style: integer
    view_label: "Session Details"
    group_label: "Visitor Attributes"
    label: "Visit Number Tier"
    description: "User visit number tiered as follows : (1, 2, 3-4, 5-9, 10-14, 15-19, 20-49, 50-99, 100+"
  }


  dimension: session_start_time {
    type: date_time
    sql: TIMESTAMP_SECONDS(${TABLE}.visitStartTime) ;;
    view_label: "Session Details"
    hidden: yes
  }

  dimension: channel_grouping {
    type: string
    sql: ${TABLE}.channelGrouping ;;
    view_label: "Session Details"
    group_label: "Acquisition"
  }




    ####### Access Totals Record #################


    dimension: session_quality {
      type: number
      sql: ${TABLE}.totals.sessionQualityDim ;;
      view_label: "Session Details"
      group_label: "Session Attributes"
    }

    dimension: time_on_site {
      type: number
      sql: ${TABLE}.totals.timeOnSite ;;
      view_label: "Session Details"
      hidden: yes
    }



    dimension: timeonsite_tier {
      label: "Time On Site Tier"
      type: tier
      sql: ${TABLE}.totals.timeonsite ;;
      tiers: [0,15,30,60,120,180,240,300,600]
      style: integer
      view_label: "Session Details"
      group_label: "Session Attributes"
    }

    measure: total_hits {
      type: sum
      sql: ${TABLE}.totals.hits ;;
      view_label: "Session Details"
      hidden: yes
    }


    measure: timeonsite_average_per_session {
      type: average
      sql: 1.0 * ${time_on_site} ;;
      view_label: "Session Details"
      hidden: yes
    }

    measure: pageviews_total {
      label: "Total Page Views in Session"
      type: sum
      sql: ${TABLE}.totals.pageviews ;;
      sql_distinct_key: ${sessionid} ;;
      view_label: "Session Details"
      group_label: "Session Totals"
    }

    measure: page_views_per_session {
      label: "PageViews Per Session"
      type: number
      sql: 1.0 * ${pageviews_total} / NULLIF(${sessions},0) ;;
      value_format_name: decimal_2
      view_label: "Session Details"
      group_label: "Session Totals"
    }

    measure: transactions_count {
      type: sum
      sql: ${TABLE}.totals.transactions ;;
      view_label: "Session Details"
      group_label: "Session Totals"
    }

    measure: screenViews_total {
      label: "Screen Views Total"
      type: sum
      sql: ${TABLE}.totals.screenViews ;;
      view_label: "Session Details"
      group_label: "App Session Totals"
    }

    measure: timeOnScreen_total{
      label: "Time On Screen Total"
      type: sum
      sql: ${TABLE}.totals.timeOnScreen ;;
      view_label: "Session Details"
      group_label: "App Session Totals"
    }


    measure: bounces_total {
      type: sum
      sql: ${TABLE}.totals.bounces ;;
      view_label: "Session Details"
      group_label: "Session Totals"
    }

    measure: bounce_rate {
      type:  number
      sql: 1.0 * ${bounces_total} / NULLIF(${sessions},0) ;;
      value_format_name: percent_2
      view_label: "Session Details"
      group_label: "Session Totals"

    }



  ####### Access Traffic Source Record #################


  dimension: session_source {
    type: string
    sql: ${TABLE}.trafficSource.source ;;
    view_label: "Session Details"
    group_label: "Acquisition"
  }

  dimension: session_medium {
    type: string
    sql: ${TABLE}.trafficSource.medium ;;
    view_label: "Session Details"
    group_label: "Acquisition"
  }

  dimension: session_campaign {
    type: string
    sql: ${TABLE}.trafficSource.campaign ;;
    view_label: "Session Details"
    group_label: "Acquisition"
  }

  dimension: session_keyword {
    type: string
    sql: ${TABLE}.trafficSource.keyword ;;
    view_label: "Session Details"
    group_label: "Acquisition"
  }


  ####### Access Device Record #################


  dimension: device_browser {
    type: string
    sql: ${TABLE}.device.browser ;;
    view_label: "Session Details"
    group_label: "Device Details"
  }

  dimension: device_operating_system {
    type: string
    sql: ${TABLE}.device.operatingSystem ;;
    view_label: "Session Details"
    group_label: "Device Details"
  }

  dimension: device_is_mobile {
    type: yesno
    sql: ${TABLE}.device.isMobile ;;
    view_label: "Session Details"
    group_label: "Device Details"
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.device.deviceCategory ;;
    view_label: "Session Details"
    group_label: "Device Details"
  }



  ####### Access GeoNetwork Record #################


  dimension: session_continent {
    type: string
    sql: ${TABLE}.geoNetwork.continent ;;
    view_label: "Session Details"
    group_label: "Geography Details"
  }

  dimension: session_country {
    type: string
    sql: ${TABLE}.geoNetwork.country ;;
    view_label: "Session Details"
    group_label: "Geography Details"
  }


  dimension: session_region {
    type: string
    sql: ${TABLE}.geoNetwork.region ;;
    view_label: "Session Details"
    group_label: "Geography Details"
  }


  dimension: session_city {
    type: string
    sql: ${TABLE}.geoNetwork.city ;;
    view_label: "Session Details"
    group_label: "Geography Details"
  }


  dimension: session_location {
    type: location
    sql_latitude: cast(${TABLE}.geoNetwork.latitude as float64) ;;
    sql_longitude: cast(${TABLE}.geoNetwork.longitude as float64) ;;
    view_label: "Session Details"
    group_label: "Geography Details"
  }


  ######################## Other
    parameter: ga_year {
      type: unquoted
      allowed_value: {
        label: "2018"
        value: "2018"
      }
      allowed_value: {
        label: "2017"
        value: "2017"
      }
      allowed_value: {
        label: "2016"
        value: "2016"

      }
      allowed_value: {
        label: "2015"
        value: "2015"
      }
      allowed_value: {
        label: "2014"
        value: "2014"
      }

      allowed_value: {
        label: "2013"
        value: "2013"
      }
      default_value: "2018"
      hidden: yes
    }





### Nested Records ##########


    dimension: hits {
      sql: ${TABLE}.hits ;;
      hidden: yes
    }

    dimension: totals {
      sql: ${TABLE}.totals ;;
      hidden: yes
    }

    dimension: customDimensions {
      sql: ${TABLE}.customDimensions ;;
      hidden: yes
    }

  dimension: device {
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: geo_network {
    hidden: yes
    sql: ${TABLE}.geoNetwork ;;
  }


  dimension: traffic_source {
    hidden: yes
    sql: ${TABLE}.trafficSource ;;
    view_label: "Acquisition details"
    label: "Session Source"
  }

################



  measure: unique_visitors {
    type: count_distinct
    sql: ${full_visitor_id}  ;;
    view_label: "Session Details"
    group_label: "Visitor Details"
    label: "Total Unique Visitors"
  }



  measure: sessions {
    type: sum
    sql: ${TABLE}.totals.visits ;;
    sql_distinct_key: ${sessionid} ;;
    view_label: "Session Details"
    label: "Count of Interaction Sessions"
    description: "A session with an interaction event, as seen on the ga platform"
    group_label: "Session Totals"
  }


  measure: total_sessions_incl_non_interaction {
    type: count_distinct
    sql: ${sessionid};;
    sql_distinct_key: ${sessionid} ;;
    view_label: "Session Details"
    label: "Count of Total Sessions"
    description: "A count of sessions with or without an interaction event"
    group_label: "Session Totals"
  }


    measure: average_sessions_per_visitor {
      type: number
      sql: 1.0 * (${sessions}/NULLIF(${unique_visitors},0))  ;;
      value_format_name: decimal_2
      drill_fields: [full_visitor_id, visitnumber, sessions]
      view_label: "Session Details"
      group_label: "Session Totals"
    }

    measure: first_time_visitors {
      label: "Count of First Time Visitors with a Session"
      view_label: "Session Details"
      group_label: "Visitor Details"
      type: count_distinct
      sql: ${sessionid} ;;
      filters: {
        field: visitnumber
        value: "1"
      }
    }

    measure: second_time_visitors {
      label: "Count of Visitors with their Second Session"
      type: count_distinct
      view_label: "Session Details"
      group_label: "Visitor Details"
      sql: ${sessionid} ;;
      filters: {
        field: visitnumber
        value: "2"
      }
    }


    measure: returning_visitors {
      label: "Session Count by Returning Visitors"
      type: count_distinct
      sql: ${sessionid} ;;
      view_label: "Session Details"
      group_label: "Visitor Details"
      filters: {
        field: visitnumber
        value: "<> 1"
      }
    }
}

######################## SUB-VIEW: USER/SESSION SCOPED CUSTOM DIMENSIONS ######################

# TYPE: STRUCT (2-level ARRAY)
  view: customDimensions {


    dimension: index {
      hidden: yes
      type: number
      sql: ${TABLE}.index ;;
    }


    dimension: value {
      hidden: yes
      type: string
      sql: ${TABLE}.value ;;
    }

    dimension: primary {
      hidden: yes
      primary_key: yes
      type: string
      sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
    }

    ## User Scoped Custom Dimensions ##

    dimension: buyer_status {
      type: string
      view_label: "User Session details"
      label: "Session Buyer Status"
      sql:
        (SELECT lower(value)
        FROM
          ${ga_sessions_full.customDimensions} AS temp
        WHERE index = 24
        )
      ;;
      }

    dimension: customer_type {
      type: string
      view_label: "User Session details"
      label: "Session Customer Type"
      sql:
        (SELECT lower(value)
        FROM
          ${ga_sessions_full.customDimensions} AS temp
        WHERE index = 34
        )
      ;;
    }

    dimension: customer_type_trade_vs_other {
      type: string
      view_label: "User Session details"
      label: "Session Customer Type (Trade vs. Consumer)"
      sql: case when ${customer_type} in ('trade', 'trade and vip') then 'Trade'
            else 'Consumer'
            end;;
    }

    dimension: user_id {
      type: number
      sql:
      (SELECT value
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 33
      );;
      view_label: "User Session details"
      label: ".User ID"
    }

    dimension: guest_id {
      type: string
      sql:
      (SELECT value
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 32
        );;
      view_label: "User Session details"
      label: ".Guest ID"
    }

    dimension: session_registration_status {
      type: string
      sql:
      (SELECT lower(value)
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 30
        );;
      view_label: "User Session details"
    }

    dimension: trade_firm_id {
      type: number
      sql:
      (SELECT value
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 82
        );;
      view_label: "User Session details"
      label: ".User Trade Firm ID"
    }


    dimension: session_login_status {
      type: string
      sql:
      (SELECT lower(value)
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 29
        );;
      view_label: "User Session details"
    }



    dimension: session_trade_status {
      type: string
      sql:
      (SELECT lower(value)
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 6
        );;
      view_label: "User Session details"
    }


    dimension: cdn_slot_1 {
      type: string
      sql:
      (SELECT lower(value)
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 62
        );;
      view_label: "User Session details"
      group_label: "CDN Slots"
    }

    dimension: cdn_slot_2 {
      type: string
      sql:
      (SELECT lower(value)
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 63
        );;
      view_label: "User Session details"
      group_label: "CDN Slots"
    }

    dimension: cdn_slot_3 {
      type: string
      sql:
      (SELECT lower(value)
      FROM
        ${ga_sessions_full.customDimensions} AS temp
      WHERE index = 53
        );;
      view_label: "User Session details"
      group_label: "CDN Slots"
    }

  }





# SUB-VIEW: HITS ########
# TYPE: STRUC (2-level ARRAY)
  view: hits {
    dimension: primary {
      hidden: yes
      primary_key: yes
      type: string
      sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
    }

    dimension_group: hit {
      timeframes: [time, date,day_of_week,fiscal_quarter,week,month,year,month_name,month_num,week_of_year]
      type: time
      sql: TIMESTAMP_MILLIS(${ga_sessions_full.visitStartSeconds}*1000 + ${TABLE}.time) ;;
      hidden: yes
    }




    dimension: type {
      type: string
      sql: ${TABLE}.type ;;
      hidden: yes
    }

    dimension: app_info {
      hidden: yes
      sql: ${TABLE}.appInfo ;;
    }

    dimension: hit_number {
      type: number
      sql: ${TABLE}.hitNumber ;;
      hidden: yes
    }

    dimension: host {
      type: string
      sql: ${TABLE}.page.hostname ;;
      view_label: "Page Level Details"
      ## Needs further evaluation - how does this work with events? how does it work with sessions?
    }

    dimension: page_path {
      type: string
      hidden: yes
      sql: if(${TABLE}.page.pagePath is not null, ${TABLE}.page.pagePath, ${TABLE}.appInfo.screenName) ;;
    }

    measure: web_pageviews {
      type: sum
      sql:
      if(${TABLE}.page.pagePath != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "Web Metrics"
      filters: {
        field: type
        value: "PAGE"
      }
    }

    measure: web_pdp_pageviews {
      type: sum
      sql:
      if(${TABLE}.page.pagePath != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "Web Metrics"
      label: "Web PDP Pageviews"
      filters: {
        field: type
        value: "PAGE"
      }
      filters: {
        field: pageType
        value: "Products"
      }
    }

    measure: web_results_pageviews {
      type: sum
      sql:
      if(${TABLE}.page.pagePath != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "Web Metrics"
      filters: {
        field: type
        value: "PAGE"
      }
      filters: {
        field: pageType
        value: "Results"
      }
    }

    measure: app_pageviews {
      type: sum
      sql:
      if(${TABLE}.appInfo.screenName != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "App Metrics"
      filters: {
        field: type
        value: "APP"
      }
    }

    measure: app_results_pageviews {
      type: sum
      sql:
      if(${TABLE}.appInfo.screenName != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "App Metrics"
      filters: {
        field: type
        value: "APP"
      }
      filters: {
        field: pageType
        value: "Results"
      }
    }

    measure: app_pdp_pageviews {
      type: sum
      sql:
      if(${TABLE}.appInfo.screenName != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "App Metrics"
      label: "App PDP Pageviews"
      filters: {
        field: type
        value: "APP"
      }
      filters: {
        field: pageType
        value: "Products"
      }
    }


    ########### Page Level Dimensions

    dimension: pageType {
      type: string
      sql: ${TABLE}.contentGroup.contentGroup1 ;;
      view_label: "Page Level Details"
      group_label: "Content Grouping"
      description: "Content grouping of pages : (Products, Results, Home, Other)"
      label: "Page Type"
    }

    dimension: pageSubType {
      type: string
      sql: ${TABLE}.contentGroup.contentGroup2 ;;
      view_label: "Page Level Details"
      group_label: "Content Grouping"
      description: "Content sub-grouping of pages : (PDP-Available, Search, Browse, Checkout, etc.)"
      label: "Page Sub Type"
    }

    dimension: pageSection {
      type: string
      sql: ${TABLE}.contentGroup.contentGroup3 ;;
      view_label: "Page Level Details"
      group_label: "Content Grouping"
      label: "Page Section"
    }


    ########### Custom Event Level Dimensions

    dimension: eventCategory {
      type: string
      sql: ${TABLE}.eventInfo.eventCategory ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Details"
      label: "Event Category"
      hidden: yes
    }

    dimension: eventAction {
      type: string
      sql: ${TABLE}.eventInfo.eventAction ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Details"
      label: "Event Action"
      hidden: yes
    }

    dimension: eventLabel {
      type: string
      sql: ${TABLE}.eventInfo.eventLabel ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Details"
      label: "Event Label"
      hidden: yes
    }

    measure: count_of_events {
      type: sum
      sql: if(${TABLE}.eventInfo.eventCategory != '', 1, 0) ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Metrics"
      filters: {
        field: type
        value: "EVENT"
      }

    }

    measure: count_of_purchase_clicks{
      type: sum
      sql: if(${TABLE}.eventInfo.eventCategory != '', 1, 0) ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Metrics"
      filters: {
        field: type
        value: "EVENT"
      }
      filters: {
        field: eventCategory
        value: "purchase click"
      }

    }

    measure: count_of_make_offer_clicks{
      type: sum
      sql: if(${TABLE}.eventInfo.eventCategory != '', 1, 0) ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Metrics"
      filters: {
        field: type
        value: "EVENT"
      }
      filters: {
        field: eventCategory
        value: "make offer click"
      }

    }

    measure: count_of_contact_dealer_clicks{
      type: sum
      sql: if(${TABLE}.eventInfo.eventCategory != '', 1, 0) ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Metrics"
      filters: {
        field: type
        value: "EVENT"
      }
      filters: {
        field: eventCategory
        value: "contact dealer"
      }
      filters: {
        field: eventCategory
        value: "contact dealer clicked"
      }
    }

    measure: count_of_contact_dealer_submits {
      type: sum
      sql: if(${TABLE}.eventInfo.eventCategory != '', 1, 0) ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Metrics"
      filters: {
        field: type
        value: "EVENT"
      }
      filters: {
        field: eventCategory
        value: "contact dealer"
      }
      filters: {
        field: eventCategory
        value: "contact dealer submitted"
      }
    }


### Social Network

dimension: social_network {
  type: string
  sql: ${TABLE}.social.socialNetwork ;;
  group_label: "Social Attributes"
  view_label: "Session Details"
}


#### Ecommerce

dimension: ecom_action_type {
  type: string
  sql: case cast(${TABLE}.eCommerceAction.action_type as string)
        when '1' then 'Product List Click'
        when '2' then 'Product Detail View'
        when '3' then 'Add to Cart'
        when '4' then 'Remove from Cart'
        when '5' then 'Checkout'
        when '6' then 'Order Submitted'
        when '7' then 'Refund'
        else 'Unknown'
        end ;;
  view_label: "Ecommerce Details"


}


dimension: found_on_search_page {
  type: yesno
  sql: ${ecom_action_type} = 'Product List Click'
      and ${pageType} = 'Results';;
    hidden: yes
}


  }
