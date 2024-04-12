resource "azurerm_storage_container" "default" {
  name                  = "container-${var.common.env}"
  storage_account_name  = azurerm_storage_account.default.name
  container_access_type = "private"
}
