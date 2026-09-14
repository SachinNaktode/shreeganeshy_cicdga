output "subnet_id" {
  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => subnet.id
  }
}