# Nested Looker Modeling Cheat Cheat



1. Build Views from scrach and define date-partition filters:
* ```
derived_table: {
    sql:
      SELECT
        *
      FROM
        `api-project-1065928543184.96922533.ga_sessions*`
      WHERE
        {% condition date_filter %} _TABLE_SUFFIX {% endcondition %};;
}
```

2. Choose the parent view which will be used for joining with other nested views:
* ```
explore: expore_name {
    view_name: parent_view
    view_label: "Parent View Name"
  }
```
3. Connect the parent view with the RECORD view
* ```
join: parent_view__record_view_i {
  view_label: "Parent View Name: RECORD View #i Name"
  sql: LEFT JOIN UNNEST([${parent_view.record_view_i}]) AS parent_view__record_view_i ;;
  relationship: ...
  }
  ```

4. Choose the *relationship* between parent view and record views
* ```
join: parent_view__record_view_i {
  ...
  relationship: one_to_one
  }
  ```
  There are four different type of relationships:
  *| Relationship       | Definition          |
  |:------------------:|---------------------|
  |*one_to_one*        |If one row in the explore can only match one row in the joined view. Repeated non-nested Object|
  |*many_to_one*       |If many rows in the explore can match one row in the joined view.   |
  |*one_to_many*       |If one row in the explore can match many rows in the joined view. Repeated nested Object|
  |*many_to_many*      |If many rows in the explore can match many rows in the joined view. |


5. Build the date-partitioned views
6. Within, view file, define primary key
  * ```
primary_key: yes
```
7. Update date fields to be a dimension_group (example below)
* ```
dimension_group: modified {
    type: time
    convert_tz: no
    timeframes: [time, date, week, month]
    sql: ${TABLE}.modified_date ;;
  }
  ```

8. Custom Dimensions


  | KPI      | Category          |Action       |Label       |
  |:------------------:|---------------------|---------------------|---------------------|
  |*Purchase Clicks*        |purchase click| | |
  |*Make Offer Clicks*       |make offer click | | |
  |*Contact Dealer Clicks*       |contact dealer|contact dealer clicked | |
  |*Contact Dealer Submits*      |contact dealer|contact dealer submitted | |
