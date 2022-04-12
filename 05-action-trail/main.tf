provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  alias = "master_account"
}

provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  alias = "actiontrail_account"
  assume_role {
    role_arn = "acs:ram::${var.actiontrail_account_uid}:role/ResourceDirectoryAccountAccessRole"
    session_name = "AccountLandingZoneSetup"
    session_expiration = 999
  }
}

resource "alicloud_log_project" "example" {
  provider = alicloud.actiontrail_account
  name = var.project_name
  description = "create by terraform"
}

resource "alicloud_oss_bucket" "example" {
  provider = alicloud.actiontrail_account
  bucket = var.bucket_name
  acl = "private"

  lifecycle_rule {
    enabled = "true"

    expiration {
      days = 730
    }
  }

  server_side_encryption_rule {
    sse_algorithm = "AES256"
  }

  force_destroy = "true"
}

data "alicloud_account" "master" {
  provider = alicloud.master_account
}

resource "alicloud_ram_role" "role" {
  provider = alicloud.actiontrail_account
  name = "ActionTrailDeliveryRole"
  document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "${data.alicloud_account.master.id}@actiontrail.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  description = "create by terraform, use for actionTrail delivery"
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  provider = alicloud.actiontrail_account
  policy_name = "AliyunActionTrailDeliveryPolicy"
  policy_type = "System"
  role_name = alicloud_ram_role.role.name
}

resource "alicloud_actiontrail_trail" "example" {
  provider = alicloud.master_account
  trail_name = "action-trail"
  event_rw = "All"

  sls_project_arn = "acs:log:${var.region}:${var.actiontrail_account_uid}:project/${alicloud_log_project.example.name}"
  sls_write_role_arn = alicloud_ram_role.role.arn

  oss_bucket_name = alicloud_oss_bucket.example.id
  oss_write_role_arn = alicloud_ram_role.role.arn
  is_organization_trail = "true"
}