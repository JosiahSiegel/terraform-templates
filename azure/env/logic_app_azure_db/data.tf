data "azuread_user" "owner" {
  user_principal_name = "josiah0601_gmail.com#EXT#@josiah0601gmail.onmicrosoft.com"
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
  principal_id         = data.azuread_user.owner.object_id
}

resource "azuread_group" "sqladmins" {
  display_name     = "sqladmins-${local.env}"
  owners           = [data.azuread_user.owner.object_id]
  security_enabled = true

  members = [
    data.azuread_user.owner.object_id,
    /* more users */
  ]
}
