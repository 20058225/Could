terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"  # Ensure you are using a compatible version
    }
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
  subscription_id = "a77c589e-092e-413f-9643-e91ac54cdb6a"
}

# Data block to retrieve an existing resource group
data "azurerm_resource_group" "example" {
  name = "B9IS121_GROUP"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "B9IS121-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = "westeurope"
  resource_group_name = data.azurerm_resource_group.example.name
}
resource "azurerm_subnet" "subnet" {
  name                 = "B9IS121-subnet"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "B9IS121-nic"
  location            = "westeurope"
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "B9IS121-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
 }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "B9IS121"
  resource_group_name = "B9IS121_group"
  location            = "westeurope"
  size                = "Standard_B1s"
  admin_username      = "brenda"

  admin_ssh_key {
    username   = "brenda"
    public_key = file("/home/brenda/.ssh/id_rsa.pub")
  }

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

# Output the ID of the existing resource group
output "resource_group_id" {
  value = data.azurerm_resource_group.example.id
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}