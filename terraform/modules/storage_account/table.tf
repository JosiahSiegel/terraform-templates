resource "azurerm_storage_table" "default" {
  name                 = "table${var.common.env}"
  storage_account_name = azurerm_storage_account.default.name
}

resource "azurerm_storage_table_entity" "example" {
  storage_table_id = azurerm_storage_table.default.id

  partition_key = "table${var.common.env}partition"
  row_key       = "table${var.common.env}row"

  entity = {
    example = "table${var.common.env}example"
  }
}

resource "azurerm_role_assignment" "la_table" {
  scope                = azurerm_storage_account.default.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = var.logic_app_id
}
