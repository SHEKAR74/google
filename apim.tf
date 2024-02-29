resource "azurerm_public_ip" "apim" {
  count               = var.private_deployment ? 1 : 0
  name                = var.apim_settings.public_ip_name
  resource_group_name = data.azurerm_resource_group.guardian.name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  domain_name_label   = var.apim_settings.apim_name
}

# TODO: check if deploy stv2 each time

resource "azurerm_api_management" "guardian" {
  name                          = var.apim_settings.apim_name
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.guardian.name
  publisher_name                = var.apim_settings.publisher_name
  publisher_email               = var.apim_settings.publisher_email
  sku_name                      = var.apim_settings.apim_sku
  public_network_access_enabled = true
  virtual_network_type          = var.private_deployment ? "Internal" : "None"
  public_ip_address_id          = var.private_deployment ? azurerm_public_ip.apim[0].id : null

  identity {
    type = "SystemAssigned"
  }

  hostname_configuration {
    proxy {
      host_name           = "${var.apim_settings.apim_name}.azure-api.net"
      default_ssl_binding = true
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.private_deployment ? [1] : []
    content {
      subnet_id = data.azurerm_subnet.apim.id
    }
  }

  # TODO: If public deployment deployment, please comment the depends_on below

  #depends_on = [azurerm_subnet_network_security_group_association.apim]
}

resource "azurerm_key_vault_access_policy" "apim_to_kv" {
  key_vault_id = azurerm_key_vault.guardian.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_api_management.guardian.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}
