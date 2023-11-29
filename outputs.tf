output "id" {
  value       = azurerm_linux_virtual_machine_scale_set.this.id
  description = "Linux virtual machine scale set id"
}

output "public_ips" {
  value       = try(azurerm_public_ip_prefix.this[0].ip_prefix, null)
  description = "Public IP Address Prefix CIDR"
}
