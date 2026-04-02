output "pod_id_output" {
  value = module.policy.pod_id_output
  description = "Your random genereated pod ID"
  depends_on = [ module.policy ]
}

output "generated_api_key" {
  value = module.admins.generated_api_key
  sensitive = true
  description = "The API key generated for the Application-api-Admin administrator"
}