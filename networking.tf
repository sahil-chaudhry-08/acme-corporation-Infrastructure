resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "frontend_subnet" {  
  name                 = var.frontend_subnet_name  
  resource_group_name  = azurerm_resource_group.rg.name  
  virtual_network_name = azurerm_virtual_network.virtual_network.name  
  address_prefixes     = [var.frontend_subnet_address_space]
}

resource "azurerm_subnet" "middleware_subnet" {  
  name                 = var.middleware_subnet_name  
  resource_group_name  = azurerm_resource_group.rg.name  
  virtual_network_name = azurerm_virtual_network.virtual_network.name  
  address_prefixes     = [var.middleware_subnet_address_space]
}

resource "azurerm_subnet" "db_subnet" {  
  name                 = var.db_subnet_name  
  resource_group_name  = azurerm_resource_group.rg.name  
  virtual_network_name = azurerm_virtual_network.virtual_network.name  
  address_prefixes     = [var.db_subnet_address_space]
}