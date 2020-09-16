# Wireguard Vpn
Packer template and terraform configurations to setup a wireguard vpn with subspace web interface

## Howto packer

The packer template is useful to build a Azure VM with all the sofware mentioned in this [github](https://github.com/subspacecommunity/subspace) repo

Set the following env variables:

```
$ export ARM_SUBSCRIPTION_ID=<your azure subription>
$ export RESOURCE_GROUP_NAME=<the resurce grup where you want to create the vm>
$ export MANAGED_IMAGE_NAME=<the name of the vm it will be created by packer>
$ export SUBSPACE_HTTP_HOST=<subpace host domain>
```

### Run packer

```
$ cd packer
$ packer build azure-ubuntu-wireguard.json
```
