access_key = ""
secret_key = ""
region     = "cn-hangzhou"

share_service_account_cen = {
  share_service_account_id = ""
  cen = {
    instance_name = "cen"
  }
}

member_account_vpc = {
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
