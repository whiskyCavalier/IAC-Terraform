terraform {
  backend "gcs" {
    bucket = "your-tf-state-bucket"
    prefix = "iac-mc/gcp/dev"
  }
}
