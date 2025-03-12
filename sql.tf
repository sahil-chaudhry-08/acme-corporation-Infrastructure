resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.user_assigned_identity_name
  location            = var.location
  resource_group_name = var.rg_name
}

resource "random_password" "mssql_admin_password" {
  length  = 15
  special = true
  min_lower = 2
  min_upper = 2
  min_numeric = 2
  min_special = 2
}

resource "azurerm_mssql_server" "mssql_server" {
  name                          = var.mssql_server_name
  resource_group_name           = var.rg_name
  location                      = var.location
  version                       = var.sql_version
  administrator_login           = "sqladmin"
  administrator_login_password  = random_password.mssql_admin_password.result
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "mssql_database" {
  name           = var.mssql_database_name
  server_id      = azurerm_mssql_server.mssql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = var.mssql_sku
  zone_redundant = true
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
  }
    # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }

  transparent_data_encryption_key_vault_key_id = azurerm_key_vault_key.sql_key.id
}

resource "azurerm_private_dns_zone" "dnsprivatezonesql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelinksql" {
  name                  = "sqldnszonelink"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.dnsprivatezonesql.name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "sqlprivatendpoint"
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = azurerm_subnet.db_subnet.id

  private_service_connection {
    name                           = "sqlprivateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.mssql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}
