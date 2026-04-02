terraform {
  required_providers {
    checkpoint = {
      source = "checkpointsw/checkpoint"
    }
  }
}

variable "checkpoint_server" {
  description = "Check Point Management Server FQDN"
  type        = string
}

variable "checkpoint_api_key" {
  description = "API Key for authentication"
  type        = string
  sensitive   = true
}

variable "cloud_mgmt_id" {
  description = "Cloud Management ID"
  type        = string
}

provider "checkpoint" {
  server        = var.checkpoint_server
  api_key       = var.checkpoint_api_key
  context       = "web_api"
  cloud_mgmt_id = var.cloud_mgmt_id
  domain        = "System Data"
  timeout       = 120
}

resource "checkpoint_management_domain_permissions_profile" "api_read" {
  name             = "api-read"
  permission_type  = "read only all"
}

resource "checkpoint_management_administrator" "apikeyadmin" {
  name                  = "apikeyadmin"
  email                 = "apiadmin@gmail.com"
  phone_number          = "1800-800-800"
  authentication_method = "api key"
  permissions_profile   = checkpoint_management_domain_permissions_profile.api_read.name
}

resource "checkpoint_management_api_key" "apikeyadmin_key" {
  admin_name = checkpoint_management_administrator.apikeyadmin.name
}

resource "checkpoint_management_publish" "publish" {
  depends_on = [
    checkpoint_management_domain_permissions_profile.api_read,
    checkpoint_management_administrator.apikeyadmin,
    checkpoint_management_api_key.apikeyadmin_key
  ]
}