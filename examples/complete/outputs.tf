output "resource_group_name" {
  value = module.virtual_network_subnet.resource_group_name
}

output "virtual_network_name" {
  value = module.virtual_network.vnet_name
}

output "azurerm_subnet_name" {
  value = module.virtual_network_subnet.subnet.name
}

output "azurerm_subnet_id" {
  value = module.virtual_network_subnet.id
}
