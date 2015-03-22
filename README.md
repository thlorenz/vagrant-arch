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
