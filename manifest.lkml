project_name: "block-stitch-salesforce"

################ Constants ################

constant:  CONFIG_PROJECT_NAME {
  value: "block-stitch-salesforce-config"
  export:  override_required
}

constant: CONNECTION_NAME {
  value: "salesforce_data"
  export: override_required
}

constant: SALESFORCE_SCHEMA_NAME {
  value: "salesforce"
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

}
