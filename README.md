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
## Howto terragrunt

All resources to deploy the wireguard vpn can be provisioned with terraforn and terragrunt.

First of all you need to install the version shown in the files:
- infrastructure/.terraform-version
- infrastructure/.terragrunt-version

Note: it's recommended to use [tfenv](https://github.com/tfutils/tfenv) and [tgenv](https://github.com/cunymatthieu/tgenv) to manange different verions of terraform and terragrung.

Once you have setup the suitable versions of terrafom and terragrunt:

```
$ cd infrastructure/dev/westeurope/common/resource_group
$ terragrunt init
$ terragrunt apply
```

The code above it's just an example. Apply all configurations with terragrunt plan-all and terragrunt appy-all.
