resource "azurerm_storage_share" "default" {
  name                 = "cinst-share-${var.key}"
  quota                = var.share_gb
  storage_account_name = var.storage_account.name
  access_tier          = var.share_tier
}

resource "azurerm_container_group" "default" {
  name                = "cinst-${var.key}"
  location            = var.common.location
  resource_group_name = var.common.resource_group.name
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "cinst-${var.key}"
    image  = var.image
    cpu    = var.cpu_cores
    memory = var.mem_gb
    commands = [
      "/bin/bash",
      "-c",
      "sleep infinity"
    ]
    ports {
      port     = 22
      protocol = "TCP"
    }
    volume {
      name                 = "storage"
      storage_account_name = var.storage_account.name
      storage_account_key  = var.storage_account.primary_access_key
      share_name           = azurerm_storage_share.default.name
      read_only            = false
      mount_path           = "/mnt/storage"
    }
    volume {
      name = "repo"
      git_repo {
        url = "https://github.com/JosiahSiegel/terraform-templates.git"
      }
      mount_path = "/app"
    }
  }
}
