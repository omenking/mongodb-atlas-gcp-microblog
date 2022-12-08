provider "google" {
  project = "cruddur"
  region  = "us-east1"
}

resource "google_cloud_run_service" "service_backend_sinatra" {
  provider = google

  name     = "backend-sinatra"
  location = "us-east1"


  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/cruddur/backend-sinatra/backend-sinatra:latest"
        env {
          name = "BACKEND_URL"
          value = "https://cruddur.com"
        }
        env {
          name = "FRONTEND_URL"
          value = "https://cruddur.com"
        }
        env {
          name = "MONGO_ATLAS_URL"
          value = var.mongo_atlas_url
        }
        env {
          name = "MONGO_DATABASE"
          value = "cruddur"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service" "service_frontend_react" {
  provider = google

  name     = "frontend-react"
  location = "us-east1"


  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/cruddur/frontend-react/frontend-react:latest"
        env {
          name = "REACT_APP_BACKEND_URL"
          value = "https://cruddur.com"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


data "google_iam_policy" "noauth_backend_sinatra" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

data "google_iam_policy" "noauth_frontend_react" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth_backend_sinatra" {
  location    = google_cloud_run_service.service_backend_sinatra.location
  project     = google_cloud_run_service.service_backend_sinatra.project
  service     = google_cloud_run_service.service_backend_sinatra.name

  policy_data = data.google_iam_policy.noauth_backend_sinatra.policy_data
}

resource "google_cloud_run_service_iam_policy" "noauth_frontend_react" {
  location    = google_cloud_run_service.service_frontend_react.location
  project     = google_cloud_run_service.service_frontend_react.project
  service     = google_cloud_run_service.service_frontend_react.name

  policy_data = data.google_iam_policy.noauth_frontend_react.policy_data
}

resource "google_compute_region_network_endpoint_group" "neg_backend_sinatra" {
  name                  = "neg-backend-sintra"
  network_endpoint_type = "SERVERLESS"
  region                = "us-east1"
  cloud_run {
    service = google_cloud_run_service.service_backend_sinatra.name
  }
}

resource "google_compute_region_network_endpoint_group" "neg_frontend_react" {
  name                  = "neg-frontend-react"
  network_endpoint_type = "SERVERLESS"
  region                = "us-east1"
  cloud_run {
    service = google_cloud_run_service.service_frontend_react.name
  }
}

module "lb-http" {
  source   = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 5.1"

  project           = "cruddur"
  name              = "cruddur-lb"

  url_map  = google_compute_url_map.urlmap.self_link
  create_url_map  = false

  managed_ssl_certificate_domains = ["cruddur.com"]
  ssl                             = true
  https_redirect                  = true

  backends = {
    backend-sinatra = {
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_backend_sinatra.id
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
    frontend-react = {
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_frontend_react.id
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

resource "google_compute_url_map" "urlmap" {
  #matching the name of the lb
  name = "cruddur-urlmap"
  default_service = module.lb-http.backend_services["frontend-react"].self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = module.lb-http.backend_services["frontend-react"].self_link

    path_rule {
      paths = [
        "/api",
        "/api/*"
      ]
      service = module.lb-http.backend_services["backend-sinatra"].self_link
    }
  }
}