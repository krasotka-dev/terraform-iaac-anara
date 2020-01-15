provider "azurerm" {
    version  = "1.27"
}
resource "azurerm_resource_group" "web_server_rg" {
    name = "web-rg"
    location  = "westus2"
}
