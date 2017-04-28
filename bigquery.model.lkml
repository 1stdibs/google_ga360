connection: "bigquery"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# explore: ga_sessions {
#   extends: [ga_sessions_block]
# }

explore: ga_sessions {
  sql_always_where: ${ga_sessions.partition_raw} BETWEEN TIMESTAMP('2017-03-01') AND TIMESTAMP('2017-03-31');;
}

explore: looker_ga_sessions_by_day {
}

# explore: ga_pageviews {
# }

explore: ga_ecommerce {
  sql_always_where: ${ga_ecommerce.partition_raw} BETWEEN TIMESTAMP('2017-03-01') AND TIMESTAMP('2017-03-31');;
}

explore: ga_transactions {
  view_name: ga_ecommerce
  always_filter: {
    filters: {
      field: ga_ecommerce.ecom_action_type
      value: "completed_purchase"
    }
  }
}
