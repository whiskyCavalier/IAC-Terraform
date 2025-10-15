terraform {
  required_providers {
    google = { source = "hashicorp/google", version = ">= 5.0" }
  }
}

resource "google_compute_network" "this" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
  project                 = var.project
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "${var.name}-subnet1"
  ip_cidr_range = "10.30.1.0/24"
  region        = var.region
  network       = google_compute_network.this.id
  project       = var.project
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "${var.name}-subnet2"
  ip_cidr_range = "10.30.2.0/24"
  region        = var.region
  network       = google_compute_network.this.id
  project       = var.project
}
