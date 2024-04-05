# terraform -chdir=terraform/env/logic_app_sa_table apply -refresh-only
# terraform -chdir=terraform/env/logic_app_sa_table state show module.logic_app.azurerm_logic_app_workflow.default
resource "azurerm_logic_app_workflow" "default" {
  name                = "la-${var.common.env}"
  location            = var.common.location
  resource_group_name = var.common.resource_group.name

  parameters = {
    "$connections" = jsonencode(
      {
        azuretables = {
          connectionId   = "${var.common.subscription.id}/resourceGroups/${var.common.resource_group.name}/providers/Microsoft.Web/connections/azuretables"
          connectionName = "azuretables"
          connectionProperties = {
            authentication = {
              type = "ManagedServiceIdentity"
            }
          }
          id = "${var.common.subscription.id}/providers/Microsoft.Web/locations/eastus/managedApis/azuretables"
        }
      }
    )
  }

  workflow_parameters = {
    "$connections" = jsonencode(
      {
        defaultValue = {}
        type         = "Object"
      }
    )
    "entity" = jsonencode(
      {
        defaultValue = {
          PartitionKey = "tabledemopartition"
          RowKey       = "tabledemorow04"
          example      = "tabledemoexample"
          test         = true
        }
        type = "Object"
      }
    )
    "storageaccount" = jsonencode(
      {
        defaultValue = var.storage_account.name
        type         = "String"
      }
    )
    "tablename" = jsonencode(
      {
        defaultValue = "tabledemo"
        type         = "String"
      }
    )
  }

  identity {
    type = "SystemAssigned"
  }
}

data "template_file" "la-workflow" {
  template = file("${path.module}/workflow.json")
}

resource "azurerm_resource_group_template_deployment" "la-workflow" {
  depends_on = [azurerm_logic_app_workflow.default]

  name                = "la-${var.common.env}-workflow"
  resource_group_name = var.common.resource_group.name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "workflows_la_demo_name" = {
      value = azurerm_logic_app_workflow.default.name
    },
    "storage_account_name" = {
      value = var.storage_account.name
    },
    "connections_azuretables_externalid" = {
      value = "${var.common.subscription.id}/resourceGroups/${var.common.resource_group.name}/providers/Microsoft.Web/connections/azuretables"
    },
    "azuretables_api_id" = {
      value = "${var.common.subscription.id}/providers/Microsoft.Web/locations/eastus/managedApis/azuretables"
    }
  })

  template_content = data.template_file.la-workflow.template
}
