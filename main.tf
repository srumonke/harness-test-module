terraform {
  required_version = ">= 1.5.7"
  
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "~> 0.40"
    }
  }
}

# Simple organization resource
resource "harness_platform_organization" "this" {
  identifier  = var.org_identifier
  name        = var.org_name
  description = var.org_description
  
  tags = var.tags
}

# Use the RBAC submodule
module "rbac" {
  source = "./modules/rbac"
  
  org_id          = harness_platform_organization.this.id
  user_group_name = var.user_group_name
}
