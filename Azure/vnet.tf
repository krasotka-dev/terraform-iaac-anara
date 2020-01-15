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