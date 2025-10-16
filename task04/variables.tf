variable "creator_tag_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type = string
  description = "Azure region to deploy resources."
}

variable "admin_username" {
  type = string
  description = "Admin username for the VM."

}

variable "vm_password" {
  description = "Admin password for the VM (sensitive). Must follow Azure Linux password requirements."
  type        = string
  sensitive   = true
}