provider "google" {
  project = "cruddur"
  region  = "us-east1"
}

resource "google_cloud_run_service" "my_service" {
  provider = google

  name     = "backend"
  location = "us-east1"


  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/cruddur/backend-sinatra/backend-sinatra:latest"
        env {
          name = "BACKEND_URL"
          value = "cruddur.com"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = "us-east1"
  cloud_run {
    service = google_cloud_run_service.my_service.name
  }
}


module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 4.5"

  project           = "cruddur"
  name              = "cruddur-lb"

  managed_ssl_certificate_domains = ["cruddur.com"]
  ssl                             = true
  https_redirect                  = true

  backends = {
    default = {
      # List your serverless NEGs, VMs, or buckets as backends
      groups = [
        {
          group = google_compute_region_network_endpoint_group.cloudrun_neg.id
        }
      ]

      enable_cdn = false

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }

      description             = null
      custom_request_headers  = null
      security_policy         = null
    }
  }
}