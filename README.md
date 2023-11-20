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
| <a name="input_project"></a> [project](#input\_project)| Project name | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)| The name of the resource group. | `string` | n/a| yes |
| <a name="input_env"></a> [env](#input\_env)| The prefix which should be used for all resources in this environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location)| The Azure Region in which all resources in this example should be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags)| list of tags | map(string) | {} | no |
| <a name="input_scale_set"></a> [scale_set](#input\_scale_set)| Configuration options for linux virtual machine scale set |  <pre>object({<br>  sku                             = optional(string)<br>  instances                       = optional(string)<br>  admin_username                  = optional(string)<br>  disable_password_authentication = optional(bool)<br>  priority                        = optional(string)<br>  overprovision                   = optional(bool)<br>  single_placement_group          = optional(bool)<br>})</pre> |  <pre>object({<br>  sku                             = optional(string, "Standard_B1ms")<br>  instances                       = optional(string, "2")<br>  admin_username                  = optional(string, "azureuser")<br>  disable_password_authentication = optional(bool, true)<br>  priority                        = optional(string, "Regular")<br>  overprovision                   = optional(bool, false)<br>  single_placement_group          = optional(bool, false)<br>})</pre> | no |
| <a name="input_admin_ssh_key"></a> [admin\_ssh\_key](#input\_admin\_ssh\_key)| Objects to configure ssh key reference for Virtual Machine Scale Sets | <pre>object({<br>  username   = string<br>  public_key = string<br>})</pre> | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet)| The ID of the Subnet where this Network first Interface should be located in. | `string` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk)| Objects to configure os disk reference for Virtual Machine Scale Sets | <pre>object({<br>  caching              = string<br>  storage_account_type = string<br>})</pre> | <pre>{<br>  caching              = "ReadWrite"<br>  storage_account_type = "Standard_LRS"<br>}</pre>                                                  | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference)| Objects to configure source image reference for Virtual Machine Scale Sets | <pre>object({<br>  publisher = string<br>  offer     = string<br>  sku       = string<br>  version   = string<br>})</pre> | <pre>{<br>  publisher = "Canonical"<br>  offer     = "0001-com-ubuntu-server-focal"<br>  sku       = "20_04-lts"<br>  version   = "latest"<br>}</pre> | no |
                                                                                                                                                                                                                
## Modules

No modules.

## Resources

| Name                                                                                                                                                                | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_linux_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                           | resource |

## Outputs

| Name                                                                                                                          | Description                                          |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| <a name="output_id"></a> [id](#output\_id) | Linux virtual machine scale set id |


<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-vmss/blob/main/LICENSE)
