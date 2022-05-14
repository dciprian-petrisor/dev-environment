# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.name = "dev"
    v.cpus = 4
  end
  
  config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=0775,fmode=0664"]
  config.vm.box = "generic/debian11"
  # use default switch to avoid prompts
  config.vm.network "forwarded_port", guest: 80, host: 80 # nginx
  config.vm.network "forwarded_port", guest: 3306, host: 3306 # mysql
  config.vm.network "forwarded_port", guest: 3307, host: 3307 # keycloak mysql
  config.vm.network "forwarded_port", guest: 1025, host: 1025 # mailhog
  config.vm.network "forwarded_port", guest: 8025, host: 8025 # mailhog ui
  for i in 8050..8075 # service ports
      config.vm.network :forwarded_port, guest: i, host: i
  end 

  config.vm.provision "ansible_local" do |ansible| 
    ansible.playbook = "ansible/playbook.yml"
    ansible.vault_password_file = "ansible/vault_password.txt"
    ansible.install = true
  end
end
