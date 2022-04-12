provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

data "alicloud_account" "current_account" {
}

module "role" {
  for_each = var.ram_roles
  source = "../modules/role"

  providers = {
    alicloud = alicloud
  }

  account_uid = data.alicloud_account.current_account.id
  #master_account_uid = data.alicloud_account.current_account.id
  role_name = each.key
  role_description = each.value.description
  policies = each.value.policies
}

data "alicloud_resource_manager_accounts" "rd" {}

resource "local_file" "step2-main" {
  content  = templatefile("${path.module}/step2.tmpl", {
    accounts = data.alicloud_resource_manager_accounts.rd.accounts,
    ram_roles = jsonencode(var.ram_roles),
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  })
  filename = "${path.module}/../step2/main.tf"
}