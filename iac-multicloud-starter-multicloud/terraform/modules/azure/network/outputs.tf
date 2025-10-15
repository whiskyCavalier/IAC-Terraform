output "network_id" { value = azurerm_virtual_network.vnet.id }
output "subnet_ids"  { value = [azurerm_subnet.subnet1.id, azurerm_subnet.subnet2.id] }
