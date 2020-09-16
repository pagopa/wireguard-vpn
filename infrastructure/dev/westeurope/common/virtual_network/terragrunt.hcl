# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:pagopa/io-infrastructure-modules-new.git//azurerm_virtual_network?ref=v2.0.36"
}

inputs = {
  name                = "common"
  resource_group_name = "io-d-rg-common"
  address_space       = ["10.1.0.0/16"]
}
