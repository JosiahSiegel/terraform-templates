data "azuread_users" "owner" {
  object_ids = [var.owner_object_id]
}

data "azurerm_resource_group" "default" {
  name = var.resource_group
}

data "azurerm_subscription" "default" {
}