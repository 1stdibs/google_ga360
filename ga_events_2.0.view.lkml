view: ga_events_full {
  sql_table_name: `api-project-1065928543184.96922533.ga_sessions_*`;;
  #sql: {% condition date_filter %} _TABLE_SUFFIX {% endcondition %} ;;

  # added time partitioned filter
  filter: ga_session_date {
    type: string
    sql: {% condition %} _TABLE_SUFFIX {% endcondition %} ;;
  }

  # Create a primary key
  dimension: primary {
    primary_key: yes
    type: string
    sql:concat(${date},
                cast(${visit_id} AS string),
                ${full_visitor_id}) ;;
  }

  dimension: date {
    type: string
    sql: PARSE_DATE('%Y%m%d', ${TABLE}.date) ;;
  }

  dimension_group: ga_date {
    type: time
    timeframes: [date, week, month]
    sql: cast(${date} as TIMESTAMP) ;;
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: visit_id {
    type: number
    sql: ${TABLE}.visitId ;;
  }

  # RECORD/STRUCT: custom_dimension
  dimension: custom_dimensions {
    hidden: yes
    sql: ${TABLE}.customDimensions ;;
  }

  # RECORD hits
  dimension: hits {
    hidden: yes
    sql: ${TABLE}.hits ;;
  }


#   dimension: user_id {
#     type: string
#     sql: ${TABLE}.userId ;;
#   }

#   dimension: channel_grouping {
#     type: string
#     sql: ${TABLE}.channelGrouping ;;
#   }
#

#   dimension: device {
#     hidden: yes
#     sql: ${TABLE}.device ;;
#   }

#   dimension: geo_network {
#     hidden: yes
#     sql: ${TABLE}.geoNetwork ;;
#   }

#   dimension: social_engagement_type {
#     type: string
#     sql: ${TABLE}.socialEngagementType ;;
#   }
#
#   dimension: totals {
#     hidden: yes
#     sql: ${TABLE}.totals ;;
#   }
#
#   dimension: traffic_source {
#     hidden: yes
#     sql: ${TABLE}.trafficSource ;;
#   }

#   dimension: visit_number {
#     type: number
#     sql: ${TABLE}.visitNumber ;;
#   }
#
#   dimension: visit_start_time {
#     type: number
#     sql: ${TABLE}.visitStartTime ;;
#   }
#
#   dimension: visitor_id {
#     type: number
#     sql: ${TABLE}.visitorId ;;
#   }
#
#   measure: session_count {
#     type: count
#   }
}

view: ga_events_full__custom_dimensions {

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
    sql: CONCAT(${ga_events_full.date},
        CAST(${ga_events_full.visit_id} AS string),
        ${ga_events_full.full_visitor_id}) ;;
  }

  dimension: user_id {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 33, temp.value, NULL))
      FROM
        UNNEST(${ga_events_full.custom_dimensions}) AS temp);;
  }

  dimension: guest_id {
    type: string
    sql:
      (SELECT
        MAX(IF(temp.index = 32, temp.value, NULL))
      FROM
        UNNEST(${ga_events_full.custom_dimensions}) AS temp);;
  }
}

view: ga_events_full__hits {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

  dimension: content_group {
    hidden: yes
    sql: ${TABLE}.contentGroup ;;
  }

  dimension: custom_dimensions {
    hidden: yes
    sql: ${TABLE}.customDimensions ;;
  }

  dimension: platform{
    type: string
    sql: ${TABLE}.dataSource ;;
  }

  dimension: e_commerce_action {
    hidden: yes
    sql: ${TABLE}.eCommerceAction ;;
  }

  # when hitType == "EVENT"
  dimension: event_info {
    hidden: yes
    sql: ${TABLE}.eventInfo;;
  }

  dimension: hit_number {
    type: number
    sql: ${TABLE}.hitNumber ;;
  }

  dimension: hour {
    type: number
    sql: ${TABLE}.hour ;;
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

  dimension: is_secure {
    type: yesno
    sql: ${TABLE}.isSecure ;;
  }


  dimension: latency_tracking {
    hidden: yes
    sql: ${TABLE}.latencyTracking ;;
  }

  dimension: minute {
    type: number
    sql: ${TABLE}.minute ;;
  }

  dimension: publisher {
    hidden: yes
    sql: ${TABLE}.publisher ;;
  }

  dimension: referer {
    type: string
    sql: ${TABLE}.referer ;;
  }

  dimension: time {
    type: number
    sql: ${TABLE}.time ;;
  }


  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

# In QA: Event Info dimensions
view: ga_events_full__hits__event_info {


  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

  dimension: event_action {
    type: string
    sql: ${ga_events_full__hits.event_info}.eventAction;;
  }

  dimension: event_category {
    type: string
    sql: ${ga_events_full__hits.event_info}.eventCategory;;
  }

  dimension: event_label {
    type: string
    sql: ${ga_events_full__hits.event_info}.eventLabel;;
  }

  dimension: event_value {
    type: number
    sql: ${ga_events_full__hits.event_info}.eventValue;;
  }


  ##### BEGINNING OF EVENT BUSINESS LOGIC ############

  measure: contact_dealer_clicked {
    type: number
    sql: SUM(IF(${event_action} IN  ('contact dealer clicked', 'call dealer clicked','call dealer initiated', 'request shipping quote clicked','request hold clicked', 'request net price clicked' ), 1, 0)) ;;
  }

  measure: contact_dealer_submitted {
    type: number
    sql:SUM(IF(${event_action} IN  ('contact dealer submitted','request shipping quote submitted', 'request hold submitted', 'request net price submitted', 'offer inquiry submitted' ), 1, 0))  ;;
  }

  measure: registration_entries {
    type: number
    sql: SUM(IF(${event_action} = 'registration entry', 1, 0)) ;;
  }

  measure: registration_completes {
    type: number
    sql: SUM(IF(${event_action} =  'registration complete', 1, 0)) ;;
  }

  measure: purchase_clicks {
    type: number
    sql: SUM(IF(${event_category} = 'purchase click', 1, 0)) ;;
    drill_fields: [event_action]
  }

  measure: make_offer_clicks {
    type: number
    sql: SUM(IF(${event_category} = 'make offer click', 1, 0)) ;;
    drill_fields: [event_action]
  }

  ##### END OF BUSINESS LOGIC FOR EVENTS ################
}

# In QA: Content Group dimension
view: ga_events_full__hits__content_group {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

  dimension: content_group1 {
    type: string
    sql: ${ga_events_full__hits.content_group}.contentGroup1 ;;
  }

  dimension: content_group2 {
    type: string
    sql: ${ga_events_full__hits.content_group}.contentGroup2 ;;
  }

  dimension: content_group3 {
    type: string
    sql: ${ga_events_full__hits.content_group}.contentGroup3 ;;
  }

  dimension: content_group4 {
    type: string
    sql: ${ga_events_full__hits.content_group}.contentGroup4 ;;
  }

  dimension: content_group5 {
    type: string
    sql: ${ga_events_full__hits.content_group}.contentGroup5 ;;
  }
#
#   dimension: content_group_unique_views1 {
#     type: number
#     sql: ${TABLE}.contentGroupUniqueViews1 ;;
#   }
#
#   dimension: content_group_unique_views2 {
#     type: number
#     sql: ${TABLE}.contentGroupUniqueViews2 ;;
#   }
#
#   dimension: content_group_unique_views3 {
#     type: number
#     sql: ${TABLE}.contentGroupUniqueViews3 ;;
#   }
#
#   dimension: content_group_unique_views4 {
#     type: number
#     sql: ${TABLE}.contentGroupUniqueViews4 ;;
#   }
#
#   dimension: content_group_unique_views5 {
#     type: number
#     sql: ${TABLE}.contentGroupUniqueViews5 ;;
#   }
#
#   dimension: previous_content_group1 {
#     type: string
#     sql: ${TABLE}.previousContentGroup1 ;;
#   }
#
#   dimension: previous_content_group2 {
#     type: string
#     sql: ${TABLE}.previousContentGroup2 ;;
#   }
#
#   dimension: previous_content_group3 {
#     type: string
#     sql: ${TABLE}.previousContentGroup3 ;;
#   }
#
#   dimension: previous_content_group4 {
#     type: string
#     sql: ${TABLE}.previousContentGroup4 ;;
#   }
#
#   dimension: previous_content_group5 {
#     type: string
#     sql: ${TABLE}.previousContentGroup5 ;;
#   }
}

# In QA: Hits CDs need modification
view: ga_events_full__hits__custom_dimensions {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

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

  # ?@YJ: should we keep this in ITEM level?
  dimension: item_condition {
    type: string
    sql:
      (SELECT MAX(IF(ic.index = 4, ic.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ic);;
  }

  dimension: page_sort {
    type: string
    sql:
      (SELECT MAX(IF(ps.index = 5, ps.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ps);;
  }

  # ?@YJ: should we keep this in ITEM level?
  dimension: purchase_status {
    type: string
    sql:
      (SELECT MAX(IF(pst.index = 7, pst.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS pst);;
  }

  dimension: view_mode {
    type: string
    sql:
      (SELECT MAX(IF(vm.index = 8, vm.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS vm);;
  }

  # ?@YJ: should we keep this in ITEM level?
  dimension: item_date {
    type: string
    sql:
      (SELECT MAX(IF(id.index = 10, id.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS id);;
  }

  dimension: number_of_images {
    type: string
    sql:
      (SELECT MAX(IF(noi.index = 14, noi.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS noi);;
  }

  # ?@YJ: should we keep this in ITEM level?
  dimension: item_id {
    type: string
    sql:
      (SELECT MAX(IF(ii.index = 15, ii.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions})  AS ii) ;;
  }

  dimension: page_number_viewed {
    type: string
    sql:
      (SELECT MAX(IF(pnv.index = 16, pnv.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS pnv) ;;
  }

  dimension: item_count {
    type: number
    sql:
      (SELECT MAX(IF(ic.index = 17, ic.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ic) ;;
  }

  dimension: content_module {
    type: string
    sql:
      (SELECT MAX(IF(cm.index = 18, cm.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS cm) ;;
  }

  dimension: asking_price {
    type: string
    sql:
      (SELECT MAX(IF(ap.index = 21, ap.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ap) ;;
  }

  # ?@YJ: should we keep this in ITEM level?
  dimension: dealer_name {
    type: string
    sql:
      (SELECT MAX(IF(dn.index = 22, dn.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS dn) ;;
  }

  # ?@YJ: should we keep this in ITEM level?
  dimension: creator {
    type: string
    sql:
      (SELECT MAX(IF(c.index = 43, c.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS c);;
  }

  dimension: dealer_id {
    type: string
    sql:
      (SELECT MAX(IF(di.index = 44, di.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS di);;
  }

  # ?@YJ: should we keep this in ITEM level?
  dimension: item_posting_location {
    type: string
    sql:
      (SELECT MAX(IF(ipl.index = 45, ipl.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ipl);;
  }

  dimension: price_type {
    type: string
    sql:
      (SELECT MAX(IF(pt.index = 67, pt.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS pt);;
  }

  dimension: order_type {
    type: string
    sql:
      (SELECT MAX(IF(ot.index = 68, ot.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ot);;
  }

  dimension: shipping_status {
    type: string
    sql:
      (SELECT MAX(IF(ss.index = 61, ss.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS ss);;
  }

  # ?@YJ: can we replace this by landWebPagePath
  dimension: first_page_of_session {
    type: string
    sql:
      (SELECT MAX(IF(fps.index = 75, fps.value, NULL))
      FROM UNNEST(${ga_events_full__hits.custom_dimensions}) AS fps);;
  }
}

view: ga_events_full__hits__e_commerce_action {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

  dimension: action_type {
    type: string
    sql: ${TABLE}.action_type ;;
  }

  dimension: action_type_clean {
    type: string
    sql:
      CASE
        WHEN ${TABLE}.action_type = '0'  THEN 'unknown'
        WHEN ${TABLE}.action_type = '1' THEN 'product_list_click'
        WHEN ${TABLE}.action_type = '2' THEN 'product_detail_view'
        WHEN ${TABLE}.action_type = '3' THEN 'add_to_cart'
        WHEN ${TABLE}.action_type = '4' THEN 'remove_from_cart'
        WHEN ${TABLE}.action_type = '5' THEN 'product_checkout_view'
        WHEN ${TABLE}.action_type = '6' THEN 'completed_purchase'
        WHEN ${TABLE}.action_type = '7' THEN 'refund_purchase'
        WHEN ${TABLE}.action_type = '8' THEN 'checkout_options'
        ELSE NULL
      END;;
  }

  # dimension: option {
  #   type: string
  #   sql: ${TABLE}.option ;;
  # }

  # dimension: step {
  #   type: number
  #   sql: ${TABLE}.step ;;
  # }
}


view: ga_events_full__hits__latency_tracking {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

#   # build/copy a hits level primary
#   dimension: hits_primary {
#     primary_key: yes
#     type: string
#     sql: CONCAT(${ga_events_full.date},
#                 CAST(${ga_events_full.visit_id} AS STRING),
#                 ${ga_events_full.full_visitor_id},
#                 ${ga_events_full__hits.hit_number}) ;;
#   }


  dimension: dom_content_loaded_time {
    type: number
    sql: ${TABLE}.domContentLoadedTime ;;
  }

  dimension: dom_interactive_time {
    type: number
    sql: ${TABLE}.domInteractiveTime ;;
  }

  dimension: dom_latency_metrics_sample {
    type: number
    sql: ${TABLE}.domLatencyMetricsSample ;;
  }

  dimension: domain_lookup_time {
    type: number
    sql: ${TABLE}.domainLookupTime ;;
  }

  dimension: page_download_time {
    type: number
    sql: ${TABLE}.pageDownloadTime ;;
  }

  dimension: page_load_sample {
    type: number
    sql: ${TABLE}.pageLoadSample ;;
  }

  dimension: page_load_time {
    type: number
    sql: ${TABLE}.pageLoadTime ;;
  }

  dimension: redirection_time {
    type: number
    sql: ${TABLE}.redirectionTime ;;
  }

  dimension: server_connection_time {
    type: number
    sql: ${TABLE}.serverConnectionTime ;;
  }

  dimension: server_response_time {
    type: number
    sql: ${TABLE}.serverResponseTime ;;
  }

  dimension: speed_metrics_sample {
    type: number
    sql: ${TABLE}.speedMetricsSample ;;
  }

  dimension: user_timing_category {
    type: string
    sql: ${TABLE}.userTimingCategory ;;
  }

  dimension: user_timing_label {
    type: string
    sql: ${TABLE}.userTimingLabel ;;
  }

  dimension: user_timing_sample {
    type: number
    sql: ${TABLE}.userTimingSample ;;
  }

  dimension: user_timing_value {
    type: number
    sql: ${TABLE}.userTimingValue ;;
  }

  dimension: user_timing_variable {
    type: string
    sql: ${TABLE}.userTimingVariable ;;
  }
}

view: ga_events_full__hits__publisher {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

#   # build/copy a hits level primary
#   dimension: hits_primary {
#     primary_key: yes
#     type: string
#     sql: CONCAT(${ga_events_full.date},
#                 CAST(${ga_events_full.visit_id} AS STRING),
#                 ${ga_events_full.full_visitor_id},
#                 ${ga_events_full__hits.hit_number}) ;;
#   }


  dimension: ads_clicked {
    type: number
    sql: ${TABLE}.adsClicked ;;
  }

  dimension: ads_pages_viewed {
    type: number
    sql: ${TABLE}.adsPagesViewed ;;
  }

  dimension: ads_revenue {
    type: number
    sql: ${TABLE}.adsRevenue ;;
  }

  dimension: ads_units_matched {
    type: number
    sql: ${TABLE}.adsUnitsMatched ;;
  }

  dimension: ads_units_viewed {
    type: number
    sql: ${TABLE}.adsUnitsViewed ;;
  }

  dimension: ads_viewed {
    type: number
    sql: ${TABLE}.adsViewed ;;
  }

  dimension: adsense_backfill_dfp_clicks {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpClicks ;;
  }

  dimension: adsense_backfill_dfp_impressions {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpImpressions ;;
  }

  dimension: adsense_backfill_dfp_matched_queries {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpMatchedQueries ;;
  }

  dimension: adsense_backfill_dfp_measurable_impressions {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpMeasurableImpressions ;;
  }

  dimension: adsense_backfill_dfp_pages_viewed {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpPagesViewed ;;
  }

  dimension: adsense_backfill_dfp_queries {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpQueries ;;
  }

  dimension: adsense_backfill_dfp_revenue_cpc {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpRevenueCpc ;;
  }

  dimension: adsense_backfill_dfp_revenue_cpm {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpRevenueCpm ;;
  }

  dimension: adsense_backfill_dfp_viewable_impressions {
    type: number
    sql: ${TABLE}.adsenseBackfillDfpViewableImpressions ;;
  }

  dimension: adx_backfill_dfp_clicks {
    type: number
    sql: ${TABLE}.adxBackfillDfpClicks ;;
  }

  dimension: adx_backfill_dfp_impressions {
    type: number
    sql: ${TABLE}.adxBackfillDfpImpressions ;;
  }

  dimension: adx_backfill_dfp_matched_queries {
    type: number
    sql: ${TABLE}.adxBackfillDfpMatchedQueries ;;
  }

  dimension: adx_backfill_dfp_measurable_impressions {
    type: number
    sql: ${TABLE}.adxBackfillDfpMeasurableImpressions ;;
  }

  dimension: adx_backfill_dfp_pages_viewed {
    type: number
    sql: ${TABLE}.adxBackfillDfpPagesViewed ;;
  }

  dimension: adx_backfill_dfp_queries {
    type: number
    sql: ${TABLE}.adxBackfillDfpQueries ;;
  }

  dimension: adx_backfill_dfp_revenue_cpc {
    type: number
    sql: ${TABLE}.adxBackfillDfpRevenueCpc ;;
  }

  dimension: adx_backfill_dfp_revenue_cpm {
    type: number
    sql: ${TABLE}.adxBackfillDfpRevenueCpm ;;
  }

  dimension: adx_backfill_dfp_viewable_impressions {
    type: number
    sql: ${TABLE}.adxBackfillDfpViewableImpressions ;;
  }

  dimension: adx_clicks {
    type: number
    sql: ${TABLE}.adxClicks ;;
  }

  dimension: adx_impressions {
    type: number
    sql: ${TABLE}.adxImpressions ;;
  }

  dimension: adx_matched_queries {
    type: number
    sql: ${TABLE}.adxMatchedQueries ;;
  }

  dimension: adx_measurable_impressions {
    type: number
    sql: ${TABLE}.adxMeasurableImpressions ;;
  }

  dimension: adx_pages_viewed {
    type: number
    sql: ${TABLE}.adxPagesViewed ;;
  }

  dimension: adx_queries {
    type: number
    sql: ${TABLE}.adxQueries ;;
  }

  dimension: adx_revenue {
    type: number
    sql: ${TABLE}.adxRevenue ;;
  }

  dimension: adx_viewable_impressions {
    type: number
    sql: ${TABLE}.adxViewableImpressions ;;
  }

  dimension: dfp_ad_group {
    type: string
    sql: ${TABLE}.dfpAdGroup ;;
  }

  dimension: dfp_ad_units {
    type: string
    sql: ${TABLE}.dfpAdUnits ;;
  }

  dimension: dfp_clicks {
    type: number
    sql: ${TABLE}.dfpClicks ;;
  }

  dimension: dfp_impressions {
    type: number
    sql: ${TABLE}.dfpImpressions ;;
  }

  dimension: dfp_matched_queries {
    type: number
    sql: ${TABLE}.dfpMatchedQueries ;;
  }

  dimension: dfp_measurable_impressions {
    type: number
    sql: ${TABLE}.dfpMeasurableImpressions ;;
  }

  dimension: dfp_network_id {
    type: string
    sql: ${TABLE}.dfpNetworkId ;;
  }

  dimension: dfp_pages_viewed {
    type: number
    sql: ${TABLE}.dfpPagesViewed ;;
  }

  dimension: dfp_queries {
    type: number
    sql: ${TABLE}.dfpQueries ;;
  }

  dimension: dfp_revenue_cpc {
    type: number
    sql: ${TABLE}.dfpRevenueCpc ;;
  }

  dimension: dfp_revenue_cpm {
    type: number
    sql: ${TABLE}.dfpRevenueCpm ;;
  }

  dimension: dfp_viewable_impressions {
    type: number
    sql: ${TABLE}.dfpViewableImpressions ;;
  }

  dimension: measurable_ads_viewed {
    type: number
    sql: ${TABLE}.measurableAdsViewed ;;
  }

  dimension: viewable_ads_viewed {
    type: number
    sql: ${TABLE}.viewableAdsViewed ;;
  }
}

# view: ga_events_full__hits__promotion {
#
#   # copy/build the parimary key
#   dimension: primary {
#     primary_key: yes
#     type: string
#     sql: CONCAT(${ga_events_full.date},
#                 CAST(${ga_events_full.visit_id} AS STRING),
#                 ${ga_events_full.full_visitor_id});;
#   }
#
# #   # build/copy a hits level primary
# #   dimension: hits_primary {
# #     primary_key: yes
# #     type: string
# #     sql: CONCAT(${ga_events_full.date},
# #                 CAST(${ga_events_full.visit_id} AS STRING),
# #                 ${ga_events_full.full_visitor_id},
# #                 ${ga_events_full__hits.hit_number}) ;;
# #   }
#
#
#   dimension: promo_creative {
#     type: string
#     sql: ${TABLE}.promoCreative ;;
#   }
#
#   dimension: promo_id {
#     type: string
#     sql: ${TABLE}.promoId ;;
#   }
#
#   dimension: promo_name {
#     type: string
#     sql: ${TABLE}.promoName ;;
#   }
#
#   dimension: promo_position {
#     type: string
#     sql: ${TABLE}.promoPosition ;;
#   }
# }

# view: ga_events_full__hits__refund {
#
#   # copy/build the parimary key
#   dimension: primary {
#     primary_key: yes
#     type: string
#     sql: CONCAT(${ga_events_full.date},
#                 CAST(${ga_events_full.visit_id} AS STRING),
#                 ${ga_events_full.full_visitor_id});;
#   }
#
# #   # build/copy a hits level primary
# #   dimension: hits_primary {
# #     primary_key: yes
# #     type: string
# #     sql: CONCAT(${ga_events_full.date},
# #                 CAST(${ga_events_full.visit_id} AS STRING),
# #                 ${ga_events_full.full_visitor_id},
# #                 ${ga_events_full__hits.hit_number}) ;;
# #   }
#
#
#   dimension: local_refund_amount {
#     type: number
#     sql: ${TABLE}.localRefundAmount ;;
#   }
#
#   dimension: refund_amount {
#     type: number
#     sql: ${TABLE}.refundAmount ;;
#   }
# }

view: ga_events_full__geo_network {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
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

# view: ga_events_full__traffic_source {

#   # build/copy a hits level primary
#   dimension: hits_primary {
#     primary_key: yes
#     type: string
#     sql: CONCAT(${ga_events_full.date},
#                 CAST(${ga_events_full.visit_id} AS STRING),
#                 ${ga_events_full.full_visitor_id},
#                 ${ga_events_full__hits.hit_number}) ;;
#   }


#   dimension: ad_content {
#     type: string
#     sql: ${TABLE}.adContent ;;
#   }

#   dimension: adwords_click_info {
#     hidden: yes
#     sql: ${TABLE}.adwordsClickInfo ;;
#   }

#   dimension: campaign {
#     type: string
#     sql: ${TABLE}.campaign ;;
#   }

#   dimension: campaign_code {
#     type: string
#     sql: ${TABLE}.campaignCode ;;
#   }

#   dimension: is_true_direct {
#     type: yesno
#     sql: ${TABLE}.isTrueDirect ;;
#   }

#   dimension: keyword {
#     type: string
#     sql: ${TABLE}.keyword ;;
#   }

#   dimension: medium {
#     type: string
#     sql: ${TABLE}.medium ;;
#   }

#   dimension: referral_path {
#     type: string
#     sql: ${TABLE}.referralPath ;;
#   }

#   dimension: source {
#     type: string
#     sql: ${TABLE}.source ;;
#   }
# }

# view: ga_events_full__traffic_source__adwords_click_info {
#   dimension: ad_group_id {
#     type: number
#     sql: ${TABLE}.adGroupId ;;
#   }

#   dimension: ad_network_type {
#     type: string
#     sql: ${TABLE}.adNetworkType ;;
#   }

#   dimension: campaign_id {
#     type: number
#     sql: ${TABLE}.campaignId ;;
#   }

#   dimension: creative_id {
#     type: number
#     sql: ${TABLE}.creativeId ;;
#   }

#   dimension: criteria_id {
#     type: number
#     sql: ${TABLE}.criteriaId ;;
#   }

#   dimension: criteria_parameters {
#     type: string
#     sql: ${TABLE}.criteriaParameters ;;
#   }

#   dimension: customer_id {
#     type: number
#     sql: ${TABLE}.customerId ;;
#   }

#   dimension: gcl_id {
#     type: string
#     sql: ${TABLE}.gclId ;;
#   }

#   dimension: is_video_ad {
#     type: yesno
#     sql: ${TABLE}.isVideoAd ;;
#   }

#   dimension: page {
#     type: number
#     sql: ${TABLE}.page ;;
#   }

#   dimension: slot {
#     type: string
#     sql: ${TABLE}.slot ;;
#   }

#   dimension: targeting_criteria {
#     hidden: yes
#     sql: ${TABLE}.targetingCriteria ;;
#   }
# }

# view: ga_events_full__traffic_source__adwords_click_info__targeting_criteria {
#   dimension: boom_userlist_id {
#     type: number
#     sql: ${TABLE}.boomUserlistId ;;
#   }
# }

view: ga_events_full__device {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
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
