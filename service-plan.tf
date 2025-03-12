resource "azurerm_service_plan" "frontend_service_plan" {
  name                = var.frontend_service_plan_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_service_plan" "middleware_service_plan" {
  name                = var.middleware_service_plan_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}