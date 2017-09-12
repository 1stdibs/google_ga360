connection: "bigquery"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# explore: ga_sessions {
#   extends: [ga_sessions_block]
# }


explore: ga_sessions {
  always_filter:  {
    filters: {
      field: partition_date
      value: "last 30 days"
    }
  }
#   sql_always_where: ${ga_sessions.partition_date}=${ga_sessions.session_start_date};;

}

explore: ga_session_counts {
  view_name: ga_ecommerce
  fields: [ga_pageviews.sessions_count, ga_ecommerce.partition_date,ga_pageviews.partition_date, ga_ecommerce.sessions_with_pdp_view,ga_ecommerce.sessions_with_transaction,ga_pageviews.searchbrowse_sessions,ga_ecommerce.hit_date, ga_ecommerce.ecom_action_type, ga_pageviews.is_searchbrowse,ga_pageviews.isPDP, ga_pageviews.web_page_path]
  join: ga_pageviews {
    type: inner
    sql_on: ${ga_pageviews.partition_date} = ${ga_ecommerce.partition_date} ;;
    relationship: one_to_one

  }
  always_filter: {
    filters: {
      field: ga_ecommerce.partition_date
      value: "last 30 days"
    }
  }

}

explore: ga_pageviews {
  sql_always_where: ${ga_pageviews.partition_date}=${ga_pageviews.hit_date};;
  always_filter:  {
    filters: {
      field: partition_date
      value: "last 30 days"
    }
  }
  # join: ga_sessions {
  #   relationship: many_to_one
  #   sql: INNER JOIN ${ga_sessions.sessionid} as sessid;;
  # }
}

#   join: hits {
#     view_label: "Session: Hits"
#     sql: LEFT JOIN UNNEST(${ga_sessions.hits}) as hits ;;
#     relationship: one_to_many
#   }

explore: ga_events {
  sql_always_where: ${ga_events.partition_date}=${ga_events.hit_date};;
  always_filter:  {
    filters: {
      field: partition_date
      value: "last 30 days"
    }
  }
  # join: ga_sessions {
  #   sql_on: ${ga_events.sessionid} = ${ga_sessions.sessionid};;
  # }
}

explore: ga_ecommerce {
  sql_always_where: ${ga_ecommerce.partition_date}=${ga_ecommerce.hit_date};;
  always_filter:  {
    filters: {
      field: partition_date
      value: "last 30 days"
    }
  }
  # join: ga_sessions {
  #   sql_on: ${ga_ecommerce.sessionid} = ${ga_sessions.sessionid};;
  # }
}

# explore: ga_pageviews {
# }

# explore: ga_ecommerce {
#   sql_always_where: ${ga_ecommerce.partition_raw} BETWEEN TIMESTAMP('2017-03-01') AND TIMESTAMP('2017-03-31');;
# }

explore: ga_transactions {
  view_name: ga_ecommerce
  always_filter: {
    filters: {
      field: ga_ecommerce.ecom_action_type
      value: "completed_purchase"
    }
    filters: {
      field: ga_ecommerce.partition_date
      value: "last 30 days"
    }
  }
}

explore: traffic_budget {
   view_name: trafficbudget
}

explore: gmv_revenue_budget {
  view_name: bq_budget_gmv_rev
  view_label: "Orders Budget Projections"
}


explore: ga_sessions_20170805 {
  view_name: ga_sessions_20170805
}


################## @YJ test table structure ##################

### Table Name: Google Analytics Sessions Full
### Explanation: this table has all columns in ga_sessions
### Author: @YJ
### Create Date: 2017-08-29

explore: ga_sessions_version_2{
  # define the
  view_name: ga_sessions_full
  view_label: "Google Analytics Sessions"

  # join with the __custom_dimensions STRUC
  join: ga_sessions_full__custom_dimensions {
    view_label: "Google Analytics Sessions: Custom Dimensions"
  }

  # join with the __hits STRUC
  join: ga_sessions_full__hits {
    view_label: "Google Analytics Sessions: Hits"
  }

  # join: ga_sessions_full__hits {
  #   view_label: "Google Analytics Sessions: Hits"
  #   sql: CROSS JOIN UNNEST(${ga_sessions_full.hits}) AS ga_sessions_full__hits ;;
  # }

  # join with the __totals RECORD
  join: ga_sessions_full__totals {
    view_label: "Google Analytics Sessions: Totals"
    sql: LEFT JOIN UNNEST([${ga_sessions_full.totals}]) AS ga_sessions_full__totals ;;
    relationship: one_to_many
  }

  # join with the __traffic_source RECORD
  join: ga_sessions_full__traffic_source {
    view_label: "Google Analytics Sessions: Traffic Source"
    sql: LEFT JOIN UNNEST([${ga_sessions_full.traffic_source}]) AS ga_sessions_full__traffic_source;;
    relationship: one_to_many
  }

  # join with the __device RECORD
  join: ga_sessions_full__device {
    view_label: "Google Analytics Sessions: Device"
    sql: LEFT JOIN UNNEST([${ga_sessions_full.device}]) AS ga_sessions_full__device;;
    relationship: one_to_many
  }

  # join with the __geo_network RECORD
  join: ga_sessions_full__geo_network{
    view_label: "Google Analytics Sessions: Geo-network"
    sql:  LEFT JOIN UNNEST([${ga_sessions_full.geo_network}]) AS ga_sessions_full__geo_network ;;
    relationship:  one_to_many
  }
}
##############################################################



explore: funnel_report_21_c {
  # define the
  view_name: funnel_report_21_c
  view_label: "Funnel Report 21 Century"

}
