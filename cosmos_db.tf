resource "azurerm_cosmosdb_account" "guardian" {
  name                                  = var.cosmosdb_settings.cosmosdb_name
  location                              = var.location
  resource_group_name                   = data.azurerm_resource_group.guardian.name
  offer_type                            = "Standard"
  kind                                  = "GlobalDocumentDB"
  enable_automatic_failover             = false
  enable_multiple_write_locations       = false
  is_virtual_network_filter_enabled     = var.private_deployment ? true : false
  analytical_storage_enabled            = false
  public_network_access_enabled         = var.private_deployment ? false : true
  network_acl_bypass_for_azure_services = true


  dynamic "virtual_network_rule" {
    for_each = var.private_deployment ? [1] : []
    content {
      id = data.azurerm_subnet.private_endpoint.id
    }
  }

  identity {
    type = "SystemAssigned"

  }
  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = var.location
    failover_priority = 0
    zone_redundant    = false
  }

  backup {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
    storage_redundancy  = "Local"
  }
}

resource "azurerm_cosmosdb_sql_database" "guardian" {
  name                = "guardian-backend"
  resource_group_name = data.azurerm_resource_group.guardian.name
  account_name        = azurerm_cosmosdb_account.guardian.name
}

resource "azurerm_cosmosdb_sql_container" "guardian" {
  name                  = "quotas"
  resource_group_name   = data.azurerm_resource_group.guardian.name
  account_name          = azurerm_cosmosdb_sql_database.guardian.account_name
  database_name         = azurerm_cosmosdb_sql_database.guardian.name
  partition_key_path    = "/partitionKey"
  partition_key_version = 2
  default_ttl           = 31536000

  indexing_policy {
    indexing_mode = "consistent"

    excluded_path {
      path = "/*"
    }

    excluded_path {
      path = "/_etag/?"
    }
  }

  conflict_resolution_policy {
    mode                     = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }
}

resource "azurerm_key_vault_access_policy" "cosmos_to_kv" {
  key_vault_id = azurerm_key_vault.guardian.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_cosmosdb_account.guardian.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}

resource "azurerm_key_vault_secret" "cosmos" {
  name         = "GuardianCosmosConnectionString"
  value        = azurerm_cosmosdb_account.guardian.connection_strings[0]
  key_vault_id = azurerm_key_vault.guardian.id

  depends_on = [azurerm_key_vault_access_policy.sp_to_kv]
}

resource "azurerm_private_endpoint" "cosmos" {
  count               = var.private_deployment ? 1 : 0
  name                = "pe-${azurerm_cosmosdb_account.guardian.name}-documents"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id ###TODO: check if its correct
  private_service_connection {
    name                           = "psc-${azurerm_cosmosdb_account.guardian.name}-blob"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.guardian.id
    subresource_names              = ["sql"]
  }
  ##private_dns_zone_group {
  ##  name                 = "default"
  ##  private_dns_zone_ids = [azurerm_private_dns_zone.documents[0].id]
  ##}
}
