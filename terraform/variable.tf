variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
variable "location" {
  description = "Azure location"
  type        = string
  default     = "westeurope"
}
variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "useradmin"
}
variable "private_ip" {
  description = "Static private IP for NIC"
  type        = string
  default     = "10.1.0.4"
}
variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}