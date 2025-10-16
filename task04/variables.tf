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

variable vnet_name {
  type        = string
  description = "Name of the Virtual Network."
}

variable azurerm_subnet_frontend {
  type        = string
  description = "Name of the Subnet."
}

variable azure_nic {
  type        = string
  description = "Name of the Network Interface."
}

variable azure_nsg {
  type        = string
  description = "Name of the Network Security Group."
}

variable azure_http {
  type        = string
  description = "Name of the HTTP rule."
}

variable azure_ssh {
  type        = string
  description = "Name of the HTTP rule."
}

variable azure_ip {
  type        = string
  description = "Name of the Public IP."
}

variable azure_domain_label {
  type        = string
  description = "Domain label for the Public IP."
}