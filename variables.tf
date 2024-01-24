variable "scale_set_name" {
  type        = string
  description = "Virtual Machine Scale Set name."
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network first Interface should be located in."
}

variable "admin_ssh_key" {
  description = "Objects to configure ssh key reference for Virtual Machine Scale Sets"
  type = object({
    username   = optional(string, "azureuser")
    public_key = string
  })
  default = {
    username   = null
    public_key = null
  }
}

variable "tags" {
  type        = map(string)
  description = "list of tags"
  default     = {}
}

variable "public_ip_prefix_enabled" {
  description = "Boolean flag that determines whether Public IP Address prefix is created for VM Scale Set."
  type        = bool
  default     = true
}

variable "public_ip_prefix_name" {
  description = "Public IP Address prefix name."
  type        = string
  default     = null
}

variable "public_ip_prefix_length" {
  description = "Public IP Address prefix length. Possible value are between 0 and 31."
  type        = string
  default     = 30
}

variable "scale_set_configuration" {
  description = "Configuration options for linux virtual machine scale set"
  type = object({
    sku                             = optional(string, "Standard_D2_v2")
    instances                       = optional(string, "2")
    admin_username                  = optional(string, "azureuser")
    admin_password                  = optional(string, null)
    disable_password_authentication = optional(bool, true)
    priority                        = optional(string, "Regular")
    overprovision                   = optional(bool, false)
    single_placement_group          = optional(bool, false)
    upgrade_mode                    = optional(string, "Manual")
    enable_ip_forwarding_interface  = optional(bool, false)
    domain_name_label               = optional(string, null)
    lb_backend_address_pool_ids     = optional(list(string), [])
  })
  default = {}
}

variable "extensions" {
  description = "Virtual Machine scale set extensions config"
  type = set(object({
    name                 = string
    publisher            = string
    type                 = string
    type_handler_version = string
    settings             = optional(string)
    protected_settings   = optional(string)
  }))
  default = []
}

variable "os_disk" {
  description = "Objects to configure os disk reference for Virtual Machine Scale Sets"
  type = object({
    caching              = optional(string, "ReadWrite")
    storage_account_type = optional(string, "Standard_LRS")
  })
  default = {}
}

variable "source_image_reference" {
  description = "Objects to configure source image reference for Virtual Machine Scale Sets"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}