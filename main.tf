provider "azurerm" {
  features {}
}

variable "location" {
  default = "westeurope"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "brenda"
}

resource "azurerm_resource_group" "example" {
  name     = "B9IS121_group"
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "B9IS121-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "B9IS121-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "B9IS121-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"

  # Directly specify the DNS name here
  domain_name_label   = "mynetwork"
}

resource "azurerm_network_interface" "example" {
  name                = "B9IS121-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.example.id
    public_ip_address_id         = azurerm_public_ip.example.id
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                  = "B9IS121"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = var.vm_size
  admin_username        = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICScR3bhSFsUJxogRNLI/AA9gONuGkqVgiYcrbs9c8wN brenda@DESKTOP-J7I6O7I"
  }

  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed_disk_type    = "Premium_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }
}

output "dns_name" {
  value = azurerm_public_ip.example.fqdn
}
