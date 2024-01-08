//**********************************************************************************************
resource "azurerm_container_group" "container_group_1" {
  name                = var.container_group_name_1
  resource_group_name = data.azurerm_resource_group.guardian.name
  location            = var.location
  ip_address_type     = var.ip_address_type_1
  dns_name_label      = var.dns_name_label_1
  os_type             = var.os_type_1
  subnet_ids          = var.subnet_ids_1

  container {
    name   = var.container_name_1
    image  = var.image_name_1
    cpu    = var.cpu_core_number_1
    memory = var.memory_size_1

    ports {
      port     = var.port_number_1
      protocol = var.port_protocol_1
    }
  }
}

resource "azurerm_container_group" "container_group_2" {
  name                = var.container_group_name_2
  resource_group_name = data.azurerm_resource_group.guardian.name
  location            = var.location
  ip_address_type     = var.ip_address_type_2
  dns_name_label      = var.dns_name_label_2
  os_type             = var.os_type_2
  subnet_ids          = var.subnet_ids_2

  container {
    name   = var.container_name_2
    image  = var.image_name_2
    cpu    = var.cpu_core_number_2
    memory = var.memory_size_2

    ports {
      port     = var.port_number_2
      protocol = var.port_protocol_2
    }
  }
}

resource "azurerm_container_group" "container_group_3" {
  name                = var.container_group_name_3
  resource_group_name = data.azurerm_resource_group.guardian.name
  location            = var.location
  ip_address_type     = var.ip_address_type_3
  dns_name_label      = var.dns_name_label_3
  os_type             = var.os_type_3
  subnet_ids          = var.subnet_ids_3

  container {
    name   = var.container_name_3
    image  = var.image_name_3
    cpu    = var.cpu_core_number_3
    memory = var.memory_size_3

    ports {
      port     = var.port_number_3
      protocol = var.port_protocol_3
    }
  }
}
//**********************************************************************************************

# //**********************************************************************************************
# // Sets up Private Endponit for Container Instaces
# resource "azurerm_private_endpoint" "container_group_1_pe" {
#   name                = "pe-${azurerm_container_group.container_group_1.name}-cont-instance"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.guardian.name
#   subnet_id           = data.azurerm_subnet.private_endpoint.id

#   private_service_connection {
#     name                           = "psc-${azurerm_container_group.container_group_1.name}-cont-instance"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_container_group.container_group_1.id
#     subresource_names              = ["registry"]
#   }
# }

# resource "azurerm_private_endpoint" "container_group_2_pe" {
#   name                = "pe-${azurerm_container_group.container_group_2.name}-cont-instance"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.guardian.name
#   subnet_id           = data.azurerm_subnet.private_endpoint.id

#   private_service_connection {
#     name                           = "psc-${azurerm_container_group.container_group_2.name}-cont-instance"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_container_group.container_group_2.id
#     subresource_names              = ["registry"]
#   }
# }

# resource "azurerm_private_endpoint" "container_group_3_pe" {
#   name                = "pe-${azurerm_container_group.container_group_3.name}-cont-instance"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.guardian.name
#   subnet_id           = data.azurerm_subnet.private_endpoint.id

#   private_service_connection {
#     name                           = "psc-${azurerm_container_group.container_group_3.name}-cont-instance"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_container_group.container_group_3.id
#     subresource_names              = ["registry"]
#   }
# }
# //**********************************************************************************************

# //**********************************************************************************************
# // Sets up diagnostics for Container Instaces
# resource "azurerm_monitor_diagnostic_setting" "container_instance_1_diagnostic_setting" {
#   name                       = "${azurerm_container_group.container_group_1.name}-diag-sett"
#   target_resource_id         = azurerm_container_group.container_group_1.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.guardian.id

#   dynamic "log" {
#     for_each = var.container_instance_diagnostics.logs
#     content {
#       category = log.value

#       retention_policy {
#         enabled = false
#         days    = 90
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = var.container_instance_diagnostics.metrics
#     content {
#       category = metric.value

#       retention_policy {
#         enabled = false
#         days    = 90
#       }
#     }
#   }
# }

# resource "azurerm_monitor_diagnostic_setting" "container_instance_2_diagnostic_setting" {
#   name                       = "${azurerm_container_group.container_group_2.name}-diag-sett"
#   target_resource_id         = azurerm_container_group.container_group_2.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.guardian.id

#   dynamic "log" {
#     for_each = var.container_instance_diagnostics.logs
#     content {
#       category = log.value

#       retention_policy {
#         enabled = false
#         days    = 90
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = var.container_instance_diagnostics.metrics
#     content {
#       category = metric.value

#       retention_policy {
#         enabled = false
#         days    = 90
#       }
#     }
#   }
# }


# resource "azurerm_monitor_diagnostic_setting" "container_instance_3_diagnostic_setting" {
#   name                       = "${azurerm_container_group.container_group_3.name}-diag-sett"
#   target_resource_id         = azurerm_container_group.container_group_3.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.guardian.id

#   dynamic "log" {
#     for_each = var.container_instance_diagnostics.logs
#     content {
#       category = log.value

#       retention_policy {
#         enabled = false
#         days    = 90
#       }
#     }
#   }

#   dynamic "metric" {
#     for_each = var.container_instance_diagnostics.metrics
#     content {
#       category = metric.value

#       retention_policy {
#         enabled = false
#         days    = 90
#       }
#     }
#   }
# }
# //**********************************************************************************************
