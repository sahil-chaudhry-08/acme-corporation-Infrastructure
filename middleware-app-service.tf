resource "azurerm_windows_web_app" "middleware_webapp" {
  name                = var.middleware_webapp_name
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.middleware_service_plan.id
  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v7.0"
    }

  }
  public_network_access_enabled = var.middleware_public_access
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.middleware_app_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.middleware_app_insights.connection_string
  }
}

resource "azurerm_application_insights" "middleware_app_insights" {
  name                = var.middleware_app_insights
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
}

resource "azurerm_private_dns_zone" "middleware_private_dns_zone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "middleware_dns_zone_virtual_network_link" {
  name                  = "middleware-dnszonelink-name"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.middleware_private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
}

resource "azurerm_private_endpoint" "middleware_private_endpoint" {
  name                = "middleware-webappprivateendpoint"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = azurerm_subnet.middleware_subnet.id

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.middleware_private_dns_zone.id]
  }

  private_service_connection {
    name                           = "privateendpointconnection"
    private_connection_resource_id = azurerm_windows_web_app.middleware_webapp.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}