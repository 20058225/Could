variable "location" {
  description = "Location of resources"
  type        = string
  default     = "westeurope"
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "B9IS121-rg"
}
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "B9IS121-vnet"
}
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "B9IS121-subnet"
}
variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "B9IS121-nsg"
}
variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
  default     = "B9IS121-public_ip"
}
variable "nic_name" {
  description = "Name of the network interface"
  type        = string
  default     = "B9IS121-nic"
}
variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "B9IS121-vm"
}
variable "vm_admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "useradmin"
}
variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}