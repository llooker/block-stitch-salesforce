include: "//@{CONFIG_PROJECT_NAME}/contact.view"

view: contact {
  extends: [contact_config]
}

view: contact_core {
  sql_table_name: @{SALESFORCE_SCHEMA_NAME}.sf_contact ;;
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

  dimension: assistant_name {
    type: string
    sql: ${TABLE}.assistantname ;;
  }

  #   - dimension: assistant_phone
  #     type: string
  #     sql: ${TABLE}.assistantphone

  dimension_group: birth_date {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.birthdate ;;
  }

  dimension: created_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.createdbyid ;;
  }

  dimension_group: created {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.createddate ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.isdeleted ;;
  }

  dimension: email_bounced {
    type: yesno
    sql: ${TABLE}.isemailbounced ;;
  }

  dimension: last_modified_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lastmodifiedbyid ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.lastmodifieddate ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: lead_source {
    type: string
    sql: ${TABLE}.leadsource ;;
  }

  dimension: mailing_city {
    type: string
    sql: ${TABLE}.mailingcity ;;
  }

  dimension: mailing_country {
    type: string
    sql: ${TABLE}.mailingcountry ;;
  }

  dimension: mailing_postal_code {
    type: string
    sql: ${TABLE}.mailingpostalcode ;;
  }

  dimension: mailing_state {
    type: string
    sql: ${TABLE}.mailingstate ;;
  }

  dimension: mailing_street {
    type: string
    sql: ${TABLE}.mailingstreet ;;
  }

  dimension: mobile_phone {
    type: string
    sql: ${TABLE}.mobilephone ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  #   - dimension: other_city
  #     type: string
  #     sql: ${TABLE}.othercity
  #
  #   - dimension: other_country
  #     type: string
  #     sql: ${TABLE}.othercountry
  #
  #   - dimension: other_phone
  #     type: string
  #     sql: ${TABLE}.otherphone
  #
  #   - dimension: other_postal_code
  #     type: string
  #     sql: ${TABLE}.otherpostalcode
  #
  #   - dimension: other_state
  #     type: string
  #     sql: ${TABLE}.otherstate
  #
  #   - dimension: other_street
  #     type: string
  #     sql: ${TABLE}.otherstreet

  dimension: owner_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ownerid ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: salutation {
    type: string
    sql: ${TABLE}.salutation ;;
  }

  dimension_group: system_modstamp {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.systemmodstamp ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: email_link {
    html: <a href="mailto:{{ contact.email._value }}" target="_blank">
        <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Gmail_Icon.png" width="16" height="16" />
      </a>
      {{ linked_value }}
      ;;
  }

  # measures #

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
