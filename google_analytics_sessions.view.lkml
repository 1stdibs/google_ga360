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


    dimension: date_suffix {
      type: date_time
      sql:
          TIMESTAMP(PARSE_DATE('%Y%m%d',CONCAT('20',${TABLE}._TABLE_SUFFIX))) ;;
      label: ".Day of Session"
      description: "Date of the session - used to scan tables and return only specific partitioned tables"
      view_label: "Session Details"
    }


  dimension: sessionid {
    primary_key: yes
    type: string
    sql:concat(${date}, cast(${visit_id} AS string), ${full_visitor_id}) ;;
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


  dimension: session_start_time {
    type: date_time
    sql: TIMESTAMP_SECONDS(${TABLE}.visitStartTime) ;;
    view_label: "Session Details"
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
      sql: ${TABLE}.totals.timeOnSite + ${TABLE}.totals.timeOnScreen ;;
      view_label: "Session Details"
      hidden: yes
    }

    dimension: visitnumber {
      type: number
      sql: ${TABLE}.visitNumber ;;
      view_label: "Session Details"
      group_label: "Visitor Details"
      label: "Session Identifiers"
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



#
#   dimension_group: ga_date {
#     type: time
#     timeframes: [date,week,month,year]
# #     sql: _PARTITIONTIME ;;
#     # NOTE: for manually partitioned files use code below
#     sql:  {% time_dimension.date_granularity._parameter_value %}
#  ;;
#
#   }


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
      label: "Count of Sessions"
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
      label: "Session Count by First Time Visitors"
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
      label: "Session Count by Second Time Visitors"
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

    dimension: user_id {
      type: string
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
      type: string
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



    dimension: type {
      type: string
      sql: ${TABLE}.type ;;
      hidden: yes
    }

    dimension: app_info {
      hidden: yes
      sql: ${TABLE}.appInfo ;;
    }

    measure: web_pageviews {
      type: sum
      sql:
      if(page.pagePath != '', 1, 0);;
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
      if(page.pagePath != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "Web Metrics"
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
      if(page.pagePath != '', 1, 0);;
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
      if(appInfo.screenName != '', 1, 0);;
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
      if(appInfo.screenName != '', 1, 0);;
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
      if(appInfo.screenName != '', 1, 0);;
      sql_distinct_key: ${primary} ;;
      view_label: "Page Level Details"
      group_label: "App Metrics"
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
      sql: contentGroup.contentGroup1 ;;
      view_label: "Page Level Details"
      group_label: "Content Grouping"
      description: "Content grouping of pages : (Products, Results, Home, Other)"
      label: "Page Type"
    }

    dimension: pageSubType {
      type: string
      sql: contentGroup.contentGroup2 ;;
      view_label: "Page Level Details"
      group_label: "Content Grouping"
      description: "Content sub-grouping of pages : (PDP-Available, Search, Browse, Checkout, etc.)"
      label: "Page Sub Type"
    }

    dimension: pageSection {
      type: string
      sql: contentGroup.contentGroup3 ;;
      view_label: "Page Level Details"
      group_label: "Content Grouping"
      label: "Page Section"
    }


    ########### Custom Event Level Dimensions

    dimension: eventCategory {
      type: string
      sql: eventInfo.eventCategory ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Details"
      label: "Event Category"
    }

    dimension: eventAction {
      type: string
      sql: eventInfo.eventAction ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Details"
      label: "Event Action"
    }

    dimension: eventLabel {
      type: string
      sql: eventInfo.eventLabel ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Details"
      label: "Event Label"
    }

    measure: count_of_events {
      type: sum
      sql: if(eventInfo.eventCategory != '', 1, 0) ;;
      view_label: "Custom Event Level Details"
      group_label: "Event Metrics"
      filters: {
        field: type
        value: "EVENT"
      }

    }

    measure: count_of_purchase_clicks{
      type: sum
      sql: if(eventInfo.eventCategory != '', 1, 0) ;;
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


  }
