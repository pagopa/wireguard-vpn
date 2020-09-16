dependency "resource_group" {
  config_path = "../resource_group"
}

dependency "subnet" {
  config_path = "../subnet_vpn"
}

/*
dependency "key_vault_common" {
  config_path = "../../common/key_vault"
}
*/

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:pagopa/io-infrastructure-modules-new.git//azurerm_linux_virtual_machine?ref=master"
}

inputs = {
  name = "WireGuard"
  size = "Standard_D4_v2"

  subnet_id           = dependency.subnet.outputs.id
  computer_name       = "WireGuard"
  admin_username      = "adminuser"
  resource_group_name = dependency.resource_group.outputs.resource_name
  assign_public_ip    = true
  allocation_method   = "Static"

  source_image_reference = [{
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }]

  os_disk = {
    # Disk name replaced from a backup.
    name                      = "subspace"
    caching                   = "ReadWrite"
    storage_account_type      = "Standard_LRS"
    disk_size_gb              = "30"
    disk_encryption_set_id    = null
    write_accelerator_enabled = false
  }

  admin_ssh_key = [{
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }]

  # SSH access from Leonardo subnet only
  security_rules = [{
    name                         = "SSH"
    description                  = "Inbound ssh"
    priority                     = 1001
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = [22]
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  },
  {
    name                         = "Http"
    description                  = "Inbound http"
    priority                     = 1011
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = [80]
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  },
  {
    name                         = "Https"
    description                  = "Inbound https"
    priority                     = 1021
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = [443]
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  },
  {
    name                         = "WireGuard"
    description                  = "Inbound https"
    priority                     = 1031
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Udp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = [51820]
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
  }]

  dns_record = {
    name                     = "vpn"
    zone_name                = "dev.io.italia.it"
    zone_resource_group_name = "dev-cert"
    ttl                      = 300
  }
}
