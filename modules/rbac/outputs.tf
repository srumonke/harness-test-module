output "user_group_id" {
  description = "The user group ID"
  value       = harness_platform_usergroup.this.id
}

output "user_group_name" {
  description = "The user group name"
  value       = harness_platform_usergroup.this.name
}
