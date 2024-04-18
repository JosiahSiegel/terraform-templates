# Terraform Templates

## Quick start

1. Login to Azure
   * `az login`
2. Export an owner object ID to a variable
   * ```sh
     owner_object_id=$(az ad user list --display-name "Joe Smith" --query '[0].id' -o tsv)
     export TF_VAR_owner_object_id=$owner_object_id
     ```
3. Create terraform state backend file and storage account
   * `./.scripts/provision.sh`
4. Initialize Terraform
   * `terraform -chdir=azure/env/01 init -reconfigure`
5. Plan the Terraform deployment
   * `terraform -chdir=azure/env/01 plan -parallelism=20`
6. Apply the Terraform deployment
   * `terraform -chdir=azure/env/01 apply -parallelism=20`
7. Destroy the Terraform deployment and terraform storage account
   * `./scripts/destroy.sh`

|Env Template|Resource|Notes|
|---|---|---|
|01|API Management|---|
|01|Logic App|---|
|01|Key Vault|---|
|01|Storage Account|---|
|01|Azure SQL DB|---|

## Tips

1. If login failure, try running `az logout` before `az login`