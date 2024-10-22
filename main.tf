# Provider configuration
provider "azurerm" {
  features {}
  subscription_id = "a77c589e-092e-413f-9643-e91ac54cdb6a"
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "B9IS121_GROUP"
  location = "westeurope"
}

# Virtual Network (Optional if already exists)
resource "azurerm_virtual_network" "vnet" {
  name                = "B9IS121_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "b9is121565"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Public IP (Optional)
resource "azurerm_public_ip" "public_ip" {
  name                = "B9IS121_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "B9IS121"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name              = "B9IS121_disk1"
    caching           = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb      = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "24_04-lts"
    version   = "latest"
  }

  admin_username      = "brenda"

  disable_password_authentication = true

  ssh_keys {
    path     = "/home/brenda/.ssh/authorized_keys"
    key_data = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICScR3bhSFsUJxogRNLI/AA9gONuGkqVgiYcrbs9c8wN brenda@DESKTOP-J7I6O7I"
  }
}

# Enable boot diagnostics
resource "azurerm_linux_virtual_machine_extension" "diagnostics" {
  name                 = "enablevmAccess"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "VMAccessForLinux"
  type_handler_version = "1.5"
}
