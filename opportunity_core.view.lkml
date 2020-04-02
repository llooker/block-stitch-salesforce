include: "//@{CONFIG_PROJECT_NAME}/opportunity.view"

view: opportunity {
  extends: [opportunity_config]
}

view: opportunity_core {
  sql_table_name: @{SALESFORCE_SCHEMA_NAME}.@{SALESFORCE_OPPORTUNITY_TABLE_NAME} ;;
  # dimensions #

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.accountid ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: campaign_id {
    type: string
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: close {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.closedate ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.createdbyid ;;
  }

  dimension_group: created {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.createddate ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: fiscal {
    type: string
    sql: ${TABLE}.fiscal ;;
  }

  dimension: fiscal_quarter {
    type: number
    sql: ${TABLE}.fiscalquarter ;;
  }

  dimension: fiscal_year {
    type: number
    sql: ${TABLE}.fiscalyear ;;
  }

  dimension: forecast_category {
    type: string
    sql: ${TABLE}.forecastcategory ;;
  }

  dimension: forecast_category_name {
    type: string
    sql: ${TABLE}.forecastcategoryname ;;
  }

  dimension: has_opportunity_line_item {
    type: yesno
    sql: ${TABLE}.hasopportunitylineitem ;;
  }

  dimension: is_closed {
    type: yesno
    sql: ${TABLE}.isclosed ;;
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.isdeleted ;;
  }

  dimension: is_private {
    type: yesno
    hidden: yes
    sql: ${TABLE}.isprivate ;;
  }

  dimension: is_won {
    type: yesno
    sql: ${TABLE}.iswon ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.lastmodifiedbyid ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastmodifieddate ;;
  }

  dimension: lead_source {
    type: string
    sql: ${TABLE}.leadsource ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.ownerid ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stagename ;;
  }

  dimension_group: system_modstamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.systemmodstamp ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: is_lost {
    type: yesno
    sql: ${is_closed} AND NOT ${is_won} ;;
  }

  dimension: probability_group {
    case: {
      when: {
        sql: ${probability} = 100 ;;
        label: "Won"
      }

      when: {
        sql: ${probability} > 80 ;;
        label: "Above 80%"
      }

      when: {
        sql: ${probability} > 60 ;;
        label: "60 - 80%"
      }

      when: {
        sql: ${probability} > 40 ;;
        label: "40 - 60%"
      }

      when: {
        sql: ${probability} > 20 ;;
        label: "20 - 40%"
      }

      when: {
        sql: ${probability} > 0 ;;
        label: "Under 20%"
      }

      when: {
        sql: ${probability} = 0 ;;
        label: "Lost"
      }
    }
  }

  dimension_group: created_date {
    type: time
    timeframes:[date,week,month,raw]
    sql: ${TABLE}.createddate;;
  }

  dimension_group: close_date {
    type: time
    timeframes:[date,week,month,raw]
    sql: ${TABLE}.closedate;;
  }

  dimension: days_open {
    type: number
    sql: datediff(days, ${created_date}, coalesce(${close_date}, current_date() ) ;;
  }

  dimension: created_to_closed_in_60 {
    hidden: yes
    type: yesno
    sql: ${days_open} <=60 AND ${is_closed} = 'yes' AND ${is_won} = 'yes' ;;
  }

  # measures #

  measure: count {
    type: count
    drill_fields: [id, name, stage_name, forecast_category_name]
  }


#     filters:
#       opportunity.is_deleted: 0

measure: total_revenue {
  type: sum
  sql: ${amount} ;;
  value_format: "$#,##0"
  #X# Invalid LookML inside "measure": {"filters":null}
}

#       opportunity.is_deleted: 0

measure: average_revenue_won {
  label: "Average Revenue (Closed/Won)"
  type: average
  sql: ${amount} ;;

  filters: {
    field: is_won
    value: "Yes"
  }

  #       is_deleted: 0
  value_format: "$#,##0"
}

measure: average_revenue_lost {
  label: "Average Revenue (Closed/Lost)"
  type: average
  sql: ${amount} ;;

  filters: {
    field: is_lost
    value: "Yes"
  }

  #       is_deleted: 0
  value_format: "$#,##0"
}

measure: total_pipeline_revenue {
  type: sum
  sql: ${amount} ;;

  filters: {
    field: is_closed
    value: "No"
  }

  #       is_deleted: 0
  value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";$0.00"
}

measure: average_deal_size {
  type: average
  sql: ${amount} ;;
  value_format: "$#,##0"
}

#     filters:
#       opportunity.is_deleted: 0

measure: count_won {
  type: count

  filters: {
    field: is_won
    value: "Yes"
  }

  #       is_deleted: 0
  drill_fields: [opportunity.id, account.name, type]
}

measure: average_days_open {
  type: average
  sql: ${days_open} ;;
}

#     filters:
#       opportunity.is_deleted: 0

measure: count_closed {
  type: count

  filters: {
    field: is_closed
    value: "Yes"
  }
}

#       is_deleted: 0

measure: count_open {
  type: count

  filters: {
    field: is_closed
    value: "No"
  }
}

#       is_deleted: 0

measure: count_lost {
  type: count

  filters: {
    field: is_closed
    value: "Yes"
  }

  filters: {
    field: is_won
    value: "No"
  }

  #       is_deleted: 0
  drill_fields: [opportunity.id, account.name, type]
}

measure: win_percentage {
  type: number
  sql: 100.00 * ${count_won} / NULLIF(${count_closed}, 0) ;;
  value_format: "#0.00\%"
}

measure: open_percentage {
  type: number
  sql: 100.00 * ${count_open} / NULLIF(${count}, 0) ;;
  value_format: "#0.00\%"
}

measure: count_new_business_won {
  type: count

  filters: {
    field: is_won
    value: "Yes"
  }

  filters: {
    field: opportunity.type
    value: "\"New Business\""
  }

  #       is_deleted: 0
  drill_fields: [opportunity.id, account.name, type]
}

measure: count_new_business {
  type: count

  filters: {
    field: opportunity.type
    value: "\"New Business\""
  }

  #       is_deleted: 0
  drill_fields: [opportunity.id, account.name, type]
}
}
