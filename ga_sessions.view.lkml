view: ga_sessions {
  sql_table_name: google_analytics.sessions ;;

  dimension: ab_test_cdn_slot53 {
    type: string
    sql: ${TABLE}.abTestCdnSlot53 ;;
  }

  dimension: ab_test_cdn_slot54 {
    type: string
    sql: ${TABLE}.abTestCdnSlot54 ;;
  }

  dimension: ab_test_cdn_slot55 {
    type: string
    sql: ${TABLE}.abTestCdnSlot55 ;;
  }

  dimension: ab_test_cdn_slot56 {
    type: string
    sql: ${TABLE}.abTestCdnSlot56 ;;
  }

  dimension: ab_test_cdn_slot62 {
    type: string
    sql: ${TABLE}.abTestCdnSlot62 ;;
  }

  dimension: ab_test_cdn_slot63 {
    type: string
    sql: ${TABLE}.abTestCdnSlot63 ;;
  }

  dimension: ab_test_opt_slot36 {
    type: string
    sql: ${TABLE}.abTestOptSlot36 ;;
  }

  dimension: ab_test_opt_slot39 {
    type: string
    sql: ${TABLE}.abTestOptSlot39 ;;
  }

  dimension: ab_test_opt_slot40 {
    type: string
    sql: ${TABLE}.abTestOptSlot40 ;;
  }

  dimension: ab_test_opt_slot41 {
    type: string
    sql: ${TABLE}.abTestOptSlot41 ;;
  }

  dimension: ab_test_opt_slot42 {
    type: string
    sql: ${TABLE}.abTestOptSlot42 ;;
  }

  dimension: ab_test_opt_slot46 {
    type: string
    sql: ${TABLE}.abTestOptSlot46 ;;
  }

  dimension: ab_test_opt_slot47 {
    type: string
    sql: ${TABLE}.abTestOptSlot47 ;;
  }

  dimension: ab_test_opt_slot48 {
    type: string
    sql: ${TABLE}.abTestOptSlot48 ;;
  }

  dimension: ab_test_opt_slot49 {
    type: string
    sql: ${TABLE}.abTestOptSlot49 ;;
  }

  dimension: ab_test_opt_slot50 {
    type: string
    sql: ${TABLE}.abTestOptSlot50 ;;
  }

  dimension: ab_test_opt_slot51 {
    type: string
    sql: ${TABLE}.abTestOptSlot51 ;;
  }

  dimension: ab_test_opt_slot52 {
    type: string
    sql: ${TABLE}.abTestOptSlot52 ;;
  }

  dimension: ab_test_opt_slot57 {
    type: string
    sql: ${TABLE}.abTestOptSlot57 ;;
  }

  dimension: ab_test_opt_slot58 {
    type: string
    sql: ${TABLE}.abTestOptSlot58 ;;
  }

  dimension: ab_test_opt_slot59 {
    type: string
    sql: ${TABLE}.abTestOptSlot59 ;;
  }

  dimension: ab_test_opt_slot60 {
    type: string
    sql: ${TABLE}.abTestOptSlot60 ;;
  }

  dimension: ad_content {
    type: string
    sql: ${TABLE}.adContent ;;
  }

  dimension: app_exit_screen_name {
    type: string
    sql: ${TABLE}.appExitScreenName ;;
  }

  dimension: app_landing_screen_name {
    type: string
    sql: ${TABLE}.appLandingScreenName ;;
  }

  dimension: app_name {
    type: string
    sql: ${TABLE}.appName ;;
  }

  dimension: app_screen_depth {
    type: string
    sql: ${TABLE}.appScreenDepth ;;
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.appVersion ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: browser_version {
    type: string
    sql: ${TABLE}.browserVersion ;;
  }

  dimension: buyer_status {
    type: string
    sql: ${TABLE}.buyerStatus ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: channel_grouping {
    type: string
    sql: ${TABLE}.channelGrouping ;;
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
    sql: ${TABLE}.country ;;
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customerType ;;
  }

  dimension: default_currency {
    type: string
    sql: ${TABLE}.defaultCurrency ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: ga_date {
    type: string
    sql: ${TABLE}.gaDate ;;
    hidden: yes
  }

  dimension: guest_id {
    type: string
    sql: ${TABLE}.guestId ;;
  }

  dimension: is_bounce {
    type: number
    sql: ${TABLE}.isBounce ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: login_status {
    type: string
    sql: ${TABLE}.loginStatus ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.metro ;;
  }

  dimension: mobile_device_branding {
    type: string
    sql: ${TABLE}.mobileDeviceBranding ;;
  }

  dimension: mobile_device_marketing_name {
    type: string
    sql: ${TABLE}.mobileDeviceMarketingName ;;
  }

  dimension: mobile_device_model {
    type: string
    sql: ${TABLE}.mobileDeviceModel ;;
  }

  dimension: operating_system {
    type: string
    sql: ${TABLE}.operatingSystem ;;
  }

  dimension: operating_system_version {
    type: string
    sql: ${TABLE}.operatingSystemVersion ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: referral_path {
    type: string
    sql: ${TABLE}.referralPath ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: registration_status {
    type: string
    sql: ${TABLE}.registrationStatus ;;
  }

  dimension_group: session_start {
    label: "Session"
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
    sql: DATETIME(${TABLE}.sessionStartTime, "America/New_York")  ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: sub_continent {
    type: string
    sql: ${TABLE}.subContinent ;;
  }

  dimension: total_hits {
    type: number
    sql: ${TABLE}.totalHits ;;
    hidden: yes
  }

  dimension: total_pageviews {
    type: number
    sql: ${TABLE}.totalPageviews ;;
  }

  dimension: total_screenviews {
    type: number
    sql: ${TABLE}.totalScreenviews ;;
  }

  dimension: total_time_on_site {
    type: number
    sql: ${TABLE}.totalTimeOnSite ;;
  }

  dimension: trade_status {
    type: string
    sql: ${TABLE}.tradeStatus ;;
  }

  dimension: user_id {
    type: number
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

  dimension: web_exit_page_path {
    type: string
    sql: ${TABLE}.webExitPagePath ;;
  }

  dimension: web_landing_page_path {
    type: string
    sql: ${TABLE}.webLandingPagePath ;;
  }

  dimension_group: partition {
    hidden: yes
    label: "Session"
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

  measure: count {
    label: "Total Session Count"
    type: count_distinct
    sql: ${sessionid} ;;
    # approximate_threshold: 100000
  }

  dimension: sessionid {
    type: string
    sql: CONCAT(${full_visitor_id},CAST(${visit_id} AS STRING),${ga_date});;
    primary_key: yes
  }

}
