variable "org_id" {
  description = "Harness organization ID"
  type        = string
}

variable "user_group_name" {
  description = "Name of the user group"
  type        = string
}

variable "description" {
  description = "User group description"
  type        = string
  default     = "Managed by Terraform"
}
