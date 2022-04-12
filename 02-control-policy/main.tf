provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

resource "alicloud_resource_manager_control_policy" "control_policy" {
  control_policy_name = var.control_policy_name
  description = var.description
  effect_scope = var.effect_scope
  policy_document = jsonencode(var.policy_document)
}

resource "alicloud_resource_manager_control_policy_attachment" "attach" {
  for_each = toset(var.resource_manager_folder_ids)
  policy_id = alicloud_resource_manager_control_policy.control_policy.id
  target_id = each.value
}
