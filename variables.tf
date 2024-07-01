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

# COMMON
variable "name" {
  description = "Name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the subnet"
  type        = string
}

# subnet inputs

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_prefix" {
  description = "CIDR block that represents the IP address space of the subnet"
  type        = string
}

variable "delegations" {
  description = "Map of service delegations for the subnet"
  type = map(object({
    service_name    = string
    service_actions = list(string)
  }))
  default = {}
}

variable "service_endpoints" {
  description = "List of service endpoints to associate with the subnet"
  type        = list(string)
  default     = []
}

variable "private_endpoint_network_policies" {
  description = "Possible values are 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled' and 'RouteTableEnabled'"
  type        = string
  default     = "Disabled"
}

variable "private_link_service_network_policies_enabled" {
  description = "Enable network policies for the private link service on the subnet"
  type        = bool
  default     = true
}

variable "network_security_group_id" {
  description = "ID of the network security group to associate with the subnet"
  type        = string
  default     = null
}

variable "network_security_group_name" {
  description = "Name of the network security group to associate with the subnet. Only used when `network_security_group_id` is not set"
  type        = string
  default     = null
}

variable "route_table_id" {
  description = "ID of the route table to associate with the subnet"
  type        = string
  default     = null
}

variable "route_table_name" {
  description = "Name of the route table to associate with the subnet. Only used when `route_table_id` is not set"
  type        = string
  default     = null
}
