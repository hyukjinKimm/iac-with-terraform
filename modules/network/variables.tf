variable "network_name" {
  description = "Name of the network"
  type        = string
  default     = "k8s-internal"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "k8s-internal"
}

variable "cidr_range" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "192.168.0.0/16"
}
