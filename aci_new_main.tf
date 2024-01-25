data "azurerm_container_registry" "existing_acr" {
  name                = "aimdemoregistryallianz"
  resource_group_name = "rg-genaisppi-dev-westeu-001"
}

data "azurerm_subnet" "container_subnet" {
  name = "sub-d-we1-interaction-44.76.18.0-24"
  resource_group_name = "rg-d-we1-aim-genai-networking"
  virtual_network_name = "vnet-d-we1-aim-genai"
}


resource "azurerm_container_group" "sppi-web-frontend" {
  name                = var.container_frontend_settings.container_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  ip_address_type     = "Private"
  subnet_ids          = [data.azurerm_subnet.container_subnet.id]
  os_type             = "Linux"

  container {
    name   = var.container_frontend_settings.container_name
    image  = var.container_frontend_settings.image_name
    cpu    = var.container_frontend_settings.cpu_resources
    memory = var.container_frontend_settings.memory_resources

    ports {
      port     = var.container_frontend_settings.port_number
      protocol = "TCP"
    }
  }
  image_registry_credential {
    server   = data.azurerm_container_registry.existing_acr.login_server
    username = data.azurerm_container_registry.existing_acr.admin_username
    password = data.azurerm_container_registry.existing_acr.admin_password
  }
}

resource "azurerm_container_group" "sppi-prompt-flow" {
  name                = var.container_promptflow_settings.container_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  ip_address_type     = "Private"
  subnet_ids          = [data.azurerm_subnet.container_subnet.id]
  //dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = var.container_promptflow_settings.container_name
    image  = var.container_promptflow_settings.image_name
    cpu    = var.container_promptflow_settings.cpu_resources
    memory = var.container_promptflow_settings.memory_resources

    ports {
      port     = var.container_promptflow_settings.port_number
      protocol = "TCP"
    }
  }
  image_registry_credential {
    server   = data.azurerm_container_registry.existing_acr.login_server
    username = data.azurerm_container_registry.existing_acr.admin_username
    password = data.azurerm_container_registry.existing_acr.admin_password
  }
}

resource "azurerm_container_group" "data-manager" {
  name                = var.container_datamanager_settings.container_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  ip_address_type     = "Private"
  subnet_ids          = [data.azurerm_subnet.container_subnet.id]
  os_type             = "Linux"

  container {
    name   = var.container_datamanager_settings.container_name
    image  = var.container_datamanager_settings.image_name
    cpu    = var.container_datamanager_settings.cpu_resources
    memory = var.container_datamanager_settings.memory_resources

    ports {
      port     = var.container_datamanager_settings.port_number
      protocol = "TCP"
    }
  }
  image_registry_credential {
    server   = data.azurerm_container_registry.existing_acr.login_server
    username = data.azurerm_container_registry.existing_acr.admin_username
    password = data.azurerm_container_registry.existing_acr.admin_password
  }
}
