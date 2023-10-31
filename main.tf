provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "proj" {
  name     = "proj-rg"
  location = var.location
}

module "vpn" {
  source              = "./modules/vpn"
  resource_group_name = azurerm_resource_group.proj.name
  location            = var.location
}

module "apim" {
  source              = "./modules/apim"
  resource_group_name = azurerm_resource_group.proj.name
  location            = var.location
}

module "routing_security" {
  source              = "./modules/routing_security"
  resource_group_name = azurerm_resource_group.proj.name
  location            = azurerm_resource_group.proj.location
  vpn_device_ip       = "10.0.1.4" # Adjust as needed
  subnet_id           = module.vpn.subnet_id # Assuming the VPN module outputs the subnet ID
}
