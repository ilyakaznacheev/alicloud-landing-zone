resource "alicloud_resource_manager_folder" "folder" {
  folder_name = var.folder_name
}

resource "alicloud_resource_manager_account" "account" {
  for_each = toset(var.account_name)
  display_name = each.key
  folder_id = alicloud_resource_manager_folder.folder.id
}
