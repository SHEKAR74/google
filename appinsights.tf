resource "azurerm_application_insights" "guardian" {
  name                       = var.app_insights_settings.app_insights_name
  location                   = var.location
  resource_group_name        = data.azurerm_resource_group.guardian.name
  workspace_id               = azurerm_log_analytics_workspace.guardian.id
  application_type           = "web"
  retention_in_days          = 90
  internet_ingestion_enabled = true
  internet_query_enabled     = true
}

resource "azurerm_application_insights_api_key" "guardian" {
  name                    = "guardian-appinsightsapikey"
  application_insights_id = azurerm_application_insights.guardian.id
  read_permissions        = ["aggregate", "api", "draft", "extendqueries", "search"]
}
