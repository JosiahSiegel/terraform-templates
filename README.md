# Terraform Templates

## Introduction

This repository contains Terraform templates for deploying various resources in Azure. It is designed to help beginners get started with provisioning infrastructure using Terraform.

## Prerequisites

- Azure CLI installed
- Azure account with sufficient permissions
- Terraform installed

## Getting Started

>I recommend running in Codespaces or Dev Container in VS Code:
>
>[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/JosiahSiegel/terraform-templates)

### 1. Login to Azure
```sh
az login
```

### 2. Export Owner Object ID
Export an owner object ID to a variable by running the following command:
```sh
owner_object_id=$(az ad user list --display-name "Joe Smith" --query '[0].id' -o tsv)
export owner_object_id=$owner_object_id
```
Replace "Joe Smith" with the appropriate user display name.
### 3. Create Terraform Backend
Create the Terraform state backend file and storage account for a template by running the following script:
```sh
./.scripts/provision_template.sh
```
### 4. Initialize Terraform
Initialize Terraform using the desired template path (`azure/env/<template>`) by running:
```sh
terraform -chdir=azure/env/01 init -reconfigure
```
Replace 01 with the appropriate template directory.
### 5. Plan Terraform Deployment
Generate an execution plan for the Terraform deployment by running:
```sh
terraform -chdir=azure/env/01 plan
```
### 6. Apply Terraform Deployment
```sh
terraform -chdir=azure/env/01 apply
```
If a login failure occurs with the error "Login failed for user '<token-identified principal>'", try running `az logout` and then `az login` to resolve the issue.
### 7. Destroy the Terraform deployment and terraform storage account
```sh
./.scripts/destroy_template.sh
```

## Available Templates

### Template 01

|Azure Resource|Purpose|
|---|---|
|API Management|Securely share and manage REST endpoints|
|Logic App|Make database data available via REST endpoint|
|Data Factory|Ingest APIs and store data in a database and storage account|
|Key Vault|Manage secrets|
|Storage Account|Store results from ingested APIs|
|Azure SQL DB|Store data from ingested APIs and expose via Logic App and API Management|

### Template 02

Coming soon...

## Troubleshooting

1. If login failure during plan or apply, try running `az logout` then `az login`
2. If you encounter any issues, please check the Terraform state backend and `_override.tf.json` files and storage account created in step 3

## Contributing
Feel free to submit pull requests or open issues if you have any suggestions or improvements for these Terraform templates.
