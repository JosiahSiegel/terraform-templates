#!/bin/bash

set -e

# Prompt for the path to the environment directory
read -p "Enter the template environment (01): " env_path

terraform -chdir=azure/env/$env_path destroy -auto-approve

# Read the JSON file
json_file="azure/env/$env_path/_override.tf.json"
storage_account_name=$(jq -r '.terraform.backend.azurerm.storage_account_name' "$json_file")
resource_group_name=$(jq -r '.terraform.backend.azurerm.resource_group_name' "$json_file")

# Construct the az storage account delete command
delete_command="az storage account delete --name $storage_account_name --resource-group $resource_group_name --yes"

# Print the command
echo "Running command: $delete_command"

# Run the command
eval "$delete_command"
