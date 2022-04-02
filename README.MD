# Dev Environment

The goal of this repository is to make it easy to set up a development environment anywhere, just how I prefer it.

I usually work in a Linux environment, however I prefer Windows for daily activities.

As such, this repository makes use of Vagrant and Ansible to set up a VM in Hyper-V with my preferred configuration.

## Packer set up instructions

These instructions are only relevant if you want to build the vanilla Pop! OS box for Hyper-V.

If you want to use one that is already published to Vagrant's cloud, then go to the [Vagrant set up instructions](#vagrant-set-up-instructions).


1. Enable Hyper-V.
2. Create a Hyper-V External Switch and set it in the ```packer/packer_templates/popos/popos-*.json``` file you want to use.
3. Run ```packer build -only=hyperv-iso popos-*.json``` in the packer_templates/popos directory to build the box.
4. If all went well, the box should have been built successfully.

## Vagrant set up instructions

1. Enable Hyper-V.
2. Install Vagrant.
3. Run ```vagrant up --provider hyperv``` from an admin console to initialize the VM.


