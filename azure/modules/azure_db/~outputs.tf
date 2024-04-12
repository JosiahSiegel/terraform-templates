output "id" {
  value = azurerm_mssql_server.default.identity[0].principal_id
}
