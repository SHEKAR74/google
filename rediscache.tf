resource "azurerm_resource_group" "rg01" {
  name     = "redis-resources"
  location = "West US"
}

data "azurerm_subnet" "existing_redis_cache_subnet" {
  name                 = "default2"
  virtual_network_name = "rc-vnet1"
  resource_group_name  = "redis-resources"
}

data "azurerm_subnet" "existing_pe_subnet" {
  name                 = "default"
  virtual_network_name = "rc-vnet1"
  resource_group_name  = "redis-resources"
}

resource "azurerm_storage_account" "str_acc" {
  name                     = "redissa74"
  resource_group_name      = "${azurerm_resource_group.rg01.name}"
  location                 = "${azurerm_resource_group.rg01.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "cache_01" {
  name                = "tf-redis-pbkup"
  location            = "${azurerm_resource_group.rg01.location}"
  resource_group_name = "${azurerm_resource_group.rg01.name}"
  capacity            = 3
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  public_network_access_enabled = false
  private_static_ip_address = true
  subnet_id = data.azurerm_subnet.existing_redis_cache_subnet.id

  redis_configuration {
    rdb_backup_enabled            = true
    rdb_backup_frequency          = 60
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.str_acc.primary_blob_endpoint};AccountName=${azurerm_storage_account.str_acc.name};AccountKey=${azurerm_storage_account.str_acc.primary_access_key}"
  }
}

// Configure private endpoint for the Redis Cache
//**********************************************************************************************
resource "azurerm_private_endpoint" "redis_cache_private_endpoint" {
  name                = "${var.redis_cache_name}-pe"
  location            = "${azurerm_resource_group.rg01.location}"
  resource_group_name = "${azurerm_resource_group.rg01.name}"
  subnet_id           = data.azurerm_subnet.existing_pe_subnet.id

  private_dns_zone_group {
    name = "privatelink.redis.cache.windows.net"
    private_dns_zone_ids  = var.credis_cache_private_dns_zone_ids
  }

  private_service_connection {
    name                           = azurerm_redis_cache.cache_01.name
    private_connection_resource_id = azurerm_redis_cache.cache_01.id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }
}
