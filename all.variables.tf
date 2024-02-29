variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "service_principal_id" {
  description = "Service principal id used for the deployment"
  type        = string
}

#variable "resource_group_name" {
#  description = "Name of the resource group"
#  type        = string
#}

variable "location" {
  description = "Azure region where the resources will be deployed"
  type        = string
}

variable "private_deployment" {
  description = "Flag indicating if the deployment is private"
  type        = bool
}

variable "apim_settings" {
  description = "Settings for Azure API Management"
  type = object({
    apim_name       = string
    apim_sku        = string
    apim_capacity   = number
    publisher_email = string
    publisher_name  = string
    public_ip_name  = string
    openai_sku      = list(string)
    openai_mapping = map(object({
      apikeyRef              = string
      endpoint               = string
      renewalPeriodInMinutes = number
      tokenQuotaPerPeriod    = number
    }))
  })
}

variable "apim_settings_mapping_secrets" {
  description = "Settings for mapping Open AI secrets to Azure API Management"
  type        = string
}

##variable "app_service_plan_settings" {
##  description = "Settings for Azure App Service Plan"
##  type = object({
##    app_service_plan_name     = string
##    sku_name                  = string
##    app_service_plan_capacity = number
##    zone_redundant            = bool
##  })
##}

variable "storage_account_function_settings" {
  description = "Settings for Azure Storage Account"
  type = object({
    storage_account_name             = string
    storage_account_tier             = string
    storage_account_replication_type = string
    storage_account_kind             = string
  })
}

variable "storage_account_config_settings" {
  description = "Settings for Azure Storage Account Configuration"
  type = object({
    storage_account_name             = string
    storage_account_tier             = string
    storage_account_replication_type = string
    storage_account_kind             = string
    container_name                   = string
  })
}

variable "log_analytics_workspace_settings" {
  description = "Settings for Azure Log Analytics Workspace"
  type = object({
    log_analytics_workspace_name = string
  })
}

variable "app_insights_settings" {
  description = "Settings for Azure Application Insights"
  type = object({
    app_insights_name = string
  })
}

variable "cosmosdb_settings" {
  description = "Settings for Azure Cosmos DB"
  type = object({
    cosmosdb_name = string
  })
}

variable "key_vault_settings" {
  description = "Settings for Azure Key Vault"
  type = object({
    kv_name     = string
    kv_sku_name = string
  })
}

variable "function_settings" {
  description = "Settings for Azure Functions"
  type = object({
    function_name = string
  })
}

#variable "vnet_settings" {
#  description = "Settings for Azure Virtual Network"
#  type = object({
#    vnet_name                              = string
#    vnet_address_prefix                    = string
#    app_subnet_name                        = string
#    app_subnet_address_prefix              = string
#    private_endpoint_subnet_name           = string
#    private_endpoint_subnet_address_prefix = string
#    apim_subnet_name                       = string
#    apim_subnet_address_prefix             = string
#    management_subnet_name                 = string
#    management_subnet_address_prefix       = string
#  })
#}

##variable "bot_settings" {
##  description = "Settings for the bot"
##  type = object({
##    bot_services_name       = string
##    bot_webapp_name         = string
##    company_name            = string
##    display_name            = string
##    client_id               = string
##    token_exchange_url      = string
##    apim_default_openai_sku = string
##    openai_deployment       = string
##    app_type                = string
##  })
##}
##
#variable "bot_settings_client_secret" {
#  description = "Settings for the bot client secret"
#  type        = string
#}

##variable "chat_settings" {
##  description = "Settings for the chat"
##  type = object({
##    static_webapp_name      = string
##    static_webapp_client_id = string
##    webapi_webapp_name      = string
##    webapi_webapp_client_id = string
##    openai_api_key          = string
##    openai_deployment       = string
##
##  })
##}

variable "container_registry_settings" {
  description = "Settings for the container registry"
  type = object({
    acr_name = string
    acr_sku  = string
  })
}

variable "acr_private_endpoint_name" {
  description = "Name of the private endpoint used for the container registry"
  type        = string
}

variable "acr_azurerm_monitor_diagnostic_setting_name" {
  description = "Name of the monitor diagnostics for acr"
  type        = string
}

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
