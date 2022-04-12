# Alicloud Landing Zone

Simple multi-account landing zone for Alibaba Cloud.

![high-level diagram](/images/hld.png)


## Prerequirements

Create RAM user and with API access and write access key and secret key to [settings.tfvars](settings.tfvars) - `access_key` and `secret_key` fields.

Add the following roles:

- AliyunResourceDirectoryFullAccess
- AliyunSTSAssumeRoleAccess
- AliyunRAMFullAccess
- AliyunActionTrailFullAccess

After creating folders and accounts fill the following in [settings.tfvars](settings.tfvars):

- `resource_manager_folder_ids` - list of folder ids (three folders)
- `share_service_account_id` - Shared Service member account ID
- `member_account_id` - Network member account ID

## Launch

```bash
# fill account keys before this step

make generate/1

# fill folder ids before this step

make generate/2
make generate/3

# fill shared services and network account ids before this step

make generate/4

# enable SLS before this step

make generate/5
```