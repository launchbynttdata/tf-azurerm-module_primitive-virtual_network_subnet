# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.110 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | terraform.registry.launch.nttdata.com/module_primitive/virtual_network/azurerm | ~> 3.0 |
| <a name="module_network_security_group"></a> [network\_security\_group](#module\_network\_security\_group) | terraform.registry.launch.nttdata.com/module_primitive/network_security_group/azurerm | ~> 1.0 |
| <a name="module_route_table"></a> [route\_table](#module\_route\_table) | terraform.registry.launch.nttdata.com/module_primitive/route_table/azurerm | ~> 1.0 |
| <a name="module_virtual_network_subnet"></a> [virtual\_network\_subnet](#module\_virtual\_network\_subnet) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "resource_group": {<br>    "max_length": 80,<br>    "name": "rg"<br>  },<br>  "virtual_network": {<br>    "max_length": 80,<br>    "name": "vnet"<br>  }<br>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"subnet"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | target resource group resource mask | `string` | `"eastus"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the subnet | `string` | n/a | yes |
| <a name="input_address_prefix"></a> [address\_prefix](#input\_address\_prefix) | CIDR block that represents the IP address space of the subnet | `string` | `"10.1.0.0/24"` | no |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | Map of service delegations for the subnet | <pre>map(object({<br>    service_name    = string<br>    service_actions = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | List of service endpoints to associate with the subnet | `list(string)` | `[]` | no |
| <a name="input_private_endpoint_network_policies"></a> [private\_endpoint\_network\_policies](#input\_private\_endpoint\_network\_policies) | Possible values are 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled' and 'RouteTableEnabled' | `string` | `"Disabled"` | no |
| <a name="input_private_link_service_network_policies_enabled"></a> [private\_link\_service\_network\_policies\_enabled](#input\_private\_link\_service\_network\_policies\_enabled) | Enable network policies for the private link service on the subnet | `bool` | `true` | no |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Name of the route table | `string` | n/a | yes |
| <a name="input_network_security_group_name"></a> [network\_security\_group\_name](#input\_network\_security\_group\_name) | Name of the network security group | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
