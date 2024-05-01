resource "azurerm_private_endpoint" "default" {
  name                = "acctest-privatelink-test03"
  location                        = var.common.location
  resource_group_name             = var.common.resource_group.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_dns_zone_group {
    name                 = "acctest-dzg-test03"
    private_dns_zone_ids = [azurerm_private_dns_zone.finance.id]
  }

  private_service_connection {
    name                           = "acctest-privatelink-pschsc-test03"
    private_connection_resource_id = azurerm_cosmosdb_postgresql_cluster.default.id
    subresource_names              = ["coordinator"]
    is_manual_connection           = false
  }
}
