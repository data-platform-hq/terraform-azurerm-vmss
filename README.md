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

| Name                                                                         | Version   |
| ---------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)    | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)          | >= 3.75.0 |

## Providers

| Name                                                                   | Version |
| ---------------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)          | 3.75.0  |


## Inputs

| Name | Description | Type | Default                                                                                                                                               | Required |
|------|-------------|------|-------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_scale_set_name"></a> [scale\_set\_name](#input\_scale\_set\_name)| Virtual Machine Scale Set name. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)| The name of the resource group. | `string` | n/a| yes |
| <a name="input_location"></a> [location](#input\_location)| The Azure Region in which all resources in this example should be created. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id)| The ID of the Subnet where this Network first Interface should be located in. | `string` | n/a | yes |
| <a name="input_admin_ssh_key"></a> [admin\_ssh\_key](#input\_admin\_ssh\_key)| Objects to configure ssh key reference for Virtual Machine Scale Sets | <pre>object({<br>  username   = optional(string, "azureuser")<br>  public_key = string<br>})</pre> | <pre>{<br>  username   = null<br>  public_key = null<br>}</pre> | yes |
| <a name="input_tags"></a> [tags](#input\_tags)| list of tags | map(string) | {} | no |
| <a name="input_public_ip_prefix_enabled"></a> [public\_ip\_prefix\_enabled](#input\_public\_ip\_prefix\_enabled)| Boolean flag that determines whether Public IP Address prefix is created for VM Scale Set. | bool | true | no |
| <a name="input_public_ip_prefix_name"></a> [public\_ip\_prefix\_name](#input\_public\_ip\_prefix\_name)| Public IP Address prefix name. | string | null | no |
| <a name="input_public_ip_prefix_length"></a> [public\_ip\_prefix\_length](#input\_public\_ip\_prefix\_length)| Public IP Address prefix length. Possible value are between 0 and 31. | string | 30 | no |
| <a name="input_scale_set_configuration"></a> [scale\_set\_configuration](#input\_scale\_set\_configuration)| Configuration options for linux virtual machine scale set | <pre>object({<br>  sku                             = optional(string)<br>  instances                       = optional(string)<br>  admin_username                  = optional(string)<br>  admin_password                  = optional(string)<br>  disable_password_authentication = optional(bool)<br>  priority                        = optional(string)<br>  overprovision                   = optional(bool)<br>  single_placement_group          = optional(bool)<br>  upgrade_mode                    = optional(string)<br>  enable_ip_forwarding_interface  = optional(bool)<br>  domain_name_label               = optional(string)<br>  lb_backend_address_pool_ids     = optional(list(string))<br>})</pre>  |   <pre>object({<br>  sku                             = optional(string, "Standard_D2_v2")<br>  instances                       = optional(string, "2")<br>  admin_username                  = optional(string, "azureuser")<br>  admin_password                  = optional(string, null)<br>  disable_password_authentication = optional(bool, true)<br>  priority                        = optional(string, "Regular")<br>  overprovision                   = optional(bool, false)<br>  single_placement_group          = optional(bool, false)<br>  upgrade_mode                    = optional(string, "Manual")<br>  enable_ip_forwarding_interface  = optional(bool, false)<br>  domain_name_label               = optional(string, null)<br>  lb_backend_address_pool_ids     = optional(list(string), [])<br>})</pre>  | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions)| Virtual Machine scale set extensions config |  <pre>set(object({<br>  name                 = string<br>  publisher            = string<br>  type                 = string<br>  type_handler_version = string<br>  settings             = optional(string)<br>  protected_settings   = optional(string)<br>}))</pre> | [] | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk)| Objects to configure os disk reference for Virtual Machine Scale Sets | <pre>object({<br>  caching              = string<br>  storage_account_type = string<br>})</pre> | <pre>{<br>  caching              = "ReadWrite"<br>  storage_account_type = "Standard_LRS"<br>}</pre>                                                  | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference)| Objects to configure source image reference for Virtual Machine Scale Sets | <pre>object({<br>  publisher = string<br>  offer     = string<br>  sku       = string<br>  version   = string<br>})</pre> | <pre>{<br>  publisher = "Canonical"<br>  offer     = "0001-com-ubuntu-server-jammy"<br>  sku       = "22_04-lts"<br>  version   = "latest"<br>}</pre> | no |
                                      
## Modules

No modules.

## Resources

| Name                                                                                                                                                                | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_public_ip_prefix.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix)                           | resource |
| [azurerm_linux_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set)                           | resource |

## Outputs

| Name                                                                                                                          | Description                                          |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| <a name="output_id"></a> [id](#output\_id) | Linux virtual machine scale set id |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | Public IP Address Prefix CIDR |

<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-vmss/blob/main/LICENSE)
