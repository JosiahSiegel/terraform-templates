locals {
  env = "demo"
  common = {
    env            = local.env
    uid            = "x7842"
    subscription   = data.azurerm_subscription.default
    location       = "eastus"
    resource_group = data.azurerm_resource_group.default
    sqladmins      = azuread_group.sqladmins
  }
  dev_roles = toset(["Contributor", "Storage Table Data Contributor", "Storage Blob Data Contributor"])
}
