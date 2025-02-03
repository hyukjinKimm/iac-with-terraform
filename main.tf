terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.5"
    }
  }
}

provider "openstack" {
  auth_url         = var.openstack_auth_url
  user_name        = var.openstack_user_name
  password         = var.openstack_password
  tenant_id        = var.openstack_tenant_id
  tenant_name      = var.openstack_tenant_name
  user_domain_name = var.openstack_user_domain_name
  region           = var.openstack_region
  insecure         = var.openstack_insecure
}

# 데이터 소스 정의
data "openstack_compute_flavor_v2" "k8s_flavor" {
  name = "m1.medium"
}
data "openstack_networking_network_v2" "infra_net" {
  name = "infra-net"
}
# k8s-internal 네트워크 및 서브넷
module "k8s_network" {
  source      = "./modules/network"
  network_name = "test-internal"
  cidr_range  = "192.169.0.0/16"
}