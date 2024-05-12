module "init" {
  source    = "../../modules/init/v2"
  common    = local.common
  dev_roles = local.dev_roles
}

module "azure_ad" {
  source    = "../../modules/azure_ad"
  common    = local.common
  key       = local.azure_ad.key
  domain_name = local.azure_ad.domain_name

  depends_on = [module.init]
}


module "mssql_vm" {
  for_each = local.mssql_vms

  source    = "../../modules/mssql_vm"
  common    = local.common
  key       = each.key
  ad_dns_ips = module.azure_ad.dns_ips
  domain_name = local.azure_ad.domain_name

  depends_on = [module.init]
}
