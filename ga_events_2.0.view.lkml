view: ga_events_full {
  sql_table_name: `api-project-1065928543184.96922533.ga_sessions_*`;;

  # added time partitioned filter
  filter: ga_session_date {
    type: string
    sql: {% condition %} _TABLE_SUFFIX {% endcondition %} ;;
  }

  dimension: current_year {
    type: string
    sql: IF(month(current_date()) < 3, '2016,2017', '2016,2017') ;;
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
    hidden: yes
    type: string
    sql: ${TABLE}.date ;;
  }

  # Create a session date dimension/filter group
  dimension_group: sessions {
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

  # RECORD/STRUCT: custom_dimension
  dimension: custom_dimensions {
    hidden: yes
    sql: ${TABLE}.customDimensions ;;
  }

  # RECORD/STRUCT hits
  dimension: hits {
    hidden: yes
    sql: ${TABLE}.hits ;;
  }

  # OPTIONAL
  dimension: geo_network {
    hidden: yes
    sql: ${TABLE}.geoNetwork ;;
  }
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

# In QA event_info, content_group, custom_dimensions, e_commerce_action
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

  dimension: minute {
    type: number
    sql: ${TABLE}.minute ;;
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

# In QA: Hit E-commerce Action type
view: ga_events_full__hits__e_commerce_action {

  # copy/build the parimary key
  dimension: primary {
    primary_key: yes
    type: string
    sql: CONCAT(${ga_events_full.date},
                CAST(${ga_events_full.visit_id} AS STRING),
                ${ga_events_full.full_visitor_id});;
  }

  dimension: action_type_clean {
    type: string
    sql:
      CASE
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '0'  THEN 'unknown'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '1' THEN 'product_list_click'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '2' THEN 'product_detail_view'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '3' THEN 'add_to_cart'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '4' THEN 'remove_from_cart'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '5' THEN 'product_checkout_view'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '6' THEN 'completed_purchase'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '7' THEN 'refund_purchase'
        WHEN ${ga_events_full__hits.e_commerce_action}.action_type = '8' THEN 'checkout_options'
        ELSE NULL
      END;;
  }
}

# In QA: IP addression info
view: ga_events_full__geo_network {

  # Field Definition: This section contains information about the geography of the user.

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
    # Def: The continent from which sessions originated, based on IP address.
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
