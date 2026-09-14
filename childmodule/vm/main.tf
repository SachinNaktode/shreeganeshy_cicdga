resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.vm

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username

  network_interface_ids = [
    each.value.nic_id
  ]

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = each.value.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}