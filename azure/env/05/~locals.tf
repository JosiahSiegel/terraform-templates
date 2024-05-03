variable "environment" {}
variable "owner_object_id" {}
variable "owner_email" {}
variable "uid" {}
variable "location" {}
variable "resource_group" {}

locals {
  env = var.environment
  common = {
    env            = local.env
    uid            = var.uid
    subscription   = data.azurerm_subscription.default
    tenant_id      = data.azurerm_subscription.default.tenant_id
    location       = var.location
    resource_group = data.azurerm_resource_group.default
    owner_email    = var.owner_email
    owner          = data.azuread_users.owner.users[0]
  }
  storage_accounts = {
    dev = {
      account_tier = "Standard"
    }
  }
  container_instances = {
    dev = {
      storage_account_key = "dev"
      image               = "mcr.microsoft.com/azure-dev-cli-apps:latest"
      cpu_cores           = 2
      mem_gb              = 4
      share_gb            = 500
      share_tier          = "TransactionOptimized"
    }
  }
  dev_roles = toset(["Contributor", "Storage Blob Data Contributor"])
}
