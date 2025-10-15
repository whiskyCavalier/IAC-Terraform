locals {
  name = "${var.project_name}-gcp-prod"
  tags = { Project = var.project_name, Env = "prod", Cloud = "gcp" }
}

module "network" {
  source  = "../../modules/gcp/network"
  name    = local.name
  project = var.project
  region  = var.region
}

module "function_api" {
  source  = "../../modules/gcp/function_api"
  name    = local.name
  project = var.project
  region  = var.region
}
