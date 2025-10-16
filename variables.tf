variable "creator_tag_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type = string
}

variable "admin_username" {
  type = string

}

variable "vm_password" {
  description = "Admin password for the VM (sensitive). Must follow Azure Linux password requirements."
  type        = string
  sensitive   = true
}