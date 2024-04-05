resource "azurerm_storage_account" "default" {
  name                          = "sa${var.common.env}${var.common.uid}"
  location                      = var.common.location
  resource_group_name           = var.common.resource_group.name
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  is_hns_enabled                = true
}
