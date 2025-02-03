variable "name" {
  description = "Name of the instance"
  type        = string
}

variable "image_id" {
  description = "ID of the image to use for the instance"
  type        = string
}

variable "flavor_id" {
  description = "ID of the flavor (size) for the instance"
  type        = string
}

variable "key_pair" {
  description = "The key pair to use for SSH access"
  type        = string
}

variable "security_groups" {
  description = "List of security groups to apply to the instance"
  type        = list(string)
}

variable "network_id" {
  description = "ID of the network to attach the instance to"
  type        = string
}

variable "port_id" {
  description = "ID of the network port to attach the instance to"
  type        = string
}
variable "user_data" {
  description = "The user data script to initialize the instance"
  type        = string
  default     = ""
}
variable "hostname" {
  description = "this is hostname"
  type        = string
  default     = ""
}

variable "ip" {
  description = "this is ip"
  type        = string
  default     = ""
}
