// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  address_prefixes                              = [var.address_prefix]
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoints                             = var.service_endpoints

  dynamic "delegation" {
    for_each = var.delegations

    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

data "azurerm_network_security_group" "nsg" {
  count = var.network_security_group_name != null ? 1 : 0

  name                = var.network_security_group_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  count = var.network_security_group_id != null ? 1 : length(data.azurerm_network_security_group.nsg)

  network_security_group_id = coalesce(var.network_security_group_id, data.azurerm_network_security_group.nsg[0].id)
  subnet_id                 = azurerm_subnet.subnet.id
}

data "azurerm_route_table" "rt" {
  count = var.route_table_name != null ? 1 : 0

  name                = var.route_table_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {
  count = var.route_table_id != null ? 1 : length(data.azurerm_route_table.rt)

  route_table_id = coalesce(var.route_table_id, data.azurerm_route_table.rt[0].id)
  subnet_id      = azurerm_subnet.subnet.id
}
