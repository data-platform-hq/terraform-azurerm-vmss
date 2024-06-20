# Azure VMSS Terraform module
Terraform module for creation Azure Virtual Machine Scale Sets

## Usage
```hcl
resource "tls_private_key" "scale_set" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "azurerm_subnet" "example" {
  name                 = "example-name"
  virtual_network_name = "example-vn-name"
  resource_group_name  = "example-rg"
}

module "vm_scale_sets" {
  source   = "data-platform-hq/vmss/azurerm"
  version  = "1.0.0"
  
  project        = "datahq"
  env            = "example"
  location       = "eastus"
  resource_group = "example-rg"
  admin_ssh_key  = { public_key = tls_private_key.scale_set[0].public_key_openssh }
  subnet         = data.azurerm_subnet.example.id
 }
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.75.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.75.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_data_collection_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |
| [azurerm_monitor_data_collection_rule_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |
| [azurerm_public_ip_prefix.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ssh_key"></a> [admin\_ssh\_key](#input\_admin\_ssh\_key) | Objects to configure ssh key reference for Virtual Machine Scale Sets | <pre>object({<br>    username   = optional(string, "azureuser")<br>    public_key = string<br>  })</pre> | <pre>{<br>  "public_key": null,<br>  "username": null<br>}</pre> | no |
| <a name="input_analytics_workspace_id"></a> [analytics\_workspace\_id](#input\_analytics\_workspace\_id) | Resource ID of Log Analytics Workspace | `string` | `null` | no |
| <a name="input_automatic_os_upgrade_policy"></a> [automatic\_os\_upgrade\_policy](#input\_automatic\_os\_upgrade\_policy) | Configuration options for automatic os upgrade policy | <pre>object({<br>    disable_automatic_rollback  = optional(bool, false)<br>    enable_automatic_os_upgrade = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_automatic_os_upgrade_policy_enabled"></a> [automatic\_os\_upgrade\_policy\_enabled](#input\_automatic\_os\_upgrade\_policy\_enabled) | Boolean flag that determines whether automatic os upgrade policy is enabled | `bool` | `false` | no |
| <a name="input_data_collection_rule_association_name"></a> [data\_collection\_rule\_association\_name](#input\_data\_collection\_rule\_association\_name) | Data collection rule association name | `string` | `null` | no |
| <a name="input_data_collection_rule_name"></a> [data\_collection\_rule\_name](#input\_data\_collection\_rule\_name) | Data collection rule name | `string` | `null` | no |
| <a name="input_datasource_name"></a> [datasource\_name](#input\_datasource\_name) | Datasource syslog name | `string` | `"datasource-syslog"` | no |
| <a name="input_dcr_association_description"></a> [dcr\_association\_description](#input\_dcr\_association\_description) | Description of Data collection rule association | `string` | `"Association between the Data Collection Rule and the Linux VM."` | no |
| <a name="input_dependency_agent_extension_version"></a> [dependency\_agent\_extension\_version](#input\_dependency\_agent\_extension\_version) | Version of VMSS extension required for logging | `string` | `"9.5"` | no |
| <a name="input_enable_data_collection_rule"></a> [enable\_data\_collection\_rule](#input\_enable\_data\_collection\_rule) | Enable data collection rule. var.analytics\_workspace\_id must be provided | `bool` | `false` | no |
| <a name="input_enable_data_collection_rule_association"></a> [enable\_data\_collection\_rule\_association](#input\_enable\_data\_collection\_rule\_association) | Enable data collection rule association. var.analytics\_workspace\_id must be provided | `bool` | `true` | no |
| <a name="input_enable_scale_set_extension"></a> [enable\_scale\_set\_extension](#input\_enable\_scale\_set\_extension) | Enable scale set extension. var.analytics\_workspace\_id must be provided | `bool` | `true` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | Virtual Machine scale set extensions config | <pre>set(object({<br>    name                 = string<br>    publisher            = string<br>    type                 = string<br>    type_handler_version = string<br>    settings             = optional(string)<br>    protected_settings   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_facility_names"></a> [facility\_names](#input\_facility\_names) | List of Facility names | `list(string)` | <pre>[<br>  "daemon",<br>  "syslog",<br>  "user"<br>]</pre> | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of user assigned identity IDs | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all resources in this example should be created. | `string` | n/a | yes |
| <a name="input_log_levels"></a> [log\_levels](#input\_log\_levels) | List of Log levels | `list(string)` | <pre>[<br>  "Debug"<br>]</pre> | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | Objects to configure os disk reference for Virtual Machine Scale Sets | <pre>object({<br>    caching              = optional(string, "ReadWrite")<br>    storage_account_type = optional(string, "Standard_LRS")<br>  })</pre> | `{}` | no |
| <a name="input_public_ip_prefix_enabled"></a> [public\_ip\_prefix\_enabled](#input\_public\_ip\_prefix\_enabled) | Boolean flag that determines whether Public IP Address prefix is created for VM Scale Set. | `bool` | `true` | no |
| <a name="input_public_ip_prefix_length"></a> [public\_ip\_prefix\_length](#input\_public\_ip\_prefix\_length) | Public IP Address prefix length. Possible value are between 0 and 31. | `string` | `30` | no |
| <a name="input_public_ip_prefix_name"></a> [public\_ip\_prefix\_name](#input\_public\_ip\_prefix\_name) | Public IP Address prefix name. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_scale_set_configuration"></a> [scale\_set\_configuration](#input\_scale\_set\_configuration) | Configuration options for linux virtual machine scale set | <pre>object({<br>    sku                             = optional(string, "Standard_D2_v2")<br>    instances                       = optional(string, "2")<br>    admin_username                  = optional(string, "azureuser")<br>    admin_password                  = optional(string, null)<br>    disable_password_authentication = optional(bool, true)<br>    priority                        = optional(string, "Regular")<br>    overprovision                   = optional(bool, false)<br>    single_placement_group          = optional(bool, false)<br>    upgrade_mode                    = optional(string, "Manual")<br>    enable_ip_forwarding_interface  = optional(bool, false)<br>    domain_name_label               = optional(string, null)<br>    lb_backend_address_pool_ids     = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_scale_set_name"></a> [scale\_set\_name](#input\_scale\_set\_name) | Virtual Machine Scale Set name. | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | Objects to configure source image reference for Virtual Machine Scale Sets | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "0001-com-ubuntu-server-jammy",<br>  "publisher": "Canonical",<br>  "sku": "22_04-lts",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet where this Network first Interface should be located in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | list of tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Linux virtual machine scale set id |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | Public IP Address Prefix CIDR |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-vmss/blob/main/LICENSE)
