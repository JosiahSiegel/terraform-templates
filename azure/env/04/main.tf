module "init" {
  source    = "../../modules/init"
  common    = local.common
  dev_roles = local.dev_roles
}

module "key_vault" {
  for_each = local.key_vaults

  source  = "../../modules/key_vault"
  common  = local.common
  secrets = each.value.secrets
  key     = each.key

  depends_on = [module.init]
}

module "vnet" {
  for_each = local.vnets

  source        = "../../modules/vnet"
  common        = local.common
  address_space = each.value.address_space
  subnets       = each.value.subnets
  key           = each.key

  depends_on = [module.init]
}

module "storage_account" {
  for_each = local.storage_accounts

  source = "../../modules/storage_account/v2"
  common = local.common
  key    = each.key

  depends_on = [module.init]
}

module "container_instance" {
  for_each = local.container_instances

  source          = "../../modules/container_instance"
  common          = local.common
  key             = each.key
  storage_account = module.storage_account[each.value.storage_account_key].meta

  depends_on = [module.init, module.storage_account, module.vnet, module.key_vault]
}
