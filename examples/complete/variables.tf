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

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
    virtual_network = {
      name       = "vnet"
      max_length = 80
    }
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "redis"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "location" {
  description = "target resource group resource mask"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# subnet inputs
variable "name" {
  description = "Name of the subnet"
  type        = string
}

variable "address_prefix" {
  description = "CIDR block that represents the IP address space of the subnet"
  type        = string
  default     = "10.1.0.0/24"
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

# route table inputs

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

# network security group inputs

variable "network_security_group_name" {
  description = "Name of the network security group"
  type        = string
}
