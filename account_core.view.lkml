include: "//@{CONFIG_PROJECT_NAME}/account.view"

view: account {
  extends: [account_config]
}

view: account_core {
  sql_table_name: @{SALESFORCE_SCHEMA_NAME}.sf_account ;;
  # dimensions #

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.accountnumber ;;
  }

  dimension: annual_revenue {
    type: number
    sql: ${TABLE}.annualrevenue ;;
    value_format: "$#,##0"
  }

  dimension: attributes__type {
    type: string
    sql: ${TABLE}.attributes__type ;;
  }

  dimension: billing_city {
    type: string
    sql: ${TABLE}.billingcity ;;
  }

  dimension: billing_country {
    type: string
    sql: ${TABLE}.billingcountry ;;
  }

  dimension: billing_postal_code {
    type: string
    sql: ${TABLE}.billingpostalcode ;;
  }

  dimension: billing_state {
    type: string
    sql: ${TABLE}.billingstate ;;
  }

  dimension: billing_street {
    type: string
    sql: ${TABLE}.billingstreet ;;
  }

  dimension: cleanstatus {
    type: string
    hidden: yes
    sql: ${TABLE}.cleanstatus ;;
  }

  dimension: created_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.createdbyid ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.createddate ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.isdeleted ;;
  }

  dimension: last_modified_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lastmodifiedbyid ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastmodifieddate ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: number_of_employees {
    type: number
    sql: ${TABLE}.numberofemployees ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.ownerid ;;
  }

  dimension: ownership {
    type: string
    hidden: yes
    sql: ${TABLE}.ownership ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  #   - dimension: photo_url
  #     type: string
  #     sql: ${TABLE}.photourl

  dimension: shipping_city {
    type: string
    sql: ${TABLE}.shippingcity ;;
  }

  dimension: shipping_country {
    type: string
    sql: ${TABLE}.shippingcountry ;;
  }

  dimension: shipping_postal_code {
    type: zipcode
    sql: ${TABLE}.shippingpostalcode ;;
  }

  dimension: shipping_state {
    type: string
    sql: ${TABLE}.shippingstate ;;
  }

  dimension: shipping_street {
    type: string
    sql: ${TABLE}.shippingstreet ;;
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

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: business_segment {
    type: string

    case: {
      when: {
        sql: ${number_of_employees} BETWEEN 0 AND 500 ;;
        label: "Small Business"
      }

      when: {
        sql: ${number_of_employees} BETWEEN 501 AND 1000 ;;
        label: "Mid-Market"
      }

      when: {
        sql: ${number_of_employees} > 1000 ;;
        label: "Enterprise"
      }

      else: "Unknown"
    }
  }

  # measures #

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: percent_of_accounts {
    type: percent_of_total
    sql: ${account.count} ;;
  }

  measure: average_annual_revenue {
    type: average
    sql: ${account.annual_revenue} ;;
    value_format: "$#,##0"
  }

  #     filters:
  #       account.is_deleted: -'0'

  measure: total_number_of_employees {
    type: sum
    sql: ${account.number_of_employees} ;;
  }

  #     filters:
  #       account.is_deleted: -'0'

  measure: average_number_of_employees {
    type: average
    sql: ${account.number_of_employees} ;;
  }

  #     filters:
  #       account.is_deleted: -'0'

  measure: count_customers {
    type: count

    filters: {
      field: account.type
      value: "\"Customer\""
    }
  }
}
