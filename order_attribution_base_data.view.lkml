view: order_attribution_base_data {
  sql_table_name: looker.order_attribution_base_data ;;

  dimension: category_l1 {
    type: string
    sql: ${TABLE}.categoryL1 ;;
  }

  dimension_group: date_of_transaction {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dateOfTransaction ;;
  }

  dimension: direct {
    type: number
    sql: ${TABLE}.direct ;;
  }

  dimension: email {
    type: number
    sql: ${TABLE}.email ;;
  }

  dimension: email_tc {
    type: number
    sql: ${TABLE}.email_tc ;;
  }

  dimension: first_confirmation {
    type: number
    sql: ${TABLE}.firstConfirmation ;;
  }

  dimension: first_submission {
    type: number
    sql: ${TABLE}.firstSubmission ;;
  }

  dimension: internal_ad {
    type: number
    sql: ${TABLE}.internal_ad ;;
  }

  dimension: is_pnb_last_click {
    type: number
    sql: ${TABLE}.isPnbLastClick ;;
  }

  dimension: last_click {
    type: string
    sql: ${TABLE}.lastClick ;;
  }

  dimension: last_click_pnb_country_group {
    type: string
    sql: ${TABLE}.lastClickPnbCountryGroup ;;
  }

  dimension: latest_commission {
    type: number
    sql: ${TABLE}.latestCommission ;;
  }

  dimension: latest_subtotal {
    type: number
    sql: ${TABLE}.latestSubtotal ;;
  }

  dimension: mobile_app {
    type: number
    sql: ${TABLE}.mobile_app ;;
  }

  dimension: num_sessions_leading_to_trans {
    type: number
    sql: ${TABLE}.numSessionsLeadingToTrans ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.orderStatus ;;
  }

  dimension: order_type_grouped {
    type: string
    sql: ${TABLE}.orderTypeGrouped ;;
  }

  dimension: organic {
    type: number
    sql: ${TABLE}.organic ;;
  }

  dimension: other {
    type: number
    sql: ${TABLE}.other ;;
  }

  dimension: paid_brand {
    type: number
    sql: ${TABLE}.paid_brand ;;
  }

  dimension: pnb_all_domestic {
    type: number
    sql: ${TABLE}.pnb_all_domestic ;;
  }

  dimension: pnb_all_intl {
    type: number
    sql: ${TABLE}.pnb_all_intl ;;
  }

  dimension: pnb_assists {
    type: number
    sql: ${TABLE}.pnbAssists ;;
  }

  dimension: pnb_gdn_domestic {
    type: number
    sql: ${TABLE}.pnb_gdn_domestic ;;
  }

  dimension: pnb_na_na {
    type: number
    sql: ${TABLE}.pnb_NA_NA ;;
  }

  dimension: pnb_paid_facebook_domestic {
    type: number
    sql: ${TABLE}.pnb_paid_facebook_domestic ;;
  }

  dimension: pnb_pla_domestic {
    type: number
    sql: ${TABLE}.pnb_pla_domestic ;;
  }

  dimension: pnb_pla_intl {
    type: number
    sql: ${TABLE}.pnb_pla_intl ;;
  }

  dimension: pnb_remarketing_domestic {
    type: number
    sql: ${TABLE}.pnb_remarketing_domestic ;;
  }

  dimension: pnb_remarketing_intl {
    type: number
    sql: ${TABLE}.pnb_remarketing_intl ;;
  }

  dimension: pnb_sem_domestic {
    type: number
    sql: ${TABLE}.pnb_sem_domestic ;;
  }

  dimension: pnb_sem_intl {
    type: number
    sql: ${TABLE}.pnb_sem_intl ;;
  }

  dimension: referral {
    type: number
    sql: ${TABLE}.referral ;;
  }

  dimension: total_pnb_touchpoints {
    type: number
    sql: ${TABLE}.totalPnbTouchpoints ;;
  }

  dimension: trade_buyer {
    type: number
    sql: ${TABLE}.tradeBuyer ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}.transactionId ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.userId ;;
  }

  dimension: year_month {
    type: number
    sql: ${TABLE}.yearMonth ;;
  }

  dimension_group: year_month_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.yearMonthStartDate ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
