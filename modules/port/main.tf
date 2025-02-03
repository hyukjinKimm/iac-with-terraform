terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"  # 올바른 프로바이더 소스
      version = "~> 1.5"  # 원하는 버전 지정
    }
  }
}
resource "openstack_networking_port_v2" "this" {
  name            = var.name
  network_id      = var.network_id
  admin_state_up  = true
  security_group_ids = var.security_group_ids  # security_group_ids로 수정

  # fixed_ip 설정 (고정 IP 할당)
  fixed_ip {
    subnet_id = var.subnet_id
    # 원하는 IP를 명시적으로 지정할 수도 있음
    ip_address = var.ip_address
  }

  timeouts {
    create = "30m"
  }
}
