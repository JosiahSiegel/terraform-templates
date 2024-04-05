data "azurerm_client_config" "default" {
}

data "azurerm_resource_group" "default" {
  name = local.env
}

data "azurerm_storage_account" "terraform" {
  name                = "satf${local.env}"
  resource_group_name = data.azurerm_resource_group.default.name
}

data "azurerm_subscription" "default" {
}

resource "azurerm_role_assignment" "dev_roles" {
  for_each = local.dev_roles

  scope                = data.azurerm_resource_group.default.id
  role_definition_name = each.value
  principal_id         = data.azurerm_client_config.default.object_id
}
