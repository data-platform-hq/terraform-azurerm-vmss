resource "azurerm_public_ip_prefix" "this" {
  count = var.public_ip_prefix_enabled ? 1 : 0

  name                = coalesce(var.public_ip_prefix_name, "ip-prefix-${var.scale_set_name}")
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
  prefix_length       = var.public_ip_prefix_length
}

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                            = var.scale_set_name
  resource_group_name             = var.resource_group
  location                        = var.location
  tags                            = var.tags
  sku                             = var.scale_set_configuration.sku
  instances                       = var.scale_set_configuration.instances
  admin_username                  = var.scale_set_configuration.admin_username
  admin_password                  = var.scale_set_configuration.admin_password
  disable_password_authentication = var.scale_set_configuration.disable_password_authentication
  priority                        = var.scale_set_configuration.priority
  overprovision                   = var.scale_set_configuration.overprovision
  single_placement_group          = var.scale_set_configuration.single_placement_group
  upgrade_mode                    = var.scale_set_configuration.upgrade_mode

  dynamic "extension" {
    for_each = var.extensions
    content {
      name                 = extension.value.name
      publisher            = extension.value.publisher
      type                 = extension.value.type
      type_handler_version = extension.value.type_handler_version
      settings             = extension.value.settings
      protected_settings   = extension.value.protected_settings
    }
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  dynamic "admin_ssh_key" {
    for_each = var.scale_set_configuration.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_ssh_key.username
      public_key = var.admin_ssh_key.public_key
    }
  }

  network_interface {
    name                 = "interface-${var.scale_set_name}"
    primary              = true
    enable_ip_forwarding = var.scale_set_configuration.enable_ip_forwarding_interface

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = var.scale_set_configuration.lb_backend_address_pool_ids

      dynamic "public_ip_address" {
        for_each = var.public_ip_prefix_enabled ? [1] : []
        content {
          name                = "public"
          public_ip_prefix_id = try(azurerm_public_ip_prefix.this[0].id, null)
          domain_name_label   = var.scale_set_configuration.domain_name_label
        }
      }
    }
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  lifecycle {
    ignore_changes = [
      instances,
      tags
    ]
  }
}
