locals {
  name = "${var.project_name}-az-dev"
  tags = { Project = var.project_name, Env = "dev", Cloud = "azure" }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name}-rg"
  location = var.location
  tags     = local.tags
}

module "network" {
  source              = "../../modules/azure/network"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = "10.20.0.0/16"
  tags                = local.tags
}

module "function_api" {
  source              = "../../modules/azure/function_api"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_ids          = module.network.subnet_ids
  tags                = local.tags
}

output "url" { value = module.function_api.url }
