output "port_id" {
  description = "The ID of the created network port"
  value       = openstack_networking_port_v2.this.id
}

output "port_name" {
  description = "The name of the created network port"
  value       = openstack_networking_port_v2.this.name
}
