dependency "virtual_network_common" {
  config_path = "../../common/virtual_network"
}

dependency "resource_group_common" {
  config_path = "../../common/resource_group"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:pagopa/io-infrastructure-modules-new.git//azurerm_subnet?ref=v2.0.39"
}

inputs = {
  name                 = "vpn"
  address_prefix       = "10.1.0.0/24"
  resource_group_name  = dependency.resource_group_common.outputs.resource_name
  virtual_network_name = dependency.virtual_network_common.outputs.resource_name
}
