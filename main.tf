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

variable "org_name" {
  type = string
}

resource "harness_platform_organization" "this" {
  identifier  = "simple_org_test"
  name        = var.org_name
  description = "Unified organization"
  tags        = ["managed-by:terraform"]
}

module "rbac" {
  # Note: The version here should match the tag you are about to push
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness"
  version = "1.5.0"
  
  org_id          = harness_platform_organization.this.id
  user_group_name = "platform-team"
}