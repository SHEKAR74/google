subscription_id = "af3995b4-70cd-41cf-9bf8-8445d0c048bc"
#resource_group_name = "rg-guardian-dev-we-108"
service_principal_id = "ccdfabaa-4a24-4ed5-96a0-434c3838cd6f"
location             = "westeurope"
private_deployment   = true

apim_settings = {
  apim_name       = "apim-guardian-dev-we-108"
  apim_sku        = "Developer_1"
  apim_capacity   = 1
  publisher_email = "aclouvel@microsoft.com"
  publisher_name  = "Lvovan Corp"
  public_ip_name  = "pip-guardian-dev-we-108"
  openai_sku      = ["openai-eu"]
  openai_mapping = {
    "openai-eu" = {
      apikeyRef              = "openai-eu-key"
      endpoint               = "https://openai-dev-we-aclouvel.openai.azure.com/"
      renewalPeriodInMinutes = 4
      tokenQuotaPerPeriod    = 10000
    }
  }
}

apim_settings_mapping_secrets = "{\"openai-eu-key\": \"xxx\"}"

##app_service_plan_settings = {
##  app_service_plan_name     = "asp-guardian-dev-we-108"
##  sku_name                  = "P1v3"
##  app_service_plan_capacity = 1
##  zone_redundant            = false
##}

storage_account_function_settings = {
  storage_account_name             = "stguardianfuncdevwe109"
  storage_account_tier             = "Standard"
  storage_account_replication_type = "LRS"
  storage_account_kind             = "StorageV2"
}

storage_account_config_settings = {
  storage_account_name             = "stguardiandevwe109"
  storage_account_tier             = "Standard"
  storage_account_replication_type = "LRS"
  storage_account_kind             = "StorageV2"
  container_name                   = "config"
}

log_analytics_workspace_settings = {
  log_analytics_workspace_name = "log-guardian-dev-we-109"
}

app_insights_settings = {
  app_insights_name = "appi-guardian-dev-we-109"
}

cosmosdb_settings = {
  cosmosdb_name = "cosmos-guardian-dev-we-109"
}

key_vault_settings = {
  kv_name     = "kvguardiandevwe109"
  kv_sku_name = "standard"
}

function_settings = {
  function_name = "func-guardian-dev-we-109"
}

container_registry_settings = {
  acr_name = "acrguardiandevwe109"
  acr_sku  = "Standard"
}

acr_private_endpoint_name                   = "pe-acr-guardian-dev-we-109"
acr_azurerm_monitor_diagnostic_setting_name = "md-acr-guard-dev-we-109"

##vnet_settings = {
##  vnet_name                              = "vnet-guardian-dev-we-108"
##  vnet_address_prefix                    = "10.0.0.0/16"
##  app_subnet_name                        = "snet-app-guardian-dev-we-108"
##  app_subnet_address_prefix              = "10.0.3.0/24"
##  private_endpoint_subnet_name           = "snet-pe-guardian-dev-we-108"
##  private_endpoint_subnet_address_prefix = "10.0.2.0/24"
##  apim_subnet_name                       = "snet-apim-guardian-dev-we-108"
##  apim_subnet_address_prefix             = "10.0.1.0/24"
##  management_subnet_name                 = "snet-mgnt-guardian-dev-we-108"
##  management_subnet_address_prefix       = "10.0.4.0/24"
##}

##bot_settings = {
##  bot_services_name       = "bot-guardian-dev-we-109"
##  bot_webapp_name         = "app-guardian-dev-we-109"
##  company_name            = "Microsoft"
##  display_name            = "Guardian Enterprise ChatGPT"
##  client_id               = "d936588c-4b35-40f0-8a2a-a4ef1d23fa0c"
##  token_exchange_url      = "api://botid-d936588c-4b35-40f0-8a2a-a4ef1d23fa0c"
##  apim_default_openai_sku = "eu"
##  openai_deployment       = "chat-gpt-35-turbo"
##  app_type                = "MultiTenant"
##}

#bot_settings_client_secret = "xxx"


##chat_settings = {
##  static_webapp_name      = "app-chat-client-guardian-dev-we-108"
##  static_webapp_client_id = "d936588c-4b35-40f0-8a2a-a4ef1d23fa0c"
##  webapi_webapp_name      = "app-chat-webapi-guardian-dev-we-108"
##  webapi_webapp_client_id = "d936588c-4b35-40f0-8a2a-a4ef1d23fa0c"
##  openai_api_key          = "b7edbc2aa154438cbb7b7cf2ac1276ee"
##  openai_deployment       = "chat-gpt-35-turbo"
##}

container_frontend_settings = {
  container_name   = "aci-sppi-webfrontend-dev-we-001"
  image_name       = "aimdemoregistryallianz.azurecr.io/sppi.web.frontend:v1"
  cpu_resources    = "0.5"
  memory_resources = "1.5"
  port_number      = "5000"
}
container_promptflow_settings = {
  container_name   = "aci-sppi-promptflow-dev-we-001"
  image_name       = "aimdemoregistryallianz.azurecr.io/sppi.promptflow:v1"
  cpu_resources    = "0.5"
  memory_resources = "1.5"
  port_number      = "8080"
}
container_datamanager_settings = {
  container_name   = "aci-sppi-datamanager-dev-we-001"
  image_name       = "aimdemoregistryallianz.azurecr.io/sppi.datamanage:v1"
  cpu_resources    = 0.5
  memory_resources = 1.5
  port_number      = 6050
}
