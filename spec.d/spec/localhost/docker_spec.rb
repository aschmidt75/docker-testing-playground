require 'spec_helper'

describe 'It should have docker installed' do
	describe package 'lxc-docker-1.1.1' do
		it { should be_installed }
	end

	describe group 'docker' do
		it { should exist }
	end

	describe file '/var/run/docker.sock' do
		it { should be_socket }
		it { should be_owned_by 'root' }
		it { should be_grouped_into 'docker' }
	end

	describe command 'docker -v' do
		its(:stdout) { should match '^Docker version 1\.1\.1.*' }
 	end
end

describe 'Docker should be running' do
	describe service 'docker' do
		it { should be_running }
	end

	describe process 'docker' do
		it { should be_running }
		its(:args) { should match /127\.0\.0\.1:2375/ }
		its(:args) { should match /\/var\/run\/docker\.sock/ }
	end

	describe port 2375 do
		it { should be_listening.with 'tcp' }
	end
end

describe 'Docker should have networking set up' do
	describe interface 'docker0' do
		it { should have_ipv4_address("172.17.42.1/16") }
	end

	describe iptables do
		  it { should have_rule('-P POSTROUTING ACCEPT').
	 		with_table('nat').
			with_chain('POSTROUTING') 
		  }
		  it { should have_rule('-A POSTROUTING -s 172.17.0.0/16 ! -d 172.17.0.0/16 -j MASQUERADE').
	 		with_table('nat').
			with_chain('POSTROUTING') 
		  }
	end

end

describe 'Docker settings should be' do
	describe command 'docker info' do
		its(:stdout) { should match /^Storage Driver.*devicemapper/ }
		its(:stdout) { should match /^Execution Driver.*native/ }
	end
end

