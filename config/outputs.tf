#Instance IP
output "instance_ip_addr" {
  value = azurerm_linux_virtual_machine.myterraformvm.public_ip_address
}
