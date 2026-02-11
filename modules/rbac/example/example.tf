#
# Ready-to-Use Example for app.harness.io
# Replace T_JG6UCfQcye3MFhGUx3tw with your actual account ID
#

terraform {
  required_version = ">= 1.5.7"
  
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "~> 0.40"
    }
  }
}

provider "harness" {
  endpoint   = "https://app.harness.io/gateway"
  account_id = "T_JG6UCfQcye3MFhGUx3tw"
}

# Root module - creates organization
module "harness_test_module" {
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness"
  version = "1.0.0"
  
  org_name        = "test-organization"
  org_description = "Test organization created via module registry"
}

# Submodule - creates user group
module "rbac_submodule" {
  source  = ""app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness//modules/rbac""
  version = "1.0.0"
  
  org_id          = module.harness_test_module.organization_id
  user_group_name = "platform-team"
  description     = "Platform engineering team"
}

# Outputs
output "organization_id" {
  description = "Created organization ID"
  value       = module.harness_test_module.organization_id
}

output "organization_name" {
  description = "Created organization name"
  value       = module.harness_test_module.organization_name
}

output "user_group_id" {
  description = "Created user group ID"
  value       = module.rbac_submodule.user_group_id
}

output "user_group_name" {
  description = "Created user group name"
  value       = module.rbac_submodule.user_group_name
}
