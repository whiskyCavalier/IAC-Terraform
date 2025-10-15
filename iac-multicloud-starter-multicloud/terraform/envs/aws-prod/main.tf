locals {
  name = "${var.project_name}-aws-prod"
  tags = { Project = var.project_name, Env = "prod", Cloud = "aws" }
}

module "network" {
  source     = "../../modules/aws/network"
  name       = local.name
  cidr_block = "10.10.0.0/16"
  azs        = var.azs
  tags       = local.tags
}

module "lambda_api" {
  source     = "../../modules/aws/lambda_api"
  name       = local.name
  vpc_id     = module.network.network_id
  subnet_ids = module.network.private_subnet_ids
  tags       = local.tags
}
