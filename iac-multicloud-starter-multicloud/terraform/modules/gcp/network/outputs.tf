output "network_id" { value = google_compute_network.this.id }
output "subnet_ids" { value = [google_compute_subnetwork.subnet1.id, google_compute_subnetwork.subnet2.id] }
