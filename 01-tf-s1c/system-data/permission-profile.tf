resource "checkpoint_management_domain_permissions_profile" "Application-layer-permissions" {
  name             = "Applications-layer-permissions"
  permission_type  = "customized"
  access_control {
    show_policy = true
    policy_layers {
      edit_layers = "By Selected Profile In A Layer Editor"
    }
  }
}