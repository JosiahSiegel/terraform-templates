terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    mssql = {
      version = "~> 0.3"
      source = "betr-io/mssql"
    }
  }

  backend "azurerm" {
    resource_group_name  = "demo"
    storage_account_name = "satfdemo"
    container_name       = "terraformstate"
    key                  = "logic_app_azure_db.tfstate"
    use_azuread_auth     = false
  }
}

provider "azurerm" {
  # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  skip_provider_registration = false
  features {
    template_deployment {
      delete_nested_items_during_deletion = false
    }
  }
}

provider "mssql" {}
