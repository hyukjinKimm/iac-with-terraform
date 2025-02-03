output "security_group_id" {
  description = "The ID of the created security group"
  value       = openstack_networking_secgroup_v2.rule.id
}
