resource "azurerm_log_analytics_workspace" "guardian" {
  name                = var.log_analytics_workspace_settings.log_analytics_workspace_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
