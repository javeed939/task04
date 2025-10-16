output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "vm_fqdn" {
  description = "Fully qualified domain name created by public IP DNS label"
  value       = azurerm_public_ip.pip.fqdn
}