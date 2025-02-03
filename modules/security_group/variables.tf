variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "rule"
}

variable "security_group_description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow all inbound traffic"
}
