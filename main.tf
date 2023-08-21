/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1.azurerm_storage_account - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

*/

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.8.0"
    }
  }
}

provider "azurerm" {
  features {}  
}

resource "azurerm_resource_group" "rg" {
  name     = "Terraform_Storage"
  location = "Central India"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "tfstorage19982023"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [ azurerm_resource_group.rg ]
}
resource "azurerm_storage_container" "container" {
  name                  = "container1"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "blob"
  depends_on = [ azurerm_storage_account.storage_account ]
}

resource "azurerm_storage_blob" "maintf" {
  name                   = "main.tf"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = "main.tf"
}