# variables.tf
variable "openstack_auth_url" {
  description = "OpenStack 인증 URL"
  type        = string
}

variable "openstack_user_name" {
  description = "OpenStack 사용자 이름"
  type        = string
}

variable "openstack_password" {
  description = "OpenStack 사용자 비밀번호"
  type        = string
  sensitive   = true # 민감한 정보로 표시
}

variable "openstack_tenant_id" {
  description = "OpenStack 테넌트 ID"
  type        = string
}

variable "openstack_tenant_name" {
  description = "OpenStack 테넌트 이름"
  type        = string
}

variable "openstack_user_domain_name" {
  description = "OpenStack 사용자 도메인 이름"
  type        = string
}

variable "openstack_region" {
  description = "OpenStack 리전"
  type        = string
}

variable "openstack_insecure" {
  description = "OpenStack 인증 시 SSL 검증 무시 여부"
  type        = bool
}