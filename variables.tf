variable "org_identifier" {
  description = "Organization identifier"
  type        = string
  default     = "test_org"
}

variable "org_name" {
  description = "Organization name"
  type        = string
}

variable "org_description" {
  description = "Organization description"
  type        = string
  default     = "Test organization"
}

variable "tags" {
  description = "Tags for the organization"
  type        = set(string) # Change from map(string)
  default     = ["managed-by:terraform"] # Change from map format
}

variable "user_group_name" {
  description = "User group name"
  type        = string
  default     = "test-users"
}
