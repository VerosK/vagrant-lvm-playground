# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.hostmanager.enabled = false

  config.vm.box = "centos-6.x-64bit-puppet.3.x"
  config.vm.box_url = "http://packages.vstone.eu/vagrant-boxes/centos-6.x-64bit-latest.box"

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    vb.gui = true
 
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]

    # based https://gist.github.com/leifg/4713995
    # and https://www.virtualbox.org/ticket/7325
    vb.customize ["createhd", "--filename", 'second.vdi', "--size", "4096"]
    vb.customize ["storageattach", :id, '--storagectl', 'SATA Controller',
			'--port', 7, '--device', 0, '--type', 'hdd', 
			'--medium', 'second.vdi']
    vb.customize ["setextradata", :id, 
		"VBoxInternal/Devices/ahci/0/Config/Port7/SerialNumber",
		"second"]
    vb.customize ["setextradata", :id, 
		"VBoxInternal/Devices/ahci/0/Config/Port7/ModelNumber",
		"VIRTUAL"]
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = ['modules']
  end

end
