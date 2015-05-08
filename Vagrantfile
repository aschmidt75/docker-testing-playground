# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define "docker-test1", primary: true do |s|

    s.vm.synced_folder "spec.d/", "/mnt/spec.d"

    # install puppet module for docker
    s.vm.provision "shell", inline:
	    'sudo su - -c "( puppet module list | grep -q garethr-docker ) || puppet module install -v 4.0.2 garethr-docker"'

    # provision the node
    s.vm.provision :puppet, :options => "--verbose" do |puppet|
 	puppet.manifests_path = "puppet.d/manifests"
	puppet.module_path = "puppet.d/modules"
        puppet.manifest_file = "default.pp"
    end

    # install & run serverspec
    s.vm.provision 'shell', inline: <<EOS
( sudo gem list --local | grep -q serverspec ) || {
	sudo gem install rake -v '10.3.2' --no-ri --no-rdoc
	sudo gem install rspec -v '3.0.0' --no-ri --no-rdoc
	sudo gem install specinfra -v '2.31.0' --no-ri --no-rdoc
	sudo gem install serverspec -v '2.16.0' --no-ri --no-rdoc
}
cd /mnt/spec.d
rake spec

EOS

  end
  
end
