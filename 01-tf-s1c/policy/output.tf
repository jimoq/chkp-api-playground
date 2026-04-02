output "pod_id_output" {
  value = "${random_id.id.b64_url}"
  description = "Your random genereated pod ID"
}

