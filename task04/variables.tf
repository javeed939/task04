variable "creator_tag_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources."
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."

}

variable "vm_password" {
  description = "Admin password for the VM (sensitive). Must follow Azure Linux password requirements."
  type        = string
  sensitive   = true
  default     = "Azureuser@4567"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network."
}

variable "azurerm_subnet_frontend" {
  type        = string
  description = "Name of the Subnet."
}

variable "azure_nic" {
  type        = string
  description = "Name of the Network Interface."
}

variable "azure_nsg" {
  type        = string
  description = "Name of the Network Security Group."
}

variable "azure_http" {
  type        = string
  description = "Name of the HTTP rule."
}

variable "azure_ssh" {
  type        = string
  description = "Name of the HTTP rule."
}

variable "azure_ip" {
  type        = string
  description = "Name of the Public IP."
}

variable "azure_domain_label" {
  type        = string
  description = "Domain label for the Public IP."
}

variable "azure_resource_group" {
  type        = string
  description = "Name of the resource group."
}

variable "azure_vm" {
  type        = string
  description = "Name of the Virtual Machine."
}

variable "frontend_prefixes" {
  type        = list(string)
  description = "Address prefixes for the frontend subnet."
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network."
}

variable "os_disk_name" {
  type        = string
  description = "Name of the OS disk."
}

variable "size" {
  type        = string
  description = "Size of the Virtual Machine."

}

variable "ip_configuration" {
  type        = string
  description = "Name of the IP configuration."
}

variable "deployment_prefix" {
  type        = string
  description = "Deployment prefix to identify resources."
}