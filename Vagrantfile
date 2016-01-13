# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'diamondd.local'

  config.vm.box = "phusion/ubuntu-14.04-amd64"

  config.vm.provider "vmware_fusion" do |provider|
    provider.vmx['memsize'] = 2048
    provider.vmx['numvcpus'] = 2
  end

  # Share my entire home directory, so I can share various things with
  # individual docker containers.
  config.vm.synced_folder ENV['HOME'], '/mnt'
end
