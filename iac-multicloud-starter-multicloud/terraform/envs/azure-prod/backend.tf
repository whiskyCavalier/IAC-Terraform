terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "yourtfstateacct"
    container_name       = "tfstate"
    key                  = "iac-mc/azure/prod/terraform.tfstate"
  }
}
