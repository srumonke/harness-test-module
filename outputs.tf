output "organization_id" {
  description = "The organization ID"
  value       = harness_platform_organization.this.id
}

output "organization_name" {
  description = "The organization name"
  value       = harness_platform_organization.this.name
}

output "user_group_id" {
  description = "The user group ID from submodule"
  value       = module.rbac.user_group_id
}
