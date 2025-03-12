resource "azurerm_windows_web_app" "frontend_webapp" {
  name                = var.frontend_webapp_name
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.frontend_service_plan.id
  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v7.0"
    }

  }
  public_network_access_enabled = var.frontend_public_access
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.frontend_app_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.frontend_app_insights.connection_string
  }
}


resource "azurerm_application_insights" "frontend_app_insights" {
  name                = var.frontend_app_insights
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
}

resource "azurerm_app_service_virtual_network_swift_connection" "frontend_app_service_virtual_network_swift_connection" {
  app_service_id = azurerm_service_plan.frontend_service_plan.id
  subnet_id      = azurerm_subnet.frontend_subnet.id
}