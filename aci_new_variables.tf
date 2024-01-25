variable "container_frontend_settings" {
  type = object({
    container_name = string
    # location = string
    image_name       = string
    cpu_resources    = string
    memory_resources = string
    port_number      = string
  })
}

variable "container_promptflow_settings" {
  type = object({
    container_name = string
    # location = string
    image_name       = string
    cpu_resources    = string
    memory_resources = string
    port_number      = string
  })
}

variable "container_datamanager_settings" {
  type = object({
    container_name = string
    # location = string
    image_name       = string
    cpu_resources    = string
    memory_resources = string
    port_number      = string
  })

}
