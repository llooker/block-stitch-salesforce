# preliminaries #

connection: "@{CONNECTION_NAME}"

include: "*.view.lkml"
include: "*.explore.lkml"
include: "*.dashboard.lookml"
include: "//@{CONFIG_PROJECT_NAME}/*.view.lkml"
include: "//@{CONFIG_PROJECT_NAME}/*.model.lkml"
include: "//@{CONFIG_PROJECT_NAME}/*.dashboard"

# views to explore——i.e., "base views" #

explore: account {
  extends: [account_config]
}

explore: lead {
  extends: [lead_config]
}

explore: opportunity {
  extends: [opportunity_config]
}
