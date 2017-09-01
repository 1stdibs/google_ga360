view: ga_sessions_full {
  sql_table_name: `api-project-1065928543184.96922533.ga_sessions*`
    ;;

  dimension: primary {
    primary_key: yes
    type: string
    sql: concat(${date}, cast(${visit_id} AS string), ${full_visitor_id}) ;;
  }

  dimension: channel_grouping {
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }

  dimension: custom_dimensions {
    hidden: yes
    sql: ${TABLE}.customDimensions ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: device {
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: geo_network {
    hidden: yes
    sql: ${TABLE}.geoNetwork ;;
  }

  dimension: hits {
    hidden: yes
    sql: ${TABLE}.hits ;;
  }

  dimension: social_engagement_type {
    type: string
    sql: ${TABLE}.socialEngagementType ;;
  }

  dimension: totals {
    hidden: yes
    sql: ${TABLE}.totals ;;
  }

  dimension: traffic_source {
    hidden: yes
    sql: ${TABLE}.trafficSource ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.userId ;;
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
  }

  dimension: visit_number {
    type: number
    sql: ${TABLE}.visitNumber ;;
  }

  dimension: visit_start_time {
    type: number
    sql: ${TABLE}.visitStartTime ;;
  }

  dimension: visitor_id {
    type: number
    sql: ${TABLE}.visitorId ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: ga_sessions_full__custom_dimensions {
  # Edited custom dimensions ###############

  ### user id
  dimension: user_id {
    type: number
    sql: IF(${TABLE}.index = 33, ${TABLE}.value, NULL) ;;
  }

  ### guest id
  dimension: guest_id {
    type: string
    sql: IF(${TABLE}.index = 32, ${TABLE}.value, NULL) ;;
  }

  ### login status
  dimension: login_status{
    type: string
    sql: IF(${TABLE}.index = 29, ${TABLE}.value, NULL);;
  }

  ### registration status
  dimension: registration_status {
    type: string
    sql: IF(${TABLE}.index = 30, ${TABLE}.value, NULL) ;;
  }

  ### customer type
  dimension: customer_type {
    type: string
    sql: IF(${TABLE}.index = 34, ${TABLE}.value, NULL) ;;
  }

  ### buyer status
  dimension: buyer_status {
    type: string
    sql: IF(${TABLE}.index = 24, ${TABLE}.value, NULL) ;;
  }

  ### trade status
  dimension: trade_status {
    type: string
    sql: IF(${TABLE}.index = 6, ${TABLE}.value, NULL) ;;
  }

  ### default currency
  dimension: default_currency {
    type: string
    sql: IF(${TABLE}.index = 23, ${TABLE}.value, NULL) ;;
  }


  ##########################################

  #dimension: index {
  #  type: number
  #  sql: ${TABLE}.index ;;
  #}

  #dimension: value {
  #  type: string
  #  sql: ${TABLE}.value ;;
  #}

}

view: ga_sessions_full__totals {
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
    sql: ${TABLE}.totalTransactionRevenue ;;
  }

  dimension: transaction_revenue {
    type: number
    sql: ${TABLE}.transactionRevenue ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }

  measure: transactions_measure {
    type: sum
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
}

view: ga_sessions_full__geo_network {
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

view: ga_sessions_full__traffic_source {
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

view: ga_sessions_full__device {
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

  dimension: is_mobile {
    type: yesno
    sql: ${TABLE}.isMobile ;;
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
