provider "azurerm" {
    version  = "1.27"
}
resource "azurerm_resource_group" "web_server_rg" {
    name = "web-rg"
    location  = "westus2"
}

resource "azurerm_virtual_network" "vnet1" {
    name = "vnet1"
    location = "westus2"
    resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "private" {
    name = "private"
    resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
    address_prefix = "10.0.1.0/24"
}


resource "azurerm_network_security_group" "sec_group1" {
  name                = "sec_group1"
  location            = "${azurerm_resource_group.web_server_rg.location}"
  resource_group_name = "${azurerm_resource_group.web_server_rg.name}"

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}



# vm1" {
resource "azurerm_network_interface" "nic1" {
  name = "nic1"
  location = "westus2"
  resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
  ip_configuration {
    name = "testconfiguration1"
    subnet_id = "${azurerm_subnet.private.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = "${azurerm_public_ip.IP.id}"
  }
}

resource "azurerm_public_ip" "IP" {
    name = "public_ip"
    location = "westus2"
    resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
    allocation_method = "Dynamic"
}



resource "azurerm_virtual_machine" "vm1" {
  name = "vm1"
  location = "westus2"
  resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.nic1.id}"]
  vm_size = "Standard_DS1_v2"
  storage_image_reference {
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.5"
    version = "latest"
  }
  storage_os_disk {
    name = "myosdisk1"
    caching = "ReadWrite"
    create_option = "FromImage"
   managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name = "vm1"
    admin_username = "centos"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags  {
    environment = "staging"
  }
}



# VM 2
resource "azurerm_network_interface" "nic2" {
  name = "nic2"
  location = "westus2"
  resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
  ip_configuration {
    name = "testconfiguration2"
    subnet_id = "${azurerm_subnet.private.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = "${azurerm_public_ip.IP2.id}"
  }
}
resource "azurerm_public_ip" "IP2" {
    name = "public_ip2"
    location = "westus2"
    resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
    allocation_method = "Dynamic"
}

resource "azurerm_virtual_machine" "vm2" {
  name = "vm2"
  location = "westus2"
  resource_group_name = "${azurerm_resource_group.web_server_rg.name}"
  network_interface_ids = ["${azurerm_network_interface.nic2.id}"]
  vm_size = "Standard_DS1_v2"
  storage_image_reference {
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.5"
    version = "latest"
  }
  storage_os_disk {
    name = "myosdisk2"
    caching = "ReadWrite"
    create_option = "FromImage"
   managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name = "vm2"
    admin_username = "centos"
  }
  os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/centos/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2oBmpO16ZsjyvLizDqgxX9CqSPBSg31mcTK+lluWsmIoaW/MJ/6S8pQFXSEpipHDgwplPvijFzodROhxa8JwSGWfQlmNhGHDDHTN8bPsoLmw6nk1fmoq61fbQ75OMWIbbiZVtvfI6cT2p+N5mOKf94Kr0adEKEyqLYrj7Sc8eUnJDQ+r0kgjrNqKL1cHjIw+r/CmwxeBx/rM5ix/zoJ9o7S4r//wSWrpr/FXQ9bHLAAwxwtuichjDTeCOl6FK8Ak008oSankrSGLP9os90eMfqZYrSr4RKBjDSG3a+KG/6UDDORmrMiOLa0hjYGbuhu3auVTUmcNv21gb1h0H3QLd root@ip-172-31-45-232.eu-west-1.compute.internal"
        }
    }
  tags  {
    environment = "staging"
  }
}
