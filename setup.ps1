#Requires -RunAsAdministrator

Copy-Item $PSScriptRoot\vagrant\Vagrantfile -Destination $HOME\Vagrantfile
Copy-Item $PSScriptRoot\ansible\playbook.yml -Destination $HOME\playbook.yml

Push-Location $HOME

vagrant up --provider hyperv --provision

Pop-Location