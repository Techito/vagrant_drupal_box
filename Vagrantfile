# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Based on the Ubuntu Precise base-box
  config.vm.box = "ubuntu-precise"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Set a hostname.
  config.vm.host_name = "vm-druprecise"

  # Add a host-only network adapter, for samba etc.
  config.vm.network :hostonly, "192.168.33.10"

  # Ensure the project directory is shared with the guest.
  # Use of :owner and :group is an undocumented API referenced in
  # http://stackoverflow.com/questions/13566201
  config.vm.share_folder "project", "/mnt/shared_project_directory", "./project", :owner => "vagrant", :group => "www-data", :extra => "dmode=775,fmode=775"

  # Configure puppet.
  box_path = File.expand_path(__FILE__ + '/..')
  puppet_path = box_path + '/puppet';
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file  = "base.pp"
    puppet.manifests_path = puppet_path + "/manifests"
    puppet.module_path    = [ puppet_path + "/modules" ]
  end

end
