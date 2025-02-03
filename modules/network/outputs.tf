output "network_id" {
  description = "The ID of the created network"
  value       = openstack_networking_network_v2.k8s_internal.id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = openstack_networking_subnet_v2.k8s_internal_subnet.id
}
