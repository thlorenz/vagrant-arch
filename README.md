# vagrant arch

Sets up arch inside a VirtualBox and applies my dotfiles, so if you want the exact same setup I'm using, do the below:

- install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- install [vagrant](http://www.vagrantup.com/)

```sh
git clone https://github.com/thlorenz/vagrant-arch && cd vagrant-arch
vagrant up
```

Things should set themselves up and when it's done you can:

```sh
vagrant ssh
```

## Note

It assumes you have a nice machine and therefore allocates **1/4 memory** and **all your CPUs** to the box in order to make it
run efficiently.

If that is a problem for you pleas edit the `Vagrantfile` and adapt the `config.vm.provider :virtualbox` section.
