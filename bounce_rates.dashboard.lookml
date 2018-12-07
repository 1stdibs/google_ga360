- dashboard: bounce_rates
  title: Bounce Rates
  layout: tile
  tile_size: 100

  filters:

  elements:


    - name: average_sessions_per_visitor
      title: Average Sessions per Visitor
      type: single_value
      model: bigquery
      explore: ga_sessions_full
      measures: [ga_sessions_full.average_sessions_per_visitor]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        __FILE: google_analytics/bounce_rates.dashboard.lookml
        __LINE_NUM: 137


    - name: unique_visitors
      title: Unique Visitors
      type: single_value
      model: bigquery
      explore: ga_sessions_full
      measures: [ga_sessions_full.unique_visitors]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}

    - name: total_session
      title: Total Sessions
      type: single_value
      model: bigquery
      explore: ga_sessions_full
      measures: [ga_sessions_full.sessions]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}

    - name: total_bounces
      title: Total Bounces
      type: single_value
      model: bigquery
      explore: ga_sessions_full
      measures: [ga_sessions_full.bounces_total]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        __FILE: google_analytics/bounce_rates.dashboard.lookml
        __LINE_NUM: 137


    - name: average_bounce_rate
      title: Average Bounce Rate
      type: single_value
      model: bigquery
      explore: ga_sessions_full
      measures: [ga_sessions_full.bounce_rate]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}



    - name: bounce_rates_over_time
      title: Bounce Rates Over Time
      type: looker_area
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.date_suffix_time]
      measures: [ga_sessions_full.bounce_rate]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      sorts: [ga_sessions_full.date_suffix_time desc]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 7
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      show_null_points: true
      point_style: none
      interpolation: linear
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      ordering: none
      show_null_labels: false
      series_types:
        totals.hits_total: column
      reference_lines: []
      trend_lines: []


    - name: bounce_rates_by_channel
      title: Bounces by Channel
      type: looker_column
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.channel_grouping]
      measures: [ga_sessions_full.bounce_rate, ga_sessions_full.bounces_total]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      sorts: [ga_sessions_full.bounces_total desc]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        ga_sessions_full.bounce_rate: line
      series_colors:
        ga_sessions_full.bounces_total: "#62bad4"
        ga_sessions_full.bounce_rate: "#a9c574"

    - name: bounces_by_browser
      title: Bounces by Browser
      type: looker_column
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.device_browser]
      measures: [ga_sessions_full.bounces_total, ga_sessions_full.bounce_rate]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      sorts: [ga_sessions_full.bounces_total desc]
      limit: '10'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      limit_displayed_rows: false
      y_axis_combined: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: editable
      series_types:
        ga_sessions_full.bounce_rate: line

    - name: bounces_by_visitors
      title: Bounces by Visitor Frequency
      type: looker_column
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.visitnumbertier]
      measures: [ga_sessions_full.bounce_rate, ga_sessions_full.bounces_total]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
        ga_sessions_full.visitnumbertier: "-Below 1"
      sorts: [ga_sessions_full.visitnumbertier]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 7
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        ga_sessions_full.bounce_rate: line
      series_labels: {}

    - name: new_vs_returning_users
      title: New vs. Returning User Sessions
      type: looker_area
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.date_suffix_time]
      measures: [ga_sessions_full.returning_visitors, ga_sessions_full.unique_visitors]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
        ga_sessions_full.visitnumbertier: "-Below 1"
      sorts: [ga_sessions_full.date_suffix_time desc, ga_sessions_full.visitnumbertier__sort_]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      show_null_points: true
      point_style: none
      interpolation: linear
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      ordering: none
      show_null_labels: false
      series_types: {}

    - name: new_vs_returning_bounce_rates_over_time
      title: New vs Returning User Bounce Rates Over Time
      type: looker_line
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.first_time_visitor, ga_sessions_full.date_suffix_time]
      pivots: [ga_sessions_full.first_time_visitor]
      fill_fields: [ga_sessions_full.first_time_visitor]
      measures: [ga_sessions_full.bounce_rate]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
      sorts: [ga_sessions_full.date_suffix_time desc, ga_sessions_full.first_time_visitor]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: false
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      show_null_points: true
      point_style: none
      interpolation: linear
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      ordering: none
      show_null_labels: false
      series_types: {}
      y_axis_unpin: true
      series_labels:
        No - Session Bounce Rate: Return Visitor Bounce Rate
        Yes - Session Bounce Rate: First Time Visitor Bounce Rate

    - name: new_vs_returning_bounce_totals
      title: New vs Returning Bounce Totals
      type: looker_pie
      model: bigquery
      explore: ga_sessions_full
      dimensions: [ga_sessions_full.first_time_visitor]
      fill_fields: [ga_sessions_full.first_time_visitor]
      measures: [ga_sessions_full.bounces_total]
      filters:
        ga_sessions_full.date_suffix_time: 2017-04-27 00:00:00
      sorts: [ga_sessions_full.first_time_visitor]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      value_labels: labels
      label_type: labVal
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: false
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      show_null_points: true
      point_style: none
      interpolation: linear
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      ordering: none
      show_null_labels: false
      series_types: {}
      y_axis_unpin: true
      series_labels:
        No - Session Bounce Rate: Return Visitor Bounce Rate
        Yes - Session Bounce Rate: First Time Visitor Bounce Rate

    - name: top_performing_creators
      title: Top Performing Creators
      type: table
      model: bigquery
      explore: ga_sessions_full
      dimensions: [hits.page_path]
      measures: [ga_sessions_full.sessions, ga_sessions_full.bounces_total, ga_sessions_full.bounce_rate,
        ga_sessions_full.timeonsite_average_per_session, ga_sessions_full.unique_visitors, ga_sessions_full.returning_visitors]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
        hits.page_path: "-NULL"
        hits.pageSubType: "Creator"
      sorts: [ga_sessions_full.sessions desc]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      show_view_names: true
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: gray
      limit_displayed_rows: false
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}


    - name: top_performing_content
      title: Top Performing Articles
      type: looker_bar
      model: bigquery
      explore: ga_sessions_full
      dimensions: [hits.page_path]
      measures: [ga_sessions_full.bounce_rate, ga_sessions_full.sessions]
      filters:
        ga_sessions_full.date_suffix_time: "last 3 days"
        ga_sessions_full.bounce_rate: ">.1"
        hits.pageSubType: "Introspective,The Study"
      sorts: [ga_sessions_full.session_count desc]
      limit: '10'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: true
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        ga_sessions_full.bounce_rate: line
      series_colors:
        ga_sessions_full.bounce_rate: "#a9c574"
        ga_sessions_full.session_count: "#62bad4"
