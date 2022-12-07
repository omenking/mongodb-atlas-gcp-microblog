provider "google" {
  project     = "cruddur"
  region      = "us-east1"
}

resource "google_cloud_run_service" "my_service" {
  provider = google

  metadata {
    name = "frontend"
  }

  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/cruddur/backend-sinatra/backend-sinatra:latest"
      }
    }
  }
}