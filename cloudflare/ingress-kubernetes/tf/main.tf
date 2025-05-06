terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.4.0"
    }
  }
}

provider "cloudflare" {
  # Configuration options 
  # create the api token in cloudflare
    # export CLOUDFLARE_API_TOKEN=your_token
}

resource "cloudflare_zero_trust_access_application" "wordpress_admin" {
  name       = var.app_name
  type       = "self_hosted"
  account_id = var.account_id
  zone_id    = var.zone_id
  domain     = var.app_domain //ap-admin when login is don
  session_duration = "24h"
  app_launcher_visible = true
  policies = [{
    name       = "Allow from Spain only the traffic"
    precedence = 1
    decision   = "allow"
    include = [{
      geo = {
        country_code = "ES"
      }
    }]
  }]
}