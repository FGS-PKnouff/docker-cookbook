case node['platform_family']
when 'debian'
  apt_repository 'docker-ce-stable' do
    components ['stable']
    uri "https://download.docker.com/linux/#{node['platform']}"
    arch 'amd64'
    key 'https://download.docker.com/linux/ubuntu/gpg'
    action :add
    cache_rebuild true
  end
when 'rhel'
  yum_repository 'docker-ce-stable' do
    description 'Docker Repository'
    baseurl 'https://download.docker.com/linux/centos/7/$basearch/stable'
    gpgkey 'https://download.docker.com/linux/centos/gpg'
    enabled true
    make_cache true
    fastestmirror_enabled true
    action %i[create makecache]
  end
end

package 'docker-ce' do
  action :install
  version node['fgs_docker']['docker-version']
end

service 'docker' do
  action %i[enable start]
end

node['fgs_docker']['non-sudo-docker-users'].each do |username|
  user username
end

group 'docker' do
  action :create
  members node['fgs_docker']['non-sudo-docker-users']
end

include_recipe 'chef-client'

include_recipe 'firewall::default'

firewall_rule 'docker' do
  port 2376
  protocol :tcp
  command :allow
end

firewall_rule 'docker swarm' do
  port 2377
  protocol :tcp
  command :allow
end

firewall_rule 'docker network disco tcp' do
  port 7946
  protocol :tcp
  command :allow
end

firewall_rule 'docker network disco udp' do
  port 7946
  protocol :udp
  command :allow
end

firewall_rule 'docker container ingress network' do
  port 4789
  protocol :udp
  command :allow
end

firewall_rule 'graylog web' do
  port 9000
  protocol :tcp
  command :allow
end

firewall_rule 'graylog input http' do
  port 12202
  protocol :tcp
  command :allow
end
