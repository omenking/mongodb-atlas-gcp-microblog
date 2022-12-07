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
      }
    }
  }
}