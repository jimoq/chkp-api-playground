resource "checkpoint_management_administrator" "Application-api-Admin" { 
  name = "Application-api-Admin"
  color = "orange"
  authentication_method = "api key"
  permissions_profile {
   domain = "SMC User"
   profile = checkpoint_management_domain_permissions_profile.Application-layer-permissions.name
  }
depends_on = [ checkpoint_management_domain_permissions_profile.Application-layer-permissions ]
}

resource "checkpoint_management_add_api_key" "example" {
  admin_name = "Application-api-Admin"
  depends_on = [ checkpoint_management_administrator.Application-api-Admin ]
}