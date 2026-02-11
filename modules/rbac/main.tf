terraform {
  required_version = ">= 1.5.7"
  
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "~> 0.40"
    }
  }
}

# Simple user group resource
resource "harness_platform_usergroup" "this" {
  identifier  = replace(var.user_group_name, "-", "_")
  name        = var.user_group_name
  org_id      = var.org_id
  description = var.description
  
  tags = ["managed-by:terraform", "module:rbac"]
}
