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
  join: bq_budget_gmv_rev {
    type: left_outer
    relationship: one_to_one
    sql_on: ${trafficbudget.date_date}=${bq_budget_gmv_rev.date_date} ;;
    view_label: "Orders Projections"
  }
  label: "Budget and Reforecast"
  view_label: "Budget"
}

explore: gmv_revenue_budget {
  view_name: bq_budget_gmv_rev
  view_label: "Orders Budget Projections"
}





explore: google_analytics_sessions {
  # define the
  view_name: ga_sessions_full
  view_label: "Sessions Summary"

  # join with the __custom_dimensions STRUC
  join: ga_sessions_full__custom_dimensions {
    view_label: "Custom Dimensions"
  }

  # join with the __hits STRUC
  join: ga_sessions_full__hits {
    view_label: "Hits Info"
  }

  # join with the __totals RECORD
  join: ga_sessions_full__totals {
    view_label: "Totals"
    sql: LEFT JOIN UNNEST([${ga_sessions_full.totals}]) AS ga_sessions_full__totals ;;
    relationship: one_to_many
  }

  # join with the __traffic_source RECORD
  join: ga_sessions_full__traffic_source {
    view_label: "Traffic Source"
    sql: LEFT JOIN UNNEST([${ga_sessions_full.traffic_source}]) AS ga_sessions_full__traffic_source;;
    relationship: one_to_many
  }

  # join with the __device RECORD
  join: ga_sessions_full__device {
    view_label: "Device"
    sql: LEFT JOIN UNNEST([${ga_sessions_full.device}]) AS ga_sessions_full__device;;
    relationship: one_to_many
  }

  # join with the __geo_network RECORD
  join: ga_sessions_full__geo_network{
    view_label: "IP Address Info"
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

explore: order_attribution_base {
  view_name: order_attribution_base_data
  view_label: "Order Attribution Base"
}

# In QA ##########
explore: google_analytics_hits {
  # define the
  view_name: ga_hits_full
  view_label: "Basic Info"

  # join with the __custom_dimensions STRUC
  join: ga_hits_full__custom_dimensions {
    view_label: "User Info"
  }

  # join with the __custom_dimensions STRUC
  join: ga_hits_full__hits {
    view_label: "Hits Summary"
    sql: CROSS JOIN UNNEST(${ga_hits_full.hits}) AS ga_hits_full__hits;;
    relationship: one_to_many
  }

  join: ga_hits_full__hits__content_group {
    view_label: "Content Group"
    sql: LEFT JOIN UNNEST([${ga_hits_full__hits.content_group}]) AS ga_hits_full__hits__content_group ;;
    relationship: one_to_many
  }

  join: ga_hits_full__hits__custom_dimensions {
    view_label: "Custom Dimensions"
  }

  join: ga_hits_full__hits__e_commerce_action {
    view_label: "E-commerce Action"
    sql: LEFT JOIN UNNEST([${ga_hits_full__hits.e_commerce_action}]) AS ga_hits_full__hits__e_commerce_action ;;
    sql_where: ${ga_hits_full__hits.e_commerce_action} IS NOT NULL;;
    relationship: one_to_many
  }

  # When hitType == 'EVENT' then populating
  join: ga_hits_full__hits__event_info {
    view_label: "Hit Type: Event Info"
    sql: LEFT JOIN UNNEST([${ga_hits_full__hits.event_info}]) AS ga_hits_full__hits__event_info;;
    sql_where: ${ga_hits_full__hits.hit_type} = 'EVENT' ;;
    relationship: one_to_many
  }

  join: ga_hits_full__hits__page {
    view_label: "Hit Type: Pageview Info"
    sql: LEFT JOIN UNNEST([${ga_hits_full__hits.page}]) AS ga_hits_full__hits__page;;
    sql_where: ${ga_hits_full__hits.hit_type} = 'PAGE';;
    relationship: one_to_many
  }

  join: ga_hits_full__hits__app_info {
    view_label: "Hit Type: Appview Info"
    sql: LEFT JOIN UNNEST([${ga_hits_full__hits.app_info}]) AS ga_hits_full__hits__app_info;;
    sql_where: ${ga_hits_full__hits.hit_type} = 'APPVIEW' ;;
    relationship: one_to_many
  }

  # When hitType == 'PAGE' then populatin
  join: ga_hits_full__hits__pageview_and_appview {
    view_label: "Hit Type: Pageview and Appview Info"
  }

  join: ga_hits_full__hits__social {
    view_label: "Hit Type: Social Info"
    sql: LEFT JOIN UNNEST([${ga_hits_full__hits.social}]) AS ga_hits_full__hits__social;;
    sql_where: ${ga_hits_full__hits.hit_type} = 'SOCIAL' ;;
    relationship: one_to_many
  }

}


explore: ga_dates_list {
  # define the
  view_name: ga_dates_list
  view_label: "GA dates list"
}
