# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define "docker-test1", primary: true do |s|

    # update system
    s.vm.provision "shell", inline: <<EOS
	[[ ! -f /var/tmp/provisioned ]] && {
	    sudo apt-get -y update
	    sudo date >> /var/tmp/provisioned
	}
EOS

  end
  
end
