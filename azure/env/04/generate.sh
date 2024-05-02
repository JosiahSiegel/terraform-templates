#!/bin/bash

# Modules 
modules=(key_vault sql vnet dns)

# Module params
kv_params=(name tenant_id resource_group location)
sql_params=(name resource_group location)
vnet_params=(address_space subnet_prefix)  
dns_params=(zone_name resource_group)

# Prompt for counts
for module in ${modules[@]}; do
  read -p "Number of $module: " ${module}_count
done

# Generate main.tf
> main.tf

for ((i=0; i<${#modules[@]}; i++)); do

  module=${modules[$i]}
  params=${module}_params

  if [[ ${module}_count > 0 ]]; then

    # main.tf generation

    echo "" >> main.tf

  fi

done

# Generate locals.tf
> locals.tf

echo "locals {" >> locals.tf

for ((i=0; i<${#modules[@]}; i++)); do

  # locals.tf generation

done

echo "}" >> locals.tf
