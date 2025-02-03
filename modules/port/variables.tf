variable "name" {
  description = "The name of the network port"
  type        = string
}

variable "network_id" {
  description = "The ID of the network the port will belong to"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security groups to apply to the network port"
  type        = list(string)
}

variable "subnet_id" {
  description = "The ID of the subnet for the port"
  type        = string
}

variable "ip_address" {
  description = "The specific IP address to assign to the port (optional)"
  type        = string
  default     = ""
}
