resource "azurerm_network_security_group" "nsg" {

  for_each = var.nsg

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "association" {

  for_each = var.nsg

  subnet_id                 = each.value.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}