# Create an Azure SQL Server
resource "azurerm_mssql_server" "default" {
  name                = "sqlserver-${var.common.uid}-${var.common.env}"
  resource_group_name = var.common.resource_group.name
  location            = var.common.location
  version             = "12.0"
  minimum_tls_version = "1.2"

  azuread_administrator {
    login_username              = var.common.sqladmins.display_name
    object_id                   = var.common.sqladmins.object_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }
}

# Create an Azure SQL Database
resource "azurerm_mssql_database" "default" {
  name                        = "db-${var.common.env}"
  server_id                   = azurerm_mssql_server.default.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  license_type                = "LicenseIncluded"
  max_size_gb                 = 10
  read_scale                  = false
  sku_name                    = "S0"
  zone_redundant              = false
  enclave_type                = "VBS"
  #auto_pause_delay_in_minutes = 10

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azuread_directory_role" "db_ad" {
  display_name = "Directory Readers"
}

resource "azuread_directory_role_assignment" "db_ad" {
  role_id             = azuread_directory_role.db_ad.template_id
  principal_object_id = azurerm_mssql_server.default.identity[0].principal_id
}

resource "mssql_user" "la" {
  server {
    host = azurerm_mssql_server.default.fully_qualified_domain_name
    azuread_default_chain_auth {}
  }
  #object_id = var.logic_app_ids.principal_id
  database  = azurerm_mssql_database.default.name
  username  = var.logic_app_name
  roles     = ["db_datareader", "db_datawriter"]
}
