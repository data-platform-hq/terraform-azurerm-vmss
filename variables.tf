variable "project" {
  type        = string
  description = "Project name"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group."
}

variable "env" {
  type        = string
  description = "The prefix which should be used for all resources in this environment"
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "tags" {
  type        = map(string)
  description = "list of tags"
  default     = {}
}

variable "scale_set" {
  type = object({
    sku                             = optional(string, "Standard_D2_v2")
    instances                       = optional(string, "2")
    admin_username                  = optional(string, "azureuser")
    disable_password_authentication = optional(bool, true)
    priority                        = optional(string, "Regular")
    overprovision                   = optional(bool, false)
    single_placement_group          = optional(bool, false)
  })
  description = "Configuration options for linux virtual machine scale set"
  default     = {}
}

variable "admin_ssh_key" {
  type = object({
    username   = optional(string, "azureuser")
    public_key = optional(string)
  })
  description = "Objects to configure ssh key reference for Virtual Machine Scale Sets"
}

variable "subnet" {
  type        = string
  description = "The ID of the Subnet where this Network first Interface should be located in."
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
  description = "Objects to configure os disk reference for Virtual Machine Scale Sets"
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Objects to configure source image reference for Virtual Machine Scale Sets"
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
