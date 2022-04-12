// fill with access key and secret key from RAM account
access_key = ""
secret_key = ""
// fill with folder IDs (fd-**********) from Resource Manager
resource_manager_folder_ids = ["","",""]

region = "cn-hangzhou"

# roles and permissions
resource_directories = {
  "core": {
    accounts = ["Security", "Networking", "Audit", "Core Shared Services"]
  },
  "team": {
    accounts = ["Prod", "Pre-Prod", "Dev", "Team Shared Services"]
  },
  "developer": {
    accounts = ["Sandbox"]
  }
}


control_policy_name = "DenyRoleChange"
description = ""
effect_scope = "RAM"
policy_document = {
  "Version":"1",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "ram:UpdateRole",
        "ram:DeleteRole",
        "ram:AttachPolicyToRole",
        "ram:DetachPolicyFromRole"
      ],
      "Resource":"acs:ram:*:*:role/ResourceDirectoryAccountAccessRole"
    }
  ]
}


ram_roles = {
  "BillingAdmin": {
    description = "Billing Admin"
    policies = [
      "AliyunBSSFullAccess",
      "AliyunFinanceConsoleFullAccess"
    ]
  },
  "CloudAdmin": {
    description = "Cloud Admin"
    policies = [
      "AdministratorAccess"
    ]
  },
  "NetworkAdmin": {
    description = "Network Admin"
    policies = [
      "AliyunVPCFullAccess",
      "AliyunNATGatewayFullAccess",
      "AliyunEIPFullAccess",
      "AliyunCENFullAccess",
      "AliyunVPNGatewayFullAccess",
      "AliyunExpressConnectFullAccess",
      "AliyunCommonBandwidthPackageFullAccess",
      "AliyunSmartAccessGatewayFullAccess",
      "AliyunGlobalAccelerationFullAccess",
      "AliyunECSNetworkInterfaceManagementAccess",
      "AliyunDNSFullAccess",
      "AliyunYundunNewBGPAntiDDoSServicePROFullAccess"
    ]
  },
  "DBAdmin": {
    description = "DB Admin"
    policies = [
      "AliyunRDSFullAccess",
      "AliyunDRDSFullAccess",
      "AliyunOCSFullAccess",
      "AliyunPolardbFullAccess",
      "AliyunADBFullAccess",
      "AliyunDTSFullAccess",
      "AliyunMongoDBFullAccess",
      "AliyunPetaDataFullAccess",
      "AliyunGPDBFullAccess",
      "AliyunHBaseFullAccess",
      "AliyunYundunDbAuditFullAccess",
      "AliyunHiTSDBFullAccess",
      "AliyunDBSFullAccess",
      "AliyunHDMFullAccess",
      "AliyunGDBFullAccess",
      "AliyunOceanBaseFullAccess",
      "AliyunCassandraFullAccess",
      "AliyunClickHouseFullAccess",
      "AliyunDLAFullAccess"
    ]
  },
  "SLBAdmin": {
    description = "SLB Admin"
    policies = [
      "AliyunSLBFullAccess",
      "AliyunEIPFullAccess",
      "AliyunECSNetworkInterfaceManagementAccess"
    ]
  },
  "CDNAdmin": {
    description = "CDN Admin"
    policies = [
      "AliyunCDNFullAccess"
    ]
  },
  "MonitorAdmin": {
    description = "Monitor Admin"
    policies = [
      "AliyunCloudMonitorFullAccess"
    ]
  },
  "MiddlewareAdmin": {
    description = "Middleware Admin"
    policies = [
      "AliyunKvstoreFullAccess",
      "AliyunMQFullAccess",
      "AliyunElasticsearchFullAccess"
    ]
  }
}


ram_multi_roles = [
  {
    role_name = "cloudadmin"
    account_id = "1925726250249818"
  },
  {
    role_name = "networkadmin"
    account_id = "1320526250247518"
  }
]

# audit

actiontrail_account_uid = "113*************"
project_name = "audit"
bucket_name = "audit-logs"
action_trail_name = "audit-trail"

# networking
share_service_account_cen = {
  // fill from Shared Services account id
  share_service_account_id = ""
  cen = {
    instance_name = "cen"
  }
}

member_account_vpc = {
  // fill drom Network account id
  member_account_id = ""
  vpc = {
    cidr_block = "10.34.64.0/20"
    vpc_name   = "default"
    projects = {
      "alpha" : {
        network_acl_enabled = false
        vswitches = {
          "vsw-app-1-a" : {
            cidr_block = "10.34.64.0/24"
            zone       = "cn-hangzhou-f"
            nat = {
              natgateway_enabled = true
              natgateway_name = "nat-alpha"
              specification   = "Small"
              nat_type        = "Enhanced"
              eip_bandwidth = "10"
              eip_internet_charge_type = "PayByBandwidth"
              eip_tags                 = { team = "teamValue" }
            }
          },
          "vsw-db-1-a" : {
            cidr_block = "10.34.70.0/24"
            zone       = "cn-hangzhou-f"
            nat = {
              natgateway_enabled = false
            }
          }
        }
      }

      "beta" : {
        network_acl_enabled = false
        vswitches = {
          "vsw-app-2-a" : {
            cidr_block = "10.34.72.0/24"
            zone       = "cn-hangzhou-f"
            nat = {
              natgateway_enabled = true
              natgateway_name = "nat-beta"
              specification   = "Small"
              nat_type        = "Enhanced"
              eip_bandwidth = "10"
              eip_internet_charge_type = "PayByBandwidth"
              eip_tags                 = { team = "teamValue" }
            }
          },
          "vsw-db-2-a" : {
            cidr_block = "10.34.74.0/24"
            zone       = "cn-hangzhou-f"
            nat = {
              natgateway_enabled = false
            }
          }
        }
      }
    }
  }
}
