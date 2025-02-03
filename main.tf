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
  network_name = "k8s-internal"
  cidr_range  = "192.168.0.0/16"
}

# 보안 그룹
module "security_group" {
  source = "./modules/security_group"
}

# 포트 모듈 정의
module "controller_internal_port" {
  source      = "./modules/port"
  name        = "controller_internal_port"
  network_id  = module.k8s_network.network_id
  security_group_ids = [module.security_group.security_group_id]
  subnet_id   = module.k8s_network.subnet_id
  ip_address  = "192.168.10.10"
}

module "worker_1_internal_port" {
  source      = "./modules/port"
  name        = "worker_1_internal_port"
  network_id  = module.k8s_network.network_id
  security_group_ids = [module.security_group.security_group_id]
  subnet_id   = module.k8s_network.subnet_id
  ip_address  = "192.168.10.20"
}
module "worker_2_internal_port" {
  source      = "./modules/port"
  name        = "worker_2_internal_port"
  network_id  = module.k8s_network.network_id
  security_group_ids = [module.security_group.security_group_id]
  subnet_id   = module.k8s_network.subnet_id
  ip_address  = "192.168.10.30"
}
module "storage_internal_port" {
  source      = "./modules/port"
  name        = "storage_internal_port"
  network_id  = module.k8s_network.network_id
  security_group_ids = [module.security_group.security_group_id]
  subnet_id   = module.k8s_network.subnet_id
  ip_address  = "192.168.10.40"
}
# 인스턴스 모듈 정의
module "controller" {
  source      = "./modules/instance"
  name        = "controller"
  image_id    = "7666e39a-b7c4-4cd1-b10b-2e3cb28fc221"
  flavor_id   = data.openstack_compute_flavor_v2.k8s_flavor.id
  key_pair    = "lab"
  security_groups = [module.security_group.security_group_id]
  network_id  = data.openstack_networking_network_v2.infra_net.id
  port_id     = module.controller_internal_port.port_id

  hostname    = "node1.example.com"
  ip          = "192.169.10.10/16"
  user_data_path = "./scripts/master_data.tpl"

  depends_on = [
    module.worker-1,
    module.worker-2,
    module.storage
  ]
}
module "worker-1" {
  source      = "./modules/instance"
  name        = "worker-1"
  image_id    = "7666e39a-b7c4-4cd1-b10b-2e3cb28fc221"
  flavor_id   = data.openstack_compute_flavor_v2.k8s_flavor.id
  key_pair    = "lab"
  security_groups = [module.security_group.security_group_id]
  network_id  = data.openstack_networking_network_v2.infra_net.id
  port_id     = module.worker_1_internal_port.port_id

  hostname    = "node2.example.com"
  ip          = "192.169.10.20/16"
  user_data_path = "./scripts/worker_data.tpl"
}
module "worker-2" {
  source      = "./modules/instance"
  name        = "worker-2"
  image_id    = "7666e39a-b7c4-4cd1-b10b-2e3cb28fc221"
  flavor_id   = data.openstack_compute_flavor_v2.k8s_flavor.id
  key_pair    = "lab"
  security_groups = [module.security_group.security_group_id]
  network_id  = data.openstack_networking_network_v2.infra_net.id
  port_id     = module.worker_2_internal_port.port_id

  hostname    = "node3.example.com"
  ip          = "192.169.10.30/16"
  user_data_path = "./scripts/worker_data.tpl"
}
module "storage" {
  source      = "./modules/instance"
  name        = "storage"
  image_id    = "7666e39a-b7c4-4cd1-b10b-2e3cb28fc221"
  flavor_id   = data.openstack_compute_flavor_v2.k8s_flavor.id
  key_pair    = "lab"
  security_groups = [module.security_group.security_group_id]
  network_id  = data.openstack_networking_network_v2.infra_net.id
  port_id     = module.storage_internal_port.port_id

  hostname    = "storage.example.com"
  ip          = "192.169.10.40/16"
  user_data_path = "./scripts/worker_data.tpl"
}