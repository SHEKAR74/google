resource "azurerm_storage_account" "config" {
  name                     = var.storage_account_config_settings.storage_account_name
  resource_group_name      = data.azurerm_resource_group.guardian.name
  location                 = var.location
  account_tier             = var.storage_account_config_settings.storage_account_tier
  account_replication_type = var.storage_account_config_settings.storage_account_replication_type
  account_kind             = var.storage_account_config_settings.storage_account_kind

  network_rules {
    default_action             = var.private_deployment ? "Deny" : "Allow"
    bypass                     = var.private_deployment ? ["None"] : ["AzureServices"]
    virtual_network_subnet_ids = var.private_deployment ? [data.azurerm_subnet.private_endpoint.id] : []
  }
}

# TODO: Manage creation in private
resource "azurerm_storage_container" "config" {
  count                 = var.private_deployment ? 0 : 1
  name                  = var.storage_account_config_settings.container_name
  storage_account_name  = azurerm_storage_account.config.name
  container_access_type = "private"
}


resource "azurerm_private_endpoint" "storage_config_blob" {
  count               = var.private_deployment ? 1 : 0
  name                = "pe-${azurerm_storage_account.config.name}-blob"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id
  private_service_connection {
    name                           = "psc-${azurerm_storage_account.config.name}-blob"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.config.id
    subresource_names              = ["blob"]
  }
  ##private_dns_zone_group {
  ##  name                 = "default"
  ##  private_dns_zone_ids = [azurerm_private_dns_zone.blob[0].id]
  ##}
}

resource "azurerm_private_endpoint" "storage_config_queue" {
  count               = var.private_deployment ? 1 : 0
  name                = "pe-${azurerm_storage_account.config.name}-queue"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id
  private_service_connection {
    name                           = "psc-${azurerm_storage_account.config.name}-queue"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.config.id
    subresource_names              = ["queue"]
  }
  ##private_dns_zone_group {
  ##  name                 = "default"
  ##  private_dns_zone_ids = [azurerm_private_dns_zone.queue[0].id]
  ##}
} ##

resource "azurerm_private_endpoint" "storage_config_table" {
  count               = var.private_deployment ? 1 : 0
  name                = "pe-${azurerm_storage_account.config.name}-table"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id
  private_service_connection {
    name                           = "psc-${azurerm_storage_account.config.name}-table"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.config.id
    subresource_names              = ["table"]
  }
  ##private_dns_zone_group {
  ##  name                 = "default"
  ##  private_dns_zone_ids = [azurerm_private_dns_zone.table[0].id]
  ##}
}

resource "azurerm_private_endpoint" "storage_config_file" {
  count               = var.private_deployment ? 1 : 0
  name                = "pe-${azurerm_storage_account.config.name}-file"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id
  private_service_connection {
    name                           = "psc-${azurerm_storage_account.config.name}-file"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.config.id
    subresource_names              = ["file"]
  }
  ##private_dns_zone_group {
  ##  name                 = "default"
  ##  private_dns_zone_ids = [azurerm_private_dns_zone.file[0].id]
  ##}
}
