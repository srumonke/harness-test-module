# Use a specific version of the Harness provider
terraform {
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

# 1. Calling the Root Module
module "harness_test_module" {
  # Format: <HOST>/<ACCOUNT>/<MODULE>/<SYSTEM>
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness"
  version = "1.0.0"
  
  org_name = "test-organization"
}

# 2. Calling a Submodule
module "rbac_submodule" {
  # Format: <HOST>/<ACCOUNT>/<MODULE>/<SYSTEM>//<PATH_TO_SUBMODULE>
  # REQUIRED: The "harness" system name must be before the "//"
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness//modules/rbac"
  version = "1.0.0"
  
  org_id          = module.harness_test_module.organization_id
  user_group_name = "platform-team"
}