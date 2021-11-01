view: user {
  sql_table_name: @{SALESFORCE_SCHEMA_NAME}.@{SALESFORCE_USER_TABLE_NAME} ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  #   - dimension: about_me
  #     type: string
  #     sql: ${TABLE}.aboutme

  dimension: account_id {
    type: string
    hidden: yes
    sql: ${TABLE}.accountid ;;
  }

  dimension: alias {
    type: string
    sql: ${TABLE}.alias ;;
  }

  dimension: badge_text {
    type: string
    sql: ${TABLE}.badgetext ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: community_nickname {
    type: string
    sql: ${TABLE}.communitynickname ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.companyname ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.createdbyid ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.createddate ;;
  }

  dimension: default_group_notification_frequency {
    type: string
    sql: ${TABLE}.defaultgroupnotificationfrequency ;;
  }

  dimension: digest_frequency {
    type: string
    sql: ${TABLE}.digestfrequency ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_encoding_key {
    type: string
    sql: ${TABLE}.emailencodingkey ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: forecast_enabled {
    type: yesno
    sql: ${TABLE}.forecastenabled ;;
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.isactive ;;
  }

  dimension: language_locale_key {
    type: string
    sql: ${TABLE}.languagelocalekey ;;
  }

  dimension_group: last_login {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastlogindate ;;
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

  dimension: last_name {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension_group: last_password_change {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastpasswordchangedate ;;
  }

  dimension_group: last_referenced {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastreferenceddate ;;
  }

  dimension_group: last_viewed {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastvieweddate ;;
  }

  dimension: locale_sid_key {
    type: string
    sql: ${TABLE}.localesidkey ;;
  }

  dimension: mobile_phone {
    type: string
    sql: ${TABLE}.mobilephone ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postalcode ;;
  }

  dimension: profile_id {
    type: string
    sql: ${TABLE}.profileid ;;
  }

  dimension: receives_admin_info_emails {
    type: yesno
    sql: ${TABLE}.receivesadmininfoemails ;;
  }

  dimension: receives_info_emails {
    type: yesno
    sql: ${TABLE}.receivesinfoemails ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street {
    type: string
    sql: ${TABLE}.street ;;
  }

  dimension_group: system_modstamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.systemmodstamp ;;
  }

  dimension: time_zone_sid_key {
    type: string
    sql: ${TABLE}.timezonesidkey ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: user_role_id {
    type: string
    sql: ${TABLE}.userroleid ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.usertype ;;
  }

  filter: name_select {
    suggest_dimension: name
  }

#   filter: department_select {
#     suggest_dimension: department
#   }


  # rep_comparitor currently depends on "account.business_segment" instead of the intended
  # "department" field. If a custom user table attribute "department" exists,
  # replace business_segment with it.
  dimension: rep_comparitor {
    sql: CASE
        WHEN {% condition name_select %} ${name} {% endcondition %}
          THEN ${name}
      ELSE 'Rest of Sales Team'
      END
       ;;
  }


  # measures #

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average_revenue_pipeline {
    type: number
    sql: ${opportunity.total_pipeline_revenue}/ NULLIF(${count},0) ;;
    value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
    drill_fields: [account.name, opportunity.type, opportunity.closed_date, opportunity.total_acv]
  }

  set: opportunity_set {
    fields: [average_revenue_pipeline]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      username,
      company_name,
      first_name,
      last_name,
      name,
      company_name,
      community_nickname
    ]
  }
}
