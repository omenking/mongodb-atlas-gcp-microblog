provider "google" {
  project = "cruddur"
  region  = "us-east1"
}

resource "google_cloud_run_service" "service_api" {
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

resource "google_cloud_run_service" "service_frontend" {
  provider = google

  name     = "backend"
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


data "google_iam_policy" "noauth_api" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

data "google_iam_policy" "noauth_frontend" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth_api" {
  location    = google_cloud_run_service.service_api.location
  project     = google_cloud_run_service.service_api.project
  service     = google_cloud_run_service.service_api.name

  policy_data = data.google_iam_policy.noauth_api.policy_data
}

resource "google_cloud_run_service_iam_policy" "noauth_frontend" {
  location    = google_cloud_run_service.service_frontend.location
  project     = google_cloud_run_service.service_frontend.project
  service     = google_cloud_run_service.service_frontend.name

  policy_data = data.google_iam_policy.noauth_frontend.policy_data
}

resource "google_compute_region_network_endpoint_group" "neg_api" {
  name                  = "neg-api"
  network_endpoint_type = "SERVERLESS"
  region                = "us-east1"
  cloud_run {
    service = google_cloud_run_service.service_api.name
  }
}

resource "google_compute_region_network_endpoint_group" "neg_frontend" {
  name                  = "neg-frontend"
  network_endpoint_type = "SERVERLESS"
  region                = "us-east1"
  cloud_run {
    service = google_cloud_run_service.service_frontend.name
  }
}

module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 4.5"

  project           = "cruddur"
  name              = "cruddur-lb"

  url_map  = google_compute_url_map.lb-map.self_link

  managed_ssl_certificate_domains = ["cruddur.com"]
  ssl                             = true
  https_redirect                  = true

  backends = {
    api = {
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_api.id
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
    default = {
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_frontend.id
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

resource "google_compute_url_map" "lb-map" {
  #matching the name of the lb
  name = "cruddur-lb"
  default_service = module.lb-http.backend_services["default"].self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = module.lb-http.backend_services["default"].self_link

    path_rule {
      paths = [
        "/api",
        "/api/*"
      ]
      service = module.lb-http.backend_services["api"].self_link
    }
  }
}