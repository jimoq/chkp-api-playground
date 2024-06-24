resource "checkpoint_management_host" "azurelbhealthcheck" {
      ipv4_address = "168.63.129.16"
      name = "${random_id.id.b64_url}-azure_lb_health_check"
      color = "light green"
      ignore_warnings = "true"
      nat_settings = {
        auto_rule = false
        }
      }

resource "checkpoint_management_host" "internallb" {
      ipv4_address = "10.99.1.11"
      name = "${random_id.id.b64_url}-internallb"
      color = "blue"
      ignore_warnings = "true"
      nat_settings = {
        auto_rule = false
        }
      }

resource "checkpoint_management_host" "rdphost" {
      ipv4_address = "10.99.11.4"
      name = "${random_id.id.b64_url}-rdphost"
      color = "red"
      ignore_warnings = "true"
      nat_settings = {
        auto_rule = false
        }
      }

