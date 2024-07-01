name                        = "cool-stuff-subnet"
route_table_name            = "cool-stuff-route-table"
network_security_group_name = "cool-stuff-network-security-group"
resource_names_map = {
  resource_group = {
    name       = "rg"
    max_length = 80
  }
  virtual_network = {
    name       = "vnet"
    max_length = 80
  }
}
instance_env            = 0
instance_resource       = 0
logical_product_family  = "launch"
logical_product_service = "redis"
class_env               = "gotest"
location                = "eastus"
