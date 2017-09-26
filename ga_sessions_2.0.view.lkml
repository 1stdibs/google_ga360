view: ga_sessions_full {
  sql_table_name: `api-project-1065928543184.96922533.ga_sessions*`
    ;;

  dimension: primary {
    primary_key: yes
    type: string
    sql:concat(${date}, cast(${visit_id} AS string), ${full_visitor_id}) ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension_group: sessions_date {
    type: time
    timeframes: [date, week, month]
    sql: cast(PARSE_DATE('%Y%m%d', ${date}) as TIMESTAMP) ;;
  }


  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
  }

  measure: total_user_count {
    type: count_distinct
    sql: ${full_visitor_id}  ;;
  }

  dimension: visit_number {
    type: number
    sql: ${TABLE}.visitNumber ;;
  }

  dimension: session_start_time {
    type: date_time
    sql: TIMESTAMP_SECONDS(${TABLE}.visitStartTime) ;;
  }

  dimension: channel_grouping {
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }

  dimension: totals {
    hidden: yes
    sql: ${TABLE}.totals ;;
  }

  dimension: custom_dimensions {
    hidden: yes
    sql: ${TABLE}.customDimensions ;;
  }

  dimension: device {
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: geo_network {
    hidden: yes
    sql: ${TABLE}.geoNetwork ;;
  }

  dimension: hits {
    hidden: yes
    sql: ${TABLE}.hits ;;
  }

  dimension: traffic_source {
    hidden: yes
    sql: ${TABLE}.trafficSource ;;
  }

#  dimension: social_engagement_type {
#    type: string
#    sql: ${TABLE}.socialEngagementType ;;
#  }

#  dimension: user_id {
#    type: string
#    sql: ${TABLE}.userId ;;
#  }


#   dimension: user_id {
#     type: string
#     sql:
#       (SELECT
#         MAX(IF(${ga_sessions_full.custom_dimensions}.index = 33,
#               ${ga_sessions_full.custom_dimensions}.value,
#               NULL)) AS user_id_temp
#       FROM
#         UNNEST(${TABLE}.customDimensions));;
#   }
#
# #  dimension: guest_id {
# #    type: string
# #    sql:
# #      (SELECT
# #        MAX(IF(${TABLE}.index = 32, ${TABLE}.value, NULL)) AS guest_id_temp
# #      FROM
# #        UNNEST(${ga_sessions_full.custom_dimensions})) ;;
# #  }
#
# #  dimension: login_status {
# #    type: string
# #    sql:
# #      (SELECT
# #        MAX(IF(${TABLE}.index = 29, ${TABLE}.value, NULL)) AS login_status_temp
# #      FROM
# #        UNNEST(${ga_sessions_full.custom_dimensions}));;
# #  }

}

# SUB-VIEW: CUSTOM DIMENSIONS ########
# TYPE: STRUC (2-level ARRAY)
view: ga_sessions_full__custom_dimensions {

  # hide this variable in the explore
  dimension: index {
    hidden: yes
    type: number
    sql: ${TABLE}.index ;;
  }

  # hide this variable in the explore
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

  dimension: user_id {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 33, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: guest_id {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 32, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: login_status {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 29, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: registration_status {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 30, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: customer_type {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 34, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: buyer_status {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 24, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: trade_status {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 6, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

  dimension: default_currency {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 23, temp.value, NULL))
      FROM
        UNNEST(${ga_sessions_full.custom_dimensions}) AS temp);;
  }

}

# SUB-VIEW: HITS ########
# TYPE: STRUC (2-level ARRAY)
view: ga_sessions_full__hits {
  dimension: primary {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
  }

  dimension: app_info {
    hidden: yes
    sql: ${TABLE}.appInfo ;;
  }

  # build measure to count how many Events
  # @Vicky: what is the difference between Events and hits
  dimension: events {
    type: number
    sql: (
    SELECT SUM(IF(temp.type = "EVENT", 1, 0))
    FROM
        UNNEST(${ga_sessions_full.hits}) AS temp
      ) ;;
  }

  # dimension: events {
  #   type: number
  #   sql: SUM(IF(${TABLE}.type = "EVENT", 1, 0)) ;;
  # }

  # ADDED MESAURE: count total number of transactions ########
  measure: total_events_count {
    type: sum
    sql: ${events} ;;
  }

  # dimension: is_exit {
  #   type: yesno
  #   sql: ${TABLE}.isExit ;;
  # }

  # dimension: is_entrance {
  #   type: yesno
  #   sql: ${TABLE}.isEntrance ;;
  # }
}

# SUB-VIEW: TOTALS ########
# TYPE: ARRAY
view: ga_sessions_full__totals {

  dimension: primary {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: hits {
    type: number
    sql: ${TABLE}.hits ;;
  }

  dimension: new_visits {
    type: number
    sql: ${TABLE}.newVisits ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: screenviews {
    type: number
    sql: ${TABLE}.screenviews ;;
  }

  dimension: pageviews_and_screenviews {
    type: number
    sql: case when ${pageviews} is null then ${screenviews}
          else ${pageviews} end;;
  }

  dimension: time_on_screen {
    type: number
    sql: ${TABLE}.timeOnScreen ;;
  }

  dimension: time_on_site {
    type: number
    sql: ${TABLE}.timeOnSite ;;
  }

  dimension: total_transaction_revenue {
    type: number
    sql: ROUND(${TABLE}.totalTransactionRevenue/1000000, 3) ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }

  dimension: unique_screenviews {
    type: number
    sql: ${TABLE}.uniqueScreenviews ;;
  }

  dimension: visits {
    type: number
    sql: ${TABLE}.visits ;;
  }

  # ADDED MEASURE: count total number of pageviews and screenviews ########
  measure: total_pageviews_and_screenviews_count {
    type: sum
    sql:  ${pageviews_and_screenviews};;
  }

  # ADDED MESAURE: count total number of transactions ########
  measure: total_transactions_count {
    type: sum
    sql: ${transactions} ;;
  }

  # ADDED MEASURE: count total number of bounced sessions ########
  measure: total_bounced_sessions_count {
    type: sum
    sql: ${bounces} ;;
  }

  # ADDED MESAURE: count total number of (valid) sessions ########
  measure: total_sessions_count {
    type: sum
    sql: ${visits} ;;
  }

  # ADDED MEASURE: the total value of transaction revenue  ########
  measure: total_gmv {
    type: sum
    sql: ROUND(${total_transaction_revenue}, 3) ;;
  }
}

# SUB-VIEW: GEO NETWORK ########
# TYPE: ARRAY
view: ga_sessions_full__geo_network {

  dimension: primary {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: city_id {
    type: string
    sql: ${TABLE}.cityId ;;
  }

  dimension: continent {
    type: string
    sql: ${TABLE}.continent ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: latitude {
    type: string
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: string
    sql: ${TABLE}.longitude ;;
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.metro ;;
  }

  dimension: network_domain {
    type: string
    sql: ${TABLE}.networkDomain ;;
  }

  dimension: network_location {
    type: string
    sql: ${TABLE}.networkLocation ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: sub_continent {
    type: string
    sql: ${TABLE}.subContinent ;;
  }
}

# SUB-VIEW: TRAFFIC SOURCE ########
# TYPE: ARRAY
view: ga_sessions_full__traffic_source {

  dimension: primary {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
  }

  dimension: ad_content {
    type: string
    sql: ${TABLE}.adContent ;;
  }

  dimension: adwords_click_info {
    hidden: yes
    sql: ${TABLE}.adwordsClickInfo ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_code {
    type: string
    sql: ${TABLE}.campaignCode ;;
  }

  dimension: is_true_direct {
    type: yesno
    sql: ${TABLE}.isTrueDirect ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: referral_path {
    type: string
    sql: ${TABLE}.referralPath ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }
}

# SUB-VIEW: DEVICE ########
# TYPE: ARRAY
view: ga_sessions_full__device {

  dimension: primary {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${ga_sessions_full.date},
        cast(${ga_sessions_full.visit_id} AS string),
        ${ga_sessions_full.full_visitor_id}) ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: browser_size {
    type: string
    sql: ${TABLE}.browserSize ;;
  }

  dimension: browser_version {
    type: string
    sql: ${TABLE}.browserVersion ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: flash_version {
    type: string
    sql: ${TABLE}.flashVersion ;;
  }

  dimension: java_enabled {
    type: yesno
    sql: ${TABLE}.javaEnabled ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: mobile_device_branding {
    type: string
    sql: ${TABLE}.mobileDeviceBranding ;;
  }

  dimension: mobile_device_info {
    type: string
    sql: ${TABLE}.mobileDeviceInfo ;;
  }

  dimension: mobile_device_marketing_name {
    type: string
    sql: ${TABLE}.mobileDeviceMarketingName ;;
  }

  dimension: mobile_device_model {
    type: string
    sql: ${TABLE}.mobileDeviceModel ;;
  }

  dimension: mobile_input_selector {
    type: string
    sql: ${TABLE}.mobileInputSelector ;;
  }

  dimension: operating_system {
    type: string
    sql: ${TABLE}.operatingSystem ;;
  }

  dimension: operating_system_version {
    type: string
    sql: ${TABLE}.operatingSystemVersion ;;
  }

  dimension: screen_colors {
    type: string
    sql: ${TABLE}.screenColors ;;
  }

  dimension: screen_resolution {
    type: string
    sql: ${TABLE}.screenResolution ;;
  }
}
