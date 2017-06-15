require 'spec_helper'

describe 'fgs_docker::default' do
  let(:non_sudo_docker_users) do
    %w(alice bob)
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611') do |node|
      node.normal['fgs_docker']['non-sudo-docker-users'] = non_sudo_docker_users
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe)
    end.converge(described_recipe)
  end

  it 'creates a yum repository for docker-ce' do
    expect(chef_run).to create_yum_repository('docker-ce-stable')
    expect(chef_run).to makecache_yum_repository('docker-ce-stable')
  end

  it 'installs the docker-ce package' do
    expect(chef_run).to install_package('docker-ce')
  end

  it 'enables the docker service' do
    expect(chef_run).to enable_service('docker')
  end

  it 'starts the docker service' do
    expect(chef_run).to start_service('docker')
  end

  it 'creates the docker group and adds the non-sudo-docker-users' do
    expect(chef_run).to create_group('docker').with(members: non_sudo_docker_users)
  end
end
