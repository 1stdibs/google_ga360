view: ga_status {
  sql_table_name: looker.GaStatus ;;

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    primary_key: yes
    # link: {
    # label: "Link to Jira Ticket"
    # url:
    # icon_url: "http://www.looker.com/favicon.ico"
    # }
  }

  dimension_group: end {
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
    sql: ${TABLE}.endDate ;;
  }

  dimension: jira_link {
    type: string
    sql: ${TABLE}.jiraLink ;;
  }

  dimension: metrics_affected {
    type: string
    sql: ${TABLE}.metricsAffected ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.startDate ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
