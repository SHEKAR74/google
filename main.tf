# resource "azurerm_resource_group" "test_ase_rg" {
#   name     = var.resource_group_name
#   location = var.location
# }

resource "azurerm_container_group" "container_group" {
  name                = var.container_group_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = var.ip_address_type
  dns_name_label      = var.dns_name_label
  os_type             = var.os_type

  container {
    name   = var.container_name
    image  = var.image_name
    cpu    = var.cpu_core_number
    memory = var.memory_size

    ports {
      port     = var.port_number
      protocol = var.port_protocol
    }
  }
}



# resource "azurerm_container_group" "containergroup" {
#   # for_each = var.container_group_name
#   # for_each            = toset( var.container_group_name )
#   name                = var.container_group_name
#   resource_group_name = azurerm_resource_group.test-ase-rg.name
#   location            = azurerm_resource_group.test-ase-rg.location
#   ip_address_type     = var.ip_address_type
#   dns_name_label      = var.dns_name_label
#   os_type             = var.os_type

#   container {
#     name   = var.container_name
#     image  = var.image_name
#     cpu    = var.cpu_core_number
#     memory = var.memory_size

#     ports {
#       port     = var.port_number
#       protocol = "TCP"
#     }
#   }
# }