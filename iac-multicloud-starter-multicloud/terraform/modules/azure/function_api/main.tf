terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.100.0" }
    archive = { source = "hashicorp/archive", version = ">= 2.4" }
    random  = { source = "hashicorp/random",  version = ">= 3.6" }
  }
}
provider "azurerm" { features {} }

resource "random_integer" "suffix" { min = 10000 max = 99999 }

# Minimal function code (Python) packaged as zip
data "archive_file" "zip" {
  type        = "zip"
  output_path = "${path.module}/function.zip"
  source {
    content  = <<-PY
      import json
      def main(req):
          return { "status": 200, "headers": {"Content-Type":"application/json"}, "body": json.dumps({"message":"pong"}) }
    PY
    filename = "function_app/__init__.py"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = replace("${var.name}sa${random_integer.suffix.result}","-","")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption
}

resource "azurerm_linux_function_app" "fn" {
  name                = "${var.name}-fn"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  site_config {
    application_stack { python_version = "3.10" }
    vnet_route_all_enabled = true
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = data.archive_file.zip.output_path
    "AzureWebJobsFeatureFlags" = "EnableWorkerIndexing"
  }
}
