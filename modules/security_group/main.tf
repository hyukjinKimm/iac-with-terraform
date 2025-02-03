terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"  # 올바른 프로바이더 소스
      version = "~> 1.5"  # 원하는 버전 지정
    }
  }
}

resource "openstack_networking_secgroup_v2" "rule" {
  name        = var.security_group_name
  description = var.security_group_description
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  security_group_id = openstack_networking_secgroup_v2.rule.id
}

resource "openstack_networking_secgroup_rule_v2" "udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  security_group_id = openstack_networking_secgroup_v2.rule.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.rule.id
}

resource "openstack_networking_secgroup_rule_v2" "allow_all_inbound" {
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.rule.id
  protocol          = null
  remote_ip_prefix  = "0.0.0.0/0"
}
