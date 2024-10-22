resource "azurerm_linux_virtual_machine" "vm" {
  name                = "B9IS121"  # Ensure this matches
  resource_group_name = "B9IS121_group"  # Ensure this matches
  location            = "westeurope"  # Ensure this matches
  size                = "Standard_B1s"  # Ensure this matches
  admin_username      = "brenda"  # Ensure this matches

  admin_ssh_key {
    username   = "brenda"
    public_key = file("/home/brenda/.ssh/id_rsa.pub")
  }

  network_interface_ids = [azurerm_network_interface.nic.id]  # Ensure NIC is configured correctly

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 30  # Ensure this matches
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}
