resource "azurerm_storage_share" "default" {
  name                 = "cinst-share-${var.key}"
  quota                = "200"
  storage_account_name = var.storage_account.name
}

resource "azurerm_container_group" "default" {
  name                = "cinst-${var.key}"
  location            = var.common.location
  resource_group_name = var.common.resource_group.name
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "cinst-${var.key}"
    image  = "mcr.microsoft.com/azure-dev-cli-apps:latest"
    cpu    = 1.0
    memory = 2.0
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
  }
}
