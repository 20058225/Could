variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "a77c589e-092e-413f-9643-e91ac54cdb6a"
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
variable "private_key_path" {
  description = "Path to SSH private key"
  type        = string
}