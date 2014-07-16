# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define "docker-test1", primary: true do |s|

    s.vm.synced_folder "spec.d/", "/mnt/spec.d"

    # update system
    s.vm.provision "shell", inline: <<EOS
test -f /var/tmp/provisioned || {
	sudo apt-get -y update
	sudo date >> /var/tmp/provisioned
}
EOS
    # install puppet module for docker
    s.vm.provision "shell", inline:
	'sudo su - -c "( puppet module list | grep -q garethr-docker ) || puppet module install garethr-docker"'

    # provision the node
    s.vm.provision :puppet, :options => "--verbose" do |puppet|
 	puppet.manifests_path = "puppet.d/manifests"
	puppet.module_path = "puppet.d/modules"
        puppet.manifest_file = "default.pp"
    end

    # install & run serverspec
    s.vm.provision 'shell', inline: <<EOS
( sudo gem list --local | grep -q serverspec ) || sudo gem install specinfra serverspec rake
cd /mnt/spec.d
rake spec

EOS

  end
  
end
