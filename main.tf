# --- PROVIDER & QUOTAS ---
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

# --- VARIABLES ---
variable "org_name" {
  type        = string
  description = "Name of the organization"
}

variable "user_group_name" {
  type        = string
  default     = "platform-team"
  description = "Name of the user group to create via submodule"
}

# --- RESOURCES ---
resource "harness_platform_organization" "this" {
  identifier  = "simple_org_test"
  name        = var.org_name
  description = "Simple organization created via unified main.tf"
  tags        = ["managed-by:terraform"]
}

# --- SUBMODULE CALL FROM REGISTRY ---
module "rbac" {
  # Format: <HOST>/<ACCOUNT>/<MODULE>/harness//modules/rbac
  source  = "app.harness.io/T_JG6UCfQcye3MFhGUx3tw/harness_test_module/harness//modules/rbac"
  version = "1.1.0"
  
  org_id          = harness_platform_organization.this.id
  user_group_name = var.user_group_name
}

# --- OUTPUTS ---
output "org_id" {
  value = harness_platform_organization.this.id
}

output "user_group_id" {
  value = module.rbac.user_group_id
}