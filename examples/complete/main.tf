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

module "resource_names" {
  source = "git::https://github.com/launchbynttdata/tf-launch-module_library-resource_name.git?ref=1.0.1"

  for_each = var.resource_names_map

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  region                  = var.location
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
}

module "resource_group" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-resource_group.git?ref=1.0.0"

  name     = module.resource_names["resource_group"].minimal_random_suffix
  location = var.location

  tags = merge(var.tags, { resource_name = module.resource_names["resource_group"].standard })
}

module "virtual_network" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-virtual_network.git?ref=3.0.1"

  resource_group_name = module.resource_group.name
  vnet_name           = module.resource_names["virtual_network"].minimal_random_suffix
  vnet_location       = var.location

  address_space = [var.address_prefix]

  tags = merge(var.tags, { resource_name = module.resource_names["virtual_network"].standard })

  depends_on = [
    module.resource_group,
  ]
}

module "network_security_group" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-network_security_group?ref=1.0.0"

  name                = var.network_security_group_name
  resource_group_name = module.resource_group.name
  location            = var.location

  tags = var.tags

  depends_on = [
    module.resource_group,
  ]
}

module "route_table" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-route_table?ref=1.0.0"

  name                = var.route_table_name
  resource_group_name = module.resource_group.name
  location            = var.location

  tags = var.tags

  depends_on = [
    module.resource_group,
  ]
}

module "virtual_network_subnet" {
  source = "../.."

  name = var.name

  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.vnet_name

  address_prefix                                = var.address_prefix
  delegations                                   = var.delegations
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoints                             = var.service_endpoints

  network_security_group_name = var.network_security_group_name
  route_table_name            = var.route_table_name

  depends_on = [
    module.virtual_network,
    module.network_security_group,
    module.route_table,
  ]
}
