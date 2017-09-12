view: funnel_report_21_c {
  sql_table_name: looker.funnel_report_21C ;;

  dimension: all_confirmed_orders {
    type: number
    sql: ${TABLE}.all_confirmed_orders ;;
  }

  dimension: all_initiated_orders {
    type: number
    sql: ${TABLE}.all_initiated_orders ;;
  }

  dimension: all_items_posted {
    type: number
    sql: ${TABLE}.all_items_posted ;;
  }

  dimension: all_submitted_orders {
    type: number
    sql: ${TABLE}.all_submitted_orders ;;
  }

  dimension: avail_items {
    type: number
    sql: ${TABLE}.avail_items ;;
  }

  dimension: confirmed_gmv {
    type: number
    sql: ${TABLE}.confirmed_GMV ;;
  }

  dimension: contact_dealer {
    type: number
    sql: ${TABLE}.contact_dealer ;;
  }

  dimension: continent {
    type: string
    sql: ${TABLE}.continent ;;
  }

  dimension: dealer_name {
    type: string
    sql: ${TABLE}.dealer_name ;;
  }

  dimension: dibs_v_pk {
    type: string
    sql: ${TABLE}.dibs_V_pk ;;
  }

  dimension: flag_21c {
    type: number
    sql: ${TABLE}.flag_21c ;;
  }

  dimension: fnl_posted {
    type: number
    sql: ${TABLE}.FNL_posted ;;
  }

  dimension: pdp_impressions {
    type: number
    sql: ${TABLE}.pdpImpressions ;;
  }

  dimension: pdpviews_direct {
    type: number
    sql: ${TABLE}.PDPviews_direct ;;
  }

  dimension: pdpviews_email {
    type: number
    sql: ${TABLE}.PDPviews_email ;;
  }

  dimension: pdpviews_organic {
    type: number
    sql: ${TABLE}.PDPviews_organic ;;
  }

  dimension: pdpviews_other_unkown {
    type: number
    sql: ${TABLE}.PDPviews_other_unkown ;;
  }

  dimension: pdpviews_paid_media {
    type: number
    sql: ${TABLE}.PDPviews_paid_media ;;
  }

  dimension: pdpviews_referral {
    type: number
    sql: ${TABLE}.PDPviews_referral ;;
  }

  dimension: storefront_pageviews {
    type: number
    sql: ${TABLE}.storefrontPageviews ;;
  }

  measure: count {
    type: count
    drill_fields: [dealer_name]
  }

  dimension_group: data_load_month{
    type: time
    timeframes: [month]
    sql: _PARTITIONTIME ;;
    # NOTE: for manually partitioned files use code below
    # sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d'))) ;;
  }

  dimension: primary {
    type: string
    sql:  ${dibs_v_pk};;
    primary_key: yes
  }
}
