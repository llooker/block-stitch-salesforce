project_name: "block-stitch-salesforce"

################ Constants ################

constant:  CONFIG_PROJECT_NAME {
  value: "block-stitch-salesforce-config"
  export:  override_required
}

constant: CONNECTION_NAME {
  value: "salesforce connection name"
  export: override_required
}

constant: SALESFORCE_SCHEMA_NAME {
  value: "salesforce schema name"
  export: override_required
}

constant: SALESFORCE_ACCOUNT_TABLE_NAME {
  value: "sf_account"
  export: override_required
}

constant: SALESFORCE_CAMPAIGN_TABLE_NAME {
  value: "sf_campaign"
  export: override_required
}

constant: SALESFORCE_CONTACT_TABLE_NAME {
  value: "sf_contact"
  export: override_required
}

constant: SALESFORCE_LEAD_TABLE_NAME {
  value: "sf_lead"
  export: override_required
}

constant: SALESFORCE_OPPORTUNITY_TABLE_NAME {
  value: "sf_opportunity"
  export: override_required
}

constant: SALESFORCE_USER_TABLE_NAME {
  value: "sf_user"
  export: override_required
}

################ Dependencies ################

local_dependency: {
  project: "@{CONFIG_PROJECT_NAME}"

  override_constant: CONNECTION_NAME {
    value: "@{CONNECTION_NAME}"
  }

  override_constant: SALESFORCE_SCHEMA_NAME {
    value: "@{SALESFORCE_SCHEMA_NAME}"
  }

  override_constant: SALESFORCE_ACCOUNT_TABLE_NAME {
    value: "@{SALESFORCE_ACCOUNT_TABLE_NAME}"
  }

  override_constant: SALESFORCE_CAMPAIGN_TABLE_NAME {
    value: "@{SALESFORCE_CAMPAIGN_TABLE_NAME}"
  }

  override_constant: SALESFORCE_CONTACT_TABLE_NAME {
    value: "@{SALESFORCE_CONTACT_TABLE_NAME}"
  }

  override_constant: SALESFORCE_LEAD_TABLE_NAME {
    value: "@{SALESFORCE_LEAD_TABLE_NAME}"
  }

  override_constant: SALESFORCE_OPPORTUNITY_TABLE_NAME {
    value: "@{SALESFORCE_OPPORTUNITY_TABLE_NAME}"
  }

  override_constant: SALESFORCE_USER_TABLE_NAME {
    value: "@{SALESFORCE_USER_TABLE_NAME}"
  }

}
