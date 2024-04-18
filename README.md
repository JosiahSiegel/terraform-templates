# Terraform Templates

## Quick start

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/JosiahSiegel/terraform-templates)

1. Login to Azure
   * `az login`
2. Export an owner object ID to a variable
   * ```sh
     owner_object_id=$(az ad user list --display-name "Joe Smith" --query '[0].id' -o tsv)
     export owner_object_id=$owner_object_id
     ```
3. Create Terraform state backend file and storage account for a template
   * `./.scripts/provision_template.sh`
4. Initialize Terraform using template path (`azure/env/<template>`)
   * `terraform -chdir=azure/env/01 init -reconfigure`
5. Plan the Terraform deployment
   * `terraform -chdir=azure/env/01 plan`
6. Apply the Terraform deployment
   * `terraform -chdir=azure/env/01 apply`
   * > ⚠️ If "*Login failed for user '\<token-identified principal\>'*", try running `az logout` then `az login`
7. Destroy the Terraform deployment and terraform storage account
   * `./.scripts/destroy_template.sh`

## Environment resources

### Templates
<details>
  <summary>01</summary>

|Azure Resource|Notes|
|---|---|
|API Management|Securely share and manage REST endpoints|
|Logic App|Make database data available via REST endpoint|
|Data Factory|Ingest APIs and store data in a database and storage account|
|Key Vault|Manage secrets|
|Storage Account|Store results from ingested APIs|
|Azure SQL DB|Store data from ingested APIs and expose via Logic App and API Management|
</details>
<details>
  <summary>02</summary>

Coming soon...
</details>

## Tips

1. If login failure during plan or apply, try running `az logout` then `az login`
2. If you encounter any issues, please check the Terraform state backend and `_override.tf.json` files and storage account created in step 3
