module "logic_app" {
  source          = "../../modules/logic_app"
  common          = local.common
  storage_account = module.storage_account_table.meta
}

module "storage_account_table" {
  source       = "../../modules/storage_account_table"
  common       = local.common
  logic_app_id = module.logic_app.id
}