variable "container_group_name_1" {
  description = "The name of the container group"
}

variable "dns_name_label_1" {
  description = "The DNS label/name for the container groups IP"
}

variable "ip_address_type_1" {
  description = "IP address type"
  default     = "Public"
  type        = string
}

variable "os_type_1" {
  default     = "Linux"
  description = "The OS for the container group. Allowed values are Linux and Windows"
}

variable "subnet_ids_1" {
  default     = []
  type        = list(string)
  description = " (Optional) The subnet resource IDs for a container group. Changing this forces a new resource to be created."
}

variable "container_name_1" {
  description = "The name of the container"
}

variable "image_name_1" {
  description = "The container image name"
}

variable "cpu_core_number_1" {
  default     = "0.5"
  description = "The required number of CPU cores of the containers"
}

variable "memory_size_1" {
  default     = "1.5"
  description = "The required memory of the containers in GB"
}

variable "port_number_1" {
  default     = "80"
  description = "A public port for the container"
}

variable "port_protocol_1" {
  default     = "TCP"
  description = "A protocol for the container"
}

variable "container_group_name_2" {
  description = "The name of the container group"
}

variable "dns_name_label_2" {
  description = "The DNS label/name for the container groups IP"
}

variable "ip_address_type_2" {
  description = "IP address type"
  default     = "Public"
  type        = string
}

variable "os_type_2" {
  default     = "Linux"
  description = "The OS for the container group. Allowed values are Linux and Windows"
}

variable "subnet_ids_2" {
  default     = []
  type        = list(string)
  description = " (Optional) The subnet resource IDs for a container group. Changing this forces a new resource to be created."
}

variable "container_name_2" {
  description = "The name of the container"
}

variable "image_name_2" {
  description = "The container image name"
}

variable "cpu_core_number_2" {
  default     = "0.5"
  description = "The required number of CPU cores of the containers"
}

variable "memory_size_2" {
  default     = "1.5"
  description = "The required memory of the containers in GB"
}

variable "port_number_2" {
  default     = "80"
  description = "A public port for the container"
}

variable "port_protocol_2" {
  default     = "TCP"
  description = "A protocol for the container"
}

variable "container_group_name_3" {
  description = "The name of the container group"
}

variable "dns_name_label_3" {
  description = "The DNS label/name for the container groups IP"
}

variable "ip_address_type_3" {
  description = "IP address type"
  default     = "Public"
  type        = string
}

variable "os_type_3" {
  default     = "Linux"
  description = "The OS for the container group. Allowed values are Linux and Windows"
}

variable "subnet_ids_3" {
  default     = []
  type        = list(string)
  description = " (Optional) The subnet resource IDs for a container group. Changing this forces a new resource to be created."
}

variable "container_name_3" {
  description = "The name of the container"
}

variable "image_name_3" {
  description = "The container image name"
}

variable "cpu_core_number_3" {
  default     = "0.5"
  description = "The required number of CPU cores of the containers"
}

variable "memory_size_3" {
  default     = "1.5"
  description = "The required memory of the containers in GB"
}

variable "port_number_3" {
  default     = "80"
  description = "A public port for the container"
}
variable "port_protocol_3" {
  default     = "TCP"
  description = "A protocol for the container"
}

variable "container_instance_diagnostics" {
  description = "(Optional) Diagnostic settings for those resources that support it."
  type        = object({ logs = list(string), metrics = list(string) })
  default = {
    logs    = ["Alllogs"]
    metrics = ["AllMetrics"]
  }
}
