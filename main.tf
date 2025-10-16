resource "azurerm_resource_group" "rg" {
  name     = "cmaz-gt5izdn0-mod4-rg"
  location = var.location

  tags = {
    Creator = "javeed_shaik@epam.com"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "cmaz-gt5izdn0-mod4-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Creator = var.creator_tag_name
  }
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "cmaz-gt5izdn0-mod4-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "cmaz-gt5izdn0-mod4-nginx"

  tags = {
    Creator = var.creator_tag_name
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "cmaz-gt5izdn0-mod4-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Creator = var.creator_tag_name
  }
}

# Standalone NSG rule for HTTP
resource "azurerm_network_security_rule" "allow_http" {
  name                        = "AllowHTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80"]
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Standalone NSG rule for SSH
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "AllowSSH"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_interface" "nic" {
  name                = "cmaz-gt5izdn0-mod4-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = {
    Creator = var.creator_tag_name
  }
}


resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "cmaz-gt5izdn0-mod4-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2s_v2"
  admin_username      = var.admin_username
  admin_password      = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "cmaz-gt5izdn0-mod4-osdisk"
  }

  tags = {
    Creator = var.creator_tag_name
  }

  # Use remote-exec provisioner to install and start nginx
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = azurerm_public_ip.pip.ip_address
      user     = var.admin_username
      password = var.vm_password
      timeout  = "2m"
    }

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      # create a small index to prove ownership
      "echo '<h1>NGINX on Terraform VM - cmaz-gt5izdn0</h1>' | sudo tee /var/www/html/index.html",
    ]
  }
}
