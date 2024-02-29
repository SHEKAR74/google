resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_settings.acr_name
  resource_group_name = data.azurerm_resource_group.guardian.name
  location            = var.location
  sku                 = var.container_registry_settings.acr_sku
}

resource "azurerm_private_endpoint" "platform" {
  count               = var.private_deployment ? 1 : 0
  name                = var.acr_private_endpoint_name
  resource_group_name = data.azurerm_resource_group.guardian.name
  location            = var.location
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = var.acr_private_endpoint_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}

resource "azurerm_role_assignment" "acr_push_pull_permissions" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush" # The AcrPush role gives both read and write access to the ACR
  principal_id         = var.service_principal_id
}

resource "azurerm_monitor_diagnostic_setting" "acr_diagnostic" {
  name                       = var.acr_azurerm_monitor_diagnostic_setting_name
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.guardian.id

  enabled_log {
    category = "ContainerRegistryRepositoryEvents"
    retention_policy {
      enabled = true
      days    = 30
    }
  }

  enabled_log {
    category = "ContainerRegistryLoginEvents"
    retention_policy {
      enabled = true
      days    = 30
    }
  }
}
