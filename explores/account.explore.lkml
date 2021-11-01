include: "/views/*.view"

explore: account {
  #   sql_always_where: |
  #     NOT ${account.is_deleted}
  fields: [ALL_FIELDS*, -account_owner.opportunity_set*, -creator.opportunity_set*]

  join: contact {
    sql_on: ${account.id} = ${contact.account_id} ;;
    relationship: one_to_many
  }

  join: creator {
    from: user
    sql_on: ${contact.created_by_id} = ${creator.id} ;;
    relationship: many_to_one
  }

  join: account_owner {
    from: user
    sql_on: ${account.owner_id} = ${account_owner.id} ;;
    relationship: many_to_one
  }
}
