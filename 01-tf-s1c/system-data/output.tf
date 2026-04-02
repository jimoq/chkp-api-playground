output "generated_api_key" {
  value     = checkpoint_management_add_api_key.example.api_key
  #sensitive = true
  description = "The API key generated for the Application-api-Admin administrator"
}
