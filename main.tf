provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "B9IS121_group"
  location = "West Europe"
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

resource "azurerm_network_interface" "example" {
  name                = "B9IS121-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "example" {
  name                = "B9IS121-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "B9IS121"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B1s"
  admin_username      = "erenda"
  admin_ssh_key {
    username   = "erenda"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICScR3bhSFsUJxogRNLI/AA9gONuGkqVgiYcrbs9c8wN brenda@DESKTOP-J7I6O7I"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "B9IS121-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 30
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.example.ip_address
}

output "dns_name" {
  value = azurerm_public_ip.example.dns_name
}
