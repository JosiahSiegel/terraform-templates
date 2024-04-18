#!/bin/bash

set -e

# Prompt for the path to the environment directory
read -p "Enter the template environment (01): " env_path

# Prompt for resource group name
read -p "Enter the resource group name: " resource_group_name

# Prompt for the environment value
read -p "Enter the environment nickname (demo, prod, etc): " environment

# Convert the environment value to lowercase and remove special characters and spaces
environment=$(echo "$environment" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]')

# Generate a random alphanumeric string of length 3
random_suffix=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 3 | head -n 1)

# Set variables for the key values
storage_account_name="sa${environment}${random_suffix}"
container_name="terraformstate"
state_file_key="terraform.tfstate"
use_azuread_auth=false

# Prompt for the location value
read -p "Enter the location (eastus, westus, etc): " location

# Prompt for the owner email
read -p "Enter the owner email: " owner_email

# Generate the _override.tf.json file
cat > "azure/env/$env_path/_override.tf.json" <<EOL
{
  "terraform": {
    "backend": {
      "azurerm": {
        "resource_group_name": "$resource_group_name",
        "storage_account_name": "$storage_account_name",
        "container_name": "$container_name",
        "key": "$state_file_key",
        "use_azuread_auth": $use_azuread_auth
      }
    }
  },
  "variable": {
    "environment": {
      "default": "$environment"
    },
    "uid": {
      "default": "$random_suffix"
    },
    "location": {
      "default": "$location"
    },
    "owner_email": {
      "default": "$owner_email"
    },
    "resource_group": {
      "default": "$resource_group_name"
    }
  }
}
EOL

# Create the storage account
az storage account create --name "$storage_account_name" --resource-group "$resource_group_name" --location "$location" --sku 'Standard_LRS' -o 'none'

# Create the storage container
az storage container create --account-name "$storage_account_name" -n "$container_name" --only-show-errors -o 'none'
