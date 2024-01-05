

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



// Sets up diagnostics for App Service
//**********************************************************************************************
resource "azurerm_monitor_diagnostic_setting" "cl_app_service_plan_diagnostic_setting" {
  name                       = "${var.env}-${var.postfix}-asp-diag"
  target_resource_id         = azurerm_app_service.cl_app_service.id
  log_analytics_workspace_id = var.cl_app_service_log_analytics_workspace_id

  dynamic "log" {
    for_each = var.cl_app_service_diagnostics.logs
    content {
      category = log.value

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = var.cl_app_service_diagnostics.metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}
//**********************************************************************************************


variable "cl_app_service_log_analytics_workspace_id" {
    description = "(Required) The the log analytics workspace ID for diagnostics."
}
variable "cl_app_service_diagnostics" {
    description = "(Optional) Diagnostic settings for those resources that support it."
    type        = object({ logs = list(string), metrics = list(string) })
    default = {
        logs    = ["AppServiceAntivirusScanAuditLogs", "AppServiceHTTPLogs", "AppServiceConsoleLogs", "AppServiceAppLogs", "AppServiceFileAuditLogs", "AppServiceAuditLogs", "AppServiceIPSecAuditLogs", "AppServicePlatformLogs"]
        metrics = ["AllMetrics"]
    }
}
