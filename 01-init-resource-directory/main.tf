 provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

resource "alicloud_resource_manager_resource_directory" "resource_manager" {
  status = "Enabled"
}

module "account" {
  for_each = var.resource_directories
  source = "./modules/account"

  providers = {
    alicloud = alicloud
  }

  folder_name = each.key
  account_name = each.value.accounts
  depends_on = [
    alicloud_resource_manager_resource_directory.resource_manager,
  ]
}