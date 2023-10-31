resource "azurerm_route_table" "proj_route_table" {
  name                = "proj-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "proj_to_onprem_route" {
  name                   = "proj-to-onprem-route"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.proj_route_table.name
  address_prefix         = "192.168.1.0/24"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.vpn_device_ip
}

resource "azurerm_subnet_route_table_association" "proj_subnet_route_association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.proj_route_table.id
}

resource "azurerm_network_security_group" "proj_apim_nsg" {
  name                = "proj-apim-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "proj_apim_inbound_rule" {
  name                        = "proj-apim-inbound-rule"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "192.168.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.proj_apim_nsg.name
}

resource "azurerm_network_security_rule" "proj_apim_outbound_rule" {
  name                        = "proj-apim-outbound-rule"
  priority                    = 1002
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "192.168.1.23"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.proj_apim_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "proj_apim_nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.proj_apim_nsg.id
}
