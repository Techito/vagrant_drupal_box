# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Based on the Ubuntu Precise base-box
  config.vm.box = "ubuntu-precise"

  # Set a hostname.
  config.vm.host_name = "vm-druprecise"

  # Add a host-only network adapter, for samba etc.
  config.vm.network :hostonly, "192.168.33.10"


  # Configure puppet.
  box_path = File.expand_path(__FILE__ + '/..')
  puppet_path = box_path + '/puppet';
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file  = "base.pp"
    puppet.manifests_path = puppet_path + "/manifests"
    puppet.module_path    = [ puppet_path + "/modules" ]
  end

end
