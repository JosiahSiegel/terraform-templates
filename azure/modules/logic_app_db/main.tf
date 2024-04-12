# terraform -chdir=azure/env/logic_app_sa_table apply -refresh-only
# terraform -chdir=azure/env/logic_app_sa_table state show module.logic_app.azurerm_logic_app_workflow.default
resource "azurerm_logic_app_workflow" "default" {
  name                = "la-${var.common.env}"
  location            = var.common.location
  resource_group_name = var.common.resource_group.name

  identity {
    type = "SystemAssigned"
  }
}
