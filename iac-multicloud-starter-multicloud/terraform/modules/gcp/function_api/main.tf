terraform {
  required_providers {
    google  = { source = "hashicorp/google", version = ">= 5.0" }
    archive = { source = "hashicorp/archive", version = ">= 2.4" }
  }
}

data "archive_file" "zip" {
  type        = "zip"
  output_path = "${path.module}/function.zip"
  source {
    content  = <<-PY
      import json
      def hello_http(request):
          return (json.dumps({"message":"pong"}), 200, {"Content-Type":"application/json"})
    PY
    filename = "main.py"
  }
}

resource "google_storage_bucket" "code" {
  name          = "${var.name}-code-${random_id.rand.hex}"
  location      = var.region
  force_destroy = true
  project       = var.project
}

resource "random_id" "rand" { byte_length = 4 }

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = google_storage_bucket.code.name
  source = data.archive_file.zip.output_path
}

resource "google_cloudfunctions_function" "fn" {
  name        = "${var.name}-fn"
  runtime     = "python311"
  region      = var.region
  project     = var.project
  entry_point = "hello_http"
  source_archive_bucket = google_storage_bucket.code.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http = true
  available_memory_mb = 128
}
