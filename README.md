# vagrant arch

Sets up arch inside a VirtualBox and applies my dotfiles, so if you want the exact same setup I'm using, do the below:

- install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- install [vagrant](http://www.vagrantup.com/)
- install [ansible](http://www.ansible.com/home) via `brew install ansible`

```sh
git clone https://github.com/thlorenz/vagrant-arch && cd vagrant-arch
./vagrant-up-all.sh
```

Things should set themselves up and when it's done you can:

```sh
vagrant ssh
```

# Compatability

I needed to change a bunch of things when upgrading either of the above tools needed, therefore I'm listing the versions
of each with which this worked the last time.

```
➝  vagrant --version
Vagrant 1.8.4

➝  VBoxHeadless --version
Oracle VM VirtualBox Headless Interface 5.0.22
(C) 2008-2016 Oracle Corporation
All rights reserved.

5.0.22r108108

➝  ansible --version
ansible 2.0.2.0
  config file = /Volumes/d/dev/do/vagrant-arch/ansible.cfg
    configured module search path = Default w/o overrides
```

# Problems

In some cases the `base-devel` package fails to install, not sure how to fix it (could be because of the prompt it gives
you or due to some `mount + umount` files present that it can't remove). I ignore this error but if you see red in the
output make sure to `pacman -S base-devel` the first time you log into the machine if you want that package. 

## Ansible

### direct ansible access

Setup access to the VM by first removing existing entries for the IP of the VM and then authorize our public key. The
password is `vagrant`.

```sh
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.50.51
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.50.51
```

This command should succeed and thus show that all `ansible` commands can be run manually against the VM.

```sh
ansible arch -m ping -i ansible/hosts -u vagrant
```

#### ansible config

In order to not have to provide user and inventory file an `ansible.cfg` has been included which ansible will read
automatically.

Therefore you can leave off the inventory and user parameters.

```sh
ansible arch -m ping
# or
ansible arch -a 'ls -la'
```

#### running playbook

```sh
ansible-playbook ansible/arch.yml
```

or run the playbook with all features activated

```
./ansible-all.sh
```

## Note

It assumes you have a nice machine and therefore allocates **1/4 memory** and **all your CPUs** to the box in order to make it
run efficiently.

If that is a problem for you pleas edit the `Vagrantfile` and adapt the `config.vm.provider :virtualbox` section.
