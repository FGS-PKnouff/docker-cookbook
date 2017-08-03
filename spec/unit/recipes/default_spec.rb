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

  it 'opens the docker TCP port' do
    expect(chef_run).to create_firewall_rule('docker').with(
      port: 2376,
      protocol: :tcp,
      command: :allow
    )
  end

  it 'opens the docker swarm TCP port' do
    expect(chef_run).to create_firewall_rule('docker swarm').with(
      port: 2377,
      protocol: :tcp,
      command: :allow
    )
  end

  it 'opens the docker network disco tcp port' do
    expect(chef_run).to create_firewall_rule('docker network disco tcp').with(
      port: 7946,
      protocol: :tcp,
      command: :allow
    )
  end

  it 'opens the docker network disco udp port' do
    expect(chef_run).to create_firewall_rule('docker network disco udp').with(
      port: 7946,
      protocol: :udp,
      command: :allow
    )
  end

  it 'opens the docker container ingress network port' do
    expect(chef_run).to create_firewall_rule('docker container ingress network').with(
      port: 4789,
      protocol: :udp,
      command: :allow
    )
  end

  it 'opens the graylog web port' do
    expect(chef_run).to create_firewall_rule('graylog web').with(
      port: 9000,
      protocol: :tcp,
      command: :allow
    )
  end

  it 'opens the graylog input http port' do
    expect(chef_run).to create_firewall_rule('graylog input http').with(
      port: 12202,
      protocol: :tcp,
      command: :allow
    )
  end
end
