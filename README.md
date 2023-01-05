# nsg-rule-connection

#### Issue: 
![Console Output](console.png)

#### [test.yaml](test.yaml)
```yaml
---
metadata:
  name: "Ensure that connection exists between NSG and rule"
  id: test
scope:
  provider: azure 
definition:
  and:
    - cond_type: connection
      resource_types:
      - azurerm_network_security_group
      connected_resource_types: 
      - azurerm_network_security_rule
      operator: exists
    - cond_type: filter
      attribute: resource_type
      value:
      - azurerm_network_security_group
      operator: within
```

#### [test.tf](test.tf)
```hcl
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
```