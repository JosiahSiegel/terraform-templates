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
      account_tier = "Premium"     //Standard, Premium
      account_kind = "FileStorage" //StorageV2, FileStorage, BlockBlobStorage, BlobStorage
    }
  }
  container_instances = {
    dev = {
      storage_account_key = "dev"
      os_type             = "Linux"
      image               = "mcr.microsoft.com/azure-dev-cli-apps:latest"
      cpu_cores           = 2
      mem_gb              = 4
      commands            = ["/bin/bash", "-c", "sleep infinity"]
      exec                = "/bin/bash"
      shares              = { storage = { mount_path = "/mnt/storage", gb = 500, tier = "Premium" } } //TransactionOptimized, Premium, Hot, Cool
      repos               = { terraform-templates = { url = "https://github.com/JosiahSiegel/terraform-templates.git", mount_path = "/app/repo1" }, so2pg = { url = "https://github.com/JosiahSiegel/stackoverflow_in_pg.git", mount_path = "/app/repo2" } }
    }
  }
  dev_roles = ["Contributor", "Storage File Data Privileged Contributor", "Storage File Data SMB Share Elevated Contributor"]
}
