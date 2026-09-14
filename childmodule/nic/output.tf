output "nic_id" {
  value = {
    for key, nic in azurerm_network_interface.nic :
    key => nic.id
  }
}