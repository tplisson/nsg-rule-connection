resource "azurerm_resource_group" "test" {
  name     = "test"
  location = "Canada Central"
}

resource "azurerm_network_security_group" "pass" {
  name                = "pass"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}
resource "azurerm_network_security_rule" "pass" {
  name                        = "pass"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.pass.name
}

resource "azurerm_network_security_group" "fail" {
  name                = "fail"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}