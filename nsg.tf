resource "azurerm_network_security_group" "frontend_nsg" {
  name                = "frontend-nsg"
  location            = var.location
  resource_group_name = var.rg_name

}

resource "azurerm_network_security_rule" "frontend_allow_internet" {
  name                        = "AllowInternet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = var.frontend_subnet_address_space
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.frontend_nsg.name
}

resource "azurerm_network_security_rule" "frontend_deny_other_protocols" {
  name                        = "DenyAll"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.frontend_subnet_address_space
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.frontend_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "frontend_attach_subnet" {
  subnet_id                 = azurerm_subnet.frontend_subnet.id
  network_security_group_id = azurerm_network_security_group.frontend_nsg.id
}


resource "azurerm_network_security_group" "middleware_nsg" {
  name                = "middleware-nsg"
  location            = var.location
  resource_group_name = var.rg_name

}

resource "azurerm_network_security_rule" "middleware_allow_from_frontend" {
  name                        = "AllowFrontend"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = var.middleware_subnet_address_space
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.middleware_nsg.name
}

resource "azurerm_network_security_rule" "middleware_deny_other_protocols" {
  name                        = "DenyAll"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.middleware_subnet_address_space
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.middleware_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "middleware_attach_subnet" {
    subnet_id                 = azurerm_subnet.middleware_subnet.id
    network_security_group_id = azurerm_network_security_group.middleware_nsg.id
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

}

resource "azurerm_network_security_rule" "db_allow_from_middleware" {
  name                        = "AllowMiddleware"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "*"
  destination_address_prefix  = var.db_subnet_address_space
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.db_nsg.name
}

resource "azurerm_network_security_rule" "db_deny_other_protocols" {
  name                        = "DenyAll"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.db_subnet_address_space
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.db_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "db_attach_subnet" {
    subnet_id                 = azurerm_subnet.db_subnet.id
    network_security_group_id = azurerm_network_security_group.db_nsg.id
}
