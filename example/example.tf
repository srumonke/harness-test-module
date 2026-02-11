provider "harness" {
  endpoint   = "https://app.harness.io/gateway"
  account_id = "T_JG6UCfQcye3MFhGUx3tw"
}

# Root module - creates organization
module "harness_test_module" {
  # Format: <HOSTNAME>/<ACCOUNT_ID>/<MODULE_NAME>/<SYSTEM>
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness"
  version = "1.0.0"
  
  org_name        = "test-organization"
  org_description = "Test organization created via module registry"
}

# Submodule - creates user group
module "rbac_submodule" {
  # FIXED: Removed the extra double-quotes
  # Format: <HOSTNAME>/<ACCOUNT_ID>/<MODULE_NAME>/<SYSTEM>//<SUBMODULE_PATH>
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness//modules/rbac"
  version = "1.0.0"
  
  org_id          = module.harness_test_module.organization_id
  user_group_name = "platform-team"
  description     = "Platform engineering team"
}