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
