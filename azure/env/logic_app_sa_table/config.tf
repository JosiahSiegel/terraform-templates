terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  backend "azurerm" {
    resource_group_name  = "demo"
    storage_account_name = "satfdemo"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
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
