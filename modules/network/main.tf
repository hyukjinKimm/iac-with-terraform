terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"  # 올바른 프로바이더 소스
      version = "~> 1.5"  # 원하는 버전 지정
    }
  }
}

resource "openstack_networking_network_v2" "k8s_internal" {
  name           = var.network_name  # 네트워크 이름 변수 사용
  admin_state_up = true              # 관리 상태 활성화
  shared         = false             # 네트워크 공유 설정 (기본값은 false)
}

resource "openstack_networking_subnet_v2" "k8s_internal_subnet" {
  name       = var.subnet_name           # 서브넷 이름 변수 사용
  network_id = openstack_networking_network_v2.k8s_internal.id
  cidr       = var.cidr_range            # 대역대 변수 사용
  ip_version = 4                          # IP 버전 (IPv4)
  enable_dhcp = false                    # DHCP 비활성화
  no_gateway = true
}
