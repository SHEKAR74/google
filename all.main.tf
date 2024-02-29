terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.64.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.40"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  # TODO: Create a storage account and container for remote state

  # backend "azurerm" {
  #   resource_group_name  = "guardian"
  #   storage_account_name = "guardianstorage"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    }
    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }
  }
}

# refer to a resource group
data "azurerm_resource_group" "guardian" {
  name = "rg-genaisppi-dev-westeu-001"
}

# refer to a resource group
data "azurerm_resource_group" "guardian_rgnetwork" {
  name = "rg-d-we1-aim-genai-networking"
}

# refer to a vnet
data "azurerm_virtual_network" "guardian_vnet" {
  name                = "vnet-d-we1-aim-genai"
  resource_group_name = data.azurerm_resource_group.guardian_rgnetwork.name
}

data "azurerm_subnet" "app" {
  name                 = "sub-d-we1-interaction-44.76.18.0-24"
  virtual_network_name = data.azurerm_virtual_network.guardian_vnet.name
  resource_group_name  = data.azurerm_resource_group.guardian_rgnetwork.name
}

data "azurerm_subnet" "private_endpoint" {
  name                 = "sub-d-we1-interaction-44.76.19.0-24"
  virtual_network_name = data.azurerm_virtual_network.guardian_vnet.name
  resource_group_name  = data.azurerm_resource_group.guardian_rgnetwork.name
}

data "azurerm_subnet" "apim" {
  name                 = "sub-d-we1-interaction-44.76.20.0-24"
  virtual_network_name = data.azurerm_virtual_network.guardian_vnet.name
  resource_group_name  = data.azurerm_resource_group.guardian_rgnetwork.name
}
