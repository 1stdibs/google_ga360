
view: ga_sessions_test{
  derived_table: {
    sql:
      SELECT
        date AS ga_date,
        visitNumber AS visit_number,
        visitStartTime AS visit_start_time,
        visitorId AS visitor_id
      FROM
        `api-project-1065928543184.96922533.ga_sessions*`
      WHERE
        {% condition date_filter %} TIMESTAMP(date, "America/New_York") {% endcondition %};;
  }

  filter: date_filter {
    type: date
    }

  dimension: ga_date {
    type: date
    convert_tz: yes
    sql: PARSE_DATE('%Y%m%d', ${TABLE}.ga_date);;
  }

  dimension: visit_number {
    type: number
  }

}
