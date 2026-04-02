/*resource "checkpoint_management_domain_permissions_profile" "example-profile" {
  name             = "example-profile"
  permission_type  = "customized"
  edit_common_objects = true

  access_control {
    show_policy = true
    policy_layers {
      edit_layers = "By Selected Profile In A Layer Editor"
      app_control_and_url_filtering = true
      content_awareness = true
      firewall = true
      mobile_access = true
    }
    dlp_policy = "Read"
    geo_control_policy = "Read"
  }

  endpoint {
    manage_policies_and_software_deployment = true
    edit_endpoint_policies = true
    policies_installation = true
    edit_software_deployment = true
    software_deployment_installation = true
    allow_executing_push_operations = true
    authorize_preboot_users = true
    recovery_media = true
    remote_help = true
    reset_computer_data = true
  }

  events_and_reports {
    smart_event = "Custom"
    events = "Read"
    policy = "Read"
    reports = true
  }

  gateways {
    smart_update = "Read"
    lsm_gw_db = "Read"
    manage_provisioning_profiles = "Read"
    vsx_provisioning = true
    manage_repository_scripts = "Read"
  }

  management {
    cme_operations = "Read"
    manage_admins = true
    management_api_login = true
    manage_sessions = true
    high_availability_operations = true
    approve_or_reject_sessions = true
    publish_sessions = true
    manage_integration_with_cloud_services = true
  }

  monitoring_and_logging {
    monitoring = "Read"
    management_logs = "Read"
    track_logs = "Read"
    app_and_url_filtering_logs = true
    https_inspection_logs = true
    packet_capture_and_forensics = true
    show_packet_capture_by_default = true
    identities = true
    show_identities_by_default = true
    dlp_logs_including_confidential_fields = true
    manage_dlp_messages = true
  }

  threat_prevention {
    policy_layers = "Read"
    edit_layers = "By Selected Profile In A Layer Editor"
    edit_settings = true
    policy_exceptions = "Read"
    profiles = "Read"
    protections = "Read"
  }

  others {
    client_certificates = true
    edit_cp_users_db = true
    https_inspection = "Read"
    ldap_users_db = "Read"
    user_authority_access = "Read"
    user_device_mgmt_conf = "Read"
  }

  tags = ["tag1", "tag2"]
  color = "blue"
  comments = "Example profile with all parameters"
  ignore_warnings = true
  ignore_errors = false
}*/