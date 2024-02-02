# data "azurerm_resource_group" "guardian" {
#   name = "rg-genaisppi-dev-westeu-001"
# }

# data "azurerm_subnet" "existing_redis_cache_subnet" {
#   name                 = var.redis_cache_settings.redis_subnet_name
#   virtual_network_name = var.redis_cache_settings.redis_vnet_name
#   resource_group_name  = var.redis_cache_settings.vnet_rg_name
# }

data "azurerm_subnet" "existing_pe_subnet" {
  name                 = var.redis_cache_settings.pe_subnet_name
  virtual_network_name = var.redis_cache_settings.pe_vnet_name
  resource_group_name  = var.redis_cache_settings.vnet_rg_name
}

# NOTE: the Name used for Redis needs to be globally unique
//**********************************************************************************************
resource "azurerm_redis_cache" "rc" {
  name                          = var.redis_cache_settings.rc_name
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.guardian.name
  capacity                      = var.redis_cache_settings.capacity
  family                        = var.redis_cache_settings.family
  sku_name                      = var.redis_cache_settings.sku_name
  enable_non_ssl_port           = var.redis_cache_settings.enable_non_ssl_port
  public_network_access_enabled = var.redis_cache_settings.public_network_access_enabled
#   private_static_ip_address     = var.redis_cache_settings.private_static_ip_address
#   subnet_id = data.azurerm_subnet.existing_redis_cache_subnet.id

  redis_configuration {
    #     rdb_backup_enabled            = true
    #     rdb_backup_frequency          = 60
    #     rdb_backup_max_snapshot_count = 1
    #     rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.str_acc.primary_blob_endpoint};AccountName=${azurerm_storage_account.str_acc.name};AccountKey=${azurerm_storage_account.str_acc.primary_access_key}"
  }
}

// Configure private endpoint for the Redis Cache
//**********************************************************************************************
resource "azurerm_private_endpoint" "redis_cache_private_endpoint" {
  name                = "${azurerm_redis_cache.rc.name}-private-endpoint"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.guardian.name
  subnet_id           = data.azurerm_subnet.existing_pe_subnet.id

  private_dns_zone_group {
    name                 = "privatelink.redis.cache.windows.net"
    private_dns_zone_ids = var.credis_cache_private_dns_zone_ids
  }

  private_service_connection {
    name                           = azurerm_redis_cache.rc.name
    private_connection_resource_id = azurerm_redis_cache.rc.id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }
  
  lifecycle {
    ignore_changes = [ private_dns_zone_group ]
  }
}



//Storage Account Creation
//**********************************************************************************************
# resource "azurerm_storage_account" "str_acc" {
#   name                     = "redissa74"
#   resource_group_name      = "${data.azurerm_resource_group.guardian.name}"
#   location                 = "${var.location}"
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
# }

variable "redis_cache_settings" {
  description = "settings for the redis_cache"
  type = object({
    rc_name                       = string
    capacity                      = number
    family                        = string
    sku_name                      = string
    enable_non_ssl_port           = bool
    public_network_access_enabled = bool
    private_static_ip_address     = bool
    redis_subnet_name             = string
    redis_vnet_name               = string
    pe_subnet_name                = string
    pe_vnet_name                  = string
    vnet_rg_name                  = string

  })
}

variable "credis_cache_private_dns_zone_ids" {
  type    = list(string)
  default = []
}

redis_cache_settings = {
  rc_name                       = "redis-cache-genaiplatform-dev-we-001"
  capacity                      = 3
  family                        = "p"
  sku_name                      = "Premium"
  enable_non_ssl_port           = false
  public_network_access_enabled = false
  private_static_ip_address     = true
  redis_subnet_name             = "sub-d-we1-interaction-44.76.21.64-26"
  redis_vnet_name               = "vnet-d-we1-aim-genai"
  pe_subnet_name                = "sub-d-we1-interaction-44.76.19.0-24"
  pe_vnet_name                  = "vnet-d-we1-aim-genai"
  vnet_rg_name                  = "rg-d-we1-aim-genai-networking"
}



# credis_cache_private_dns_zone_ids = ["/subscriptions/af3995
