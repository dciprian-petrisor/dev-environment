# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "hyperv" do |h|
    h.memory = 4096
    h.maxmemory = 8192
    h.vmname = "dev"
    h.vm_integration_services = {
      guest_service_interface: true,
      heartbeat: true,
      key_value_pair_exchange: true,
      shutdown: true,
      time_synchronization: true,
      vss: true
    }
    h.cpus = 8
    h.enable_enhanced_session_mode = true
    h.linked_clone = true
  end

  config.vm.box = "pcd/pop-os-21.10"
  config.vm.box_version = "1.0.1"
  # Leave this here, pop-os is based on ubuntu, but there is no official support
  # for detecting the guest OS, which is needed for things like shares to work properly.
  config.vm.guest = "ubuntu"
  # use default switch to avoid prompts
  config.vm.network "public_network", bridge: "Default Switch"
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.install = true
  end
end
