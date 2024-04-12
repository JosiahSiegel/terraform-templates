output "ids" {
  value = azurerm_logic_app_workflow.default.identity[0]
}

output "name" {
  value = azurerm_logic_app_workflow.default.name
}
