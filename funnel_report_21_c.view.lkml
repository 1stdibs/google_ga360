view: funnel_report_21_c {
  sql_table_name: looker.funnel_report_21C ;;

#   measure: percent_test
#   {
#     type: number
#     sql: ${all_confirmed_orders}/${contact_dealer} ;;
#     group_label: "Order Fields"
#   }


  measure: all_confirmed_orders {
    type: sum
    sql: ${TABLE}.all_confirmed_orders ;;
    group_label: "Order Fields"
  }

  measure: all_initiated_orders {
    type: sum
    sql: ${TABLE}.all_initiated_orders ;;
    group_label: "Order Fields"
  }

  measure: all_items_posted {
    type: sum
    sql: ${TABLE}.all_items_posted ;;
    group_label: "Item Fields"
  }

  measure: all_submitted_orders {
    type: sum
    sql: ${TABLE}.all_submitted_orders ;;
    group_label: "Order Fields"
  }

  measure: avail_items {
    type: sum
    sql: ${TABLE}.avail_items ;;
    group_label: "Item Fields"
  }

  measure: confirmed_gmv {
    type: sum
    sql: ${TABLE}.confirmed_GMV ;;
    group_label: "Order Fields"
    value_format_name: usd_0
    }

  measure: contact_dealer {
    type: sum
    sql: ${TABLE}.contact_dealer ;;
    label: "Total Dealer Contacts"
    group_label: "Dealer Fields"
  }


  dimension: continent {
    type: string
    sql: ${TABLE}.continent ;;
    group_label: "Dealer Fields"
    label: "Storefront Continent"
  }

  dimension: dealer_name {
    type: string
    sql: ${TABLE}.dealer_name ;;
    group_label: "Dealer Fields"
  }

  dimension: dibs_v_pk {
    type: string
    sql: ${TABLE}.dibs_V_pk ;;
    hidden: yes
  }

  dimension: flag_21c {
    type: number
    sql: ${TABLE}.flag_21c ;;
    hidden: yes
  }

  dimension: 21c_type {
    type: string
    case: {
      when: {
        sql: ${flag_21c} = 1  ;;
        label: "Non 21C Furniture"
      }
      when: {
        sql: ${flag_21c} = 4 ;;
        label: "Hybrid"
      }
      when: {
        sql: ${flag_21c} = 2 ;;
        label: "Contemporary Gallery"
      }
      when: {
        sql: ${flag_21c} = 3;;
        label: "Maker / MFG"
      }
    }
    label: "21st Century Type"
  }

  dimension: pure_play_contemporary {
    type: string
    case: {
      when: {
        sql: ${flag_21c} IN (2,3)  ;;
        label: "Pure Play Contemporary"
      }
    }
  }

  measure: fnl_posted {
    type: sum
    sql: ${TABLE}.FNL_posted ;;
    group_label: "Item Fields"
    label: "Posted to FNL"
  }

  measure: pdp_impressions {
    type: sum
    sql: ${TABLE}.pdpImpressions ;;
    group_label: "Pageview Fields"
    label: "PDP Impressions"
  }

  measure: pdpviews_direct {
    type: sum
    sql: ${TABLE}.PDPviews_direct ;;
    group_label: "Pageview Fields"
    label: "PDP Views - Direct"
  }

  measure: pdpviews_email {
    type: sum
    sql: ${TABLE}.PDPviews_email ;;
    group_label: "Pageview Fields"
    label: "PDP Views - Email"
  }

  measure: pdpviews_organic {
    type: sum
    sql: ${TABLE}.PDPviews_organic ;;
    group_label: "Pageview Fields"
    label: "PDP Views - Organic"
  }

  measure: pdpviews_other_unkown {
    type: sum
    sql: ${TABLE}.PDPviews_other_unkown ;;
    group_label: "Pageview Fields"
    label: "PDP Views - Other/Unknown"
  }

  measure: pdpviews_paid_media {
    type: sum
    sql: ${TABLE}.PDPviews_paid_media ;;
    group_label: "Pageview Fields"
    label: "PDP Views - Paid Media"
  }

  measure: pdpviews_referral {
    type: sum
    sql: ${TABLE}.PDPviews_referral ;;
    group_label: "Pageview Fields"
    label: "PDP Views - Referral"
  }

  measure: storefront_pageviews {
    type: sum
    sql: ${TABLE}.storefrontPageviews ;;
    group_label: "Pageview Fields"
    label: "Storefront Pageviews"
  }

  measure: total_pdp_views {
    type: sum
    sql: ${TABLE}.pdpviews_referral + ${TABLE}.pdpviews_paid_media + ${TABLE}.pdpviews_other_unkown + ${TABLE}.pdpviews_organic + ${TABLE}.pdpviews_email + ${TABLE}.pdpviews_direct ;;
    group_label: "Pageview Fields"
    label: "Total PDP Views"
  }

  measure: dealer_count {
    type: count_distinct
    sql: ${TABLE}.dibs_V_pk ;;
    group_label: "Dealer Fields"
    label: "Total Distinct Dealer Count"
  }

  measure: dealers_with_confirmed_orders {
    type: count_distinct
    sql: ${TABLE}.dibs_V_pk ;;
    group_label: "Dealer Fields"
    label: "Total Distinct Dealers with Confirmed Orders"
    filters: {
      field: confirmed_orders
      value: "> 0"
    }
  }

  measure: aov {
    type: number
    sql:  sum(${TABLE}.confirmed_GMV) / sum(${TABLE}.all_confirmed_orders) ;;
    group_label: "Order Fields"
    label: "AOV"
    value_format_name: usd_0

  }

  measure: orders_per_dealer {
    type: number
    sql: sum(${TABLE}.all_confirmed_orders) / ${dealers_with_confirmed_orders} ;;
    group_label: "Order Fields"
    label: "Orders per Dealer"
    value_format_name: decimal_2
  }

  measure: gmv_per_dealer {
    type: number
    sql: sum(${TABLE}.confirmed_GMV) /${dealers_with_confirmed_orders} ;;
    group_label: "Order Fields"
    label: "GMV per Dealer"
    value_format_name: usd_0
  }

  measure: participation_rate {
    type: number
    sql: ${dealers_with_confirmed_orders}/${dealer_count} ;;
    group_label: "Order Fields"
    label: "Participation Rate"
    value_format_name: percent_0
  }

  measure: pdp_views_per_item {
    type: number
    sql: sum(
    ${TABLE}.pdpviews_referral + ${TABLE}.pdpviews_paid_media + ${TABLE}.pdpviews_other_unkown +
    ${TABLE}.pdpviews_organic + ${TABLE}.pdpviews_email + ${TABLE}.pdpviews_direct)
    / sum(${TABLE}.avail_items);;
    group_label: "Item Fields"
    label: "PDP Views per Item (Available Inventory)"
    value_format_name: decimal_1
  }

  measure: listings_per_dealer {
    type: number
    sql: sum(${TABLE}.avail_items) / ${dealer_count} ;;
    group_label: "Dealer Fields"
    label: "Listings per Dealer"
    value_format_name: decimal_1
  }

  measure: items_posted_per_dealer {
    type: number
    sql: sum(${TABLE}.all_items_posted) / ${dealer_count}  ;;
    group_label: "Item Fields"
    label: "Postings per Dealer"
    value_format_name: decimal_1
  }

  measure: contact_dealer_over_pdp_views {
    type: number
    sql:
    sum(${TABLE}.contact_dealer)
    /
    sum(
    ${TABLE}.pdpviews_referral + ${TABLE}.pdpviews_paid_media + ${TABLE}.pdpviews_other_unkown +
    ${TABLE}.pdpviews_organic + ${TABLE}.pdpviews_email + ${TABLE}.pdpviews_direct);;
    group_label: "Engagement Measures"
    label: "CD / PDP Views"
    value_format_name: percent_2
  }

  measure: initiated_offers_over_pdp_views {
    type: number
    sql:  sum(${TABLE}.all_initiated_orders) /  sum(
    ${TABLE}.pdpviews_referral + ${TABLE}.pdpviews_paid_media + ${TABLE}.pdpviews_other_unkown +
    ${TABLE}.pdpviews_organic + ${TABLE}.pdpviews_email + ${TABLE}.pdpviews_direct) ;;
    group_label: "Engagement Measures"
    label: "Offers / PDP Views"
    value_format_name: percent_2
  }

  measure: submitted_offers_over_pdp_views {
    type: number
    sql:  sum(${TABLE}.all_submitted_orders) /  sum(
          ${TABLE}.pdpviews_referral + ${TABLE}.pdpviews_paid_media + ${TABLE}.pdpviews_other_unkown +
          ${TABLE}.pdpviews_organic + ${TABLE}.pdpviews_email + ${TABLE}.pdpviews_direct) ;;
    group_label: "Engagement Measures"
    label: "Submitted Orders / PDP Views"
    value_format_name: percent_2
  }

  measure: confirmed_offers_over_pdp_views {
    type: number
    sql:  sum(${TABLE}.all_confirmed_orders) /  sum(
          ${TABLE}.pdpviews_referral + ${TABLE}.pdpviews_paid_media + ${TABLE}.pdpviews_other_unkown +
          ${TABLE}.pdpviews_organic + ${TABLE}.pdpviews_email + ${TABLE}.pdpviews_direct) ;;
    group_label: "Engagement Measures"
    label: "Confirmed Orders / PDP Views"
    value_format_name: percent_2
  }

  dimension: confirmed_orders {
    type: number
    sql: ${TABLE}.all_confirmed_orders ;;
    hidden: yes
  }

  dimension_group: month {
    type:time
    timeframes: [month]
    sql: TIMESTAMP(${data_month});;
    label: "Date - "
    convert_tz: no
  }

  dimension: data_month {
    type: date
    sql: DATE_SUB(${data_load_month}, INTERVAL 1 MONTH);;
    hidden: yes
    convert_tz: no
  #  value_format: "%y/%m"
  }

  dimension: data_load_month{
    type: date
    sql: _PARTITIONTIME ;;
    hidden: yes
    convert_tz: no
    # NOTE: for manually partitioned files use code below
    # sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d'))) ;;
  }

  dimension: primary {
    type: string
    sql:  ${dibs_v_pk};;
    primary_key: yes
    label: "Dealer ID"
    group_label: "Dealer Fields"
  }
}
