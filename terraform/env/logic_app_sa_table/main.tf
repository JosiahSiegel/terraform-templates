module "logic_app" {
  source          = "../../modules/logic_app"
  common          = local.common
  storage_account = module.storage_account.meta
}

module "storage_account" {
  source       = "../../modules/storage_account"
  common       = local.common
  logic_app_id = module.logic_app.id
}