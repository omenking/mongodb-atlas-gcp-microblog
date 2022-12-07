provider "google" {
  project     = "cruddur"
  region      = "us-east1"
}

data "google_container_image" "my_image" {
  provider = google
  name     = "us-east1-docker.pkg.dev/cruddur/backend-sinatra/backend-sinatra:latest"
}

resource "google_cloud_run_service" "my_service" {
  provider = google

  metadata {
    name = "frontend"
  }

  template {
    spec {
      containers {
        image = data.google_container_image.my_image.name
      }
    }
  }
}