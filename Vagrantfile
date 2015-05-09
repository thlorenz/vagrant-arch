# -*- mode: ruby -*-
# vi: set ft=ruby :


# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

IP = '192.168.50.51'

ANSIBLE_TAGS    = ENV['ANSIBLE_TAGS']
ANSIBLE_VERBOSE = ENV['ANSIBLE_VERBOSE'].nil? ? 'vvvv' : ENV['ANSIBLE_VERBOSE']

ANSIBLE = ENV['ANSIBLE']
BASH    = ENV['BASH']
FWPORTS = ENV['FWPORTS']

# optional dependencies, these vars are picked
# up inside the ansible roles (see ansible/group_vars)
LLDB     = ENV['LLDB']
CLANG    = ENV['CLANG']
PERF     = ENV['PERF']
DEVEL    = ENV['DEVEL']
DOTFILES = ENV['DOTFILES']
VIM      = ENV['VIM']
IOJS     = ENV['IOJS']

if ANSIBLE and BASH
  throw "Use either ANSIBLE or BASH but not both together"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "terrywang/archlinux-x86_64"
  config.vm.box_url = "http://cloud.terry.im/vagrant/archlinux-x86_64.box"

  host = RbConfig::CONFIG['host_os']

  # Give VM 1/4 system memory & access to all cpu cores on the host
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i
    # sysctl returns Bytes and we need to convert to MB
    mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif host =~ /linux/
    cpus = `nproc`.to_i
    # meminfo shows KB and we need to convert to MB
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else # sorry Windows folks, I can't help you
    cpus = 4
    mem = 1024
  end

  config.vm.network :private_network, ip: IP

  if FWPORTS
    for port in 5000..5200
      config.vm.network :forwarded_port, host: port, guest: port
    end
  end

  if ANSIBLE
    config.vm.provision "ansible" do |ansible|
      ansible.extra_vars = {
        LLDB: LLDB,
        PERF: PERF,
        DEVEL: DEVEL,
        DOTFILES: DOTFILES,
        VIM: VIM
      }
      ansible.playbook = "ansible/arch.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.sudo = true
      ansible.verbose= ANSIBLE_VERBOSE
      ansible.limit = 'all'
      unless ANSIBLE_TAGS.nil?
        ansible.tags = ANSIBLE_TAGS
      end
    end
  elsif BASH
    config.vm.provision :shell, :path => "scripts/bootstrap.sh"
    if LLDB
      config.vm.provision :file do |file|
        file.source      = './scripts/install-lldb.sh'
        file.destination = '/home/vagrant/install-lldb.sh'
      end
    end

    if PERF
      config.vm.provision :file do |file|
        file.source      = './scripts/install-perf.sh'
        file.destination = '/home/vagrant/install-perf.sh'
      end
    end
  end
end
