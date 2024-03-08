# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }

  }
}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
}



variable "labelPrefix" {
  type          = string
  description = "Your college username. This will form the beginning of various resource names."
}

variable "region" {
  default = "westus3"
  type    = string
}



#resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.labelPrefix}-A09-RG"
  location = var.region
}

resource "azurerm_storage_account" "storageacconut" {
  name                     = "${var.labelPrefix}storageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

