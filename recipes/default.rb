yum_repository 'docker-ce-stable' do
  description 'Docker Repository'
  baseurl 'https://download.docker.com/linux/centos/7/$basearch/stable'
  gpgkey 'https://download.docker.com/linux/centos/gpg'
  enabled true
  make_cache true
  fastestmirror_enabled true
  action [:create, :makecache]
end

package 'docker-ce' do
  action :install
  version node['fgs_docker']['docker-version']
end

service 'docker' do
  action [:enable, :start]
end

node['fgs_docker']['non-sudo-docker-users'].each do |username|
  user username
end

group 'docker' do
  action :create
  members node['fgs_docker']['non-sudo-docker-users']
end
include_recipe 'chef-client'
