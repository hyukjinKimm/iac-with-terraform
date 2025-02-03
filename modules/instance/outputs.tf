output "instance_id" {
  description = "The ID of the created instance"
  value       = openstack_compute_instance_v2.this.id
}

output "instance_ip" {
  description = "The IP address of the created instance"
  value       = openstack_compute_instance_v2.this.network.0.fixed_ip_v4
}

output "hostname" {
  description = "The hostname of the instance"
  value       = var.hostname
}

output "internal_ip" {
  description = "The IP address of the instance"
  value       = var.ip
}
