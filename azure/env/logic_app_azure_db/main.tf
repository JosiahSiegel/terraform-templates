module "logic_app" {
  source          = "../../modules/logic_app_db"
  common          = local.common
  storage_account = module.storage_account.meta
}

module "azure_db" {
  source = "../../modules/azure_db"
  common = local.common
  logic_app_ids = module.logic_app.ids
  logic_app_name = module.logic_app.name
}

module "storage_account" {
  source       = "../../modules/storage_account"
  common       = local.common
  logic_app = module.logic_app.ids
}
