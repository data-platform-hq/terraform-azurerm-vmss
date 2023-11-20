resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                            = "scale-set-${var.project}-${var.env}-${var.location}"
  resource_group_name             = var.resource_group
  location                        = var.location
  tags                            = var.tags
  sku                             = var.scale_set.sku
  instances                       = var.scale_set.instances
  admin_username                  = var.scale_set.admin_username
  disable_password_authentication = var.scale_set.disable_password_authentication
  priority                        = var.scale_set.priority
  overprovision                   = var.scale_set.overprovision
  single_placement_group          = var.scale_set.single_placement_group

  boot_diagnostics {
    storage_account_uri = null
  }

  admin_ssh_key {
    username   = var.admin_ssh_key.username
    public_key = var.admin_ssh_key.public_key
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  dynamic "admin_ssh_key" {
    for_each = var.scale_set.disable_password_authentication ? [] : [1]

    content {
      username   = var.admin_ssh_key.username
      public_key = var.admin_ssh_key.public_key
    }
  }

  network_interface {
    name    = "interface-${var.project}-${var.env}-${var.location}"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet
    }
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  lifecycle {
    ignore_changes = [
      instances
    ]
  }
}
