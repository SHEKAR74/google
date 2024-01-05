

# variable "container_group_name" {
#   description = "The name of the container group"
#   type        = map
# }

variable "container_group_name" {
  default     = "myContGroup"
  description = "The name of the container group"
}

variable "resource_group_name" {
  description = "The name of the resource group"
}

variable "location" {
  description = "Azure location"
}

variable "ip_address_type" {
  description = "IP address type"
  default     = "Public"
  type        = string
}

variable "dns_name_label" {
  description = "The DNS label/name for the container groups IP"
}

variable "os_type" {
  default     = "Linux"
  description = "The OS for the container group. Allowed values are Linux and Windows"
}

variable "container_name" {
  description = "The name of the container"
}

variable "image_name" {
  description = "The container image name"
}

variable "cpu_core_number" {
  default     = "0.5"
  description = "The required number of CPU cores of the containers"
}

variable "memory_size" {
  default     = "1.5"
  description = "The required memory of the containers in GB"
}

variable "port_number" {
  default     = "80"
  description = "A public port for the container"
}
variable "port_protocol" {
  default     = "TCP"
  description = "A protocol for the container"
}