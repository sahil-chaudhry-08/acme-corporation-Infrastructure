data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = azurerm_user_assigned_identity.user_assigned_identity.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Get", "List", "Create", "Delete", "Update", "Recover", "Purge", "GetRotationPolicy"]
    secret_permissions = ["Get", "List"]
  }

  access_policy {
    tenant_id = azurerm_user_assigned_identity.user_assigned_identity.tenant_id
    object_id = azurerm_user_assigned_identity.user_assigned_identity.principal_id

    key_permissions    = ["Get", "List", "Create", "WrapKey", "UnwrapKey"]
    secret_permissions = ["Get", "List"]
  }
}

resource "azurerm_key_vault_key" "sql_key" {
  depends_on   = [azurerm_key_vault.key_vault]
  name         = var.sql_key_name
  key_vault_id = azurerm_key_vault.key_vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["unwrapKey", "wrapKey"]
}