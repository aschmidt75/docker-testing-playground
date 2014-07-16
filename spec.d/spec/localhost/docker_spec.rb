require 'spec_helper'

describe 'It should have docker installed' do
	describe package 'lxc-docker' do
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

end
