# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "cameronmalek/arch1403"
  config.vm.provision :shell, :path => "bootstrap.sh"

  # let's get some memory and CPUs shall we?
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096" ]
    # http://stackoverflow.com/a/17126363
    vb.customize ["modifyvm", :id, "--cpus", "4" ]
    vb.customize ["modifyvm", :id, "--ioapic", "on" ]
  end
end
