output "id" {
  value = azurerm_logic_app_workflow.default.identity[0].principal_id
}
