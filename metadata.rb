name 'fgs_docker'
maintainer 'FoxGuard Solutions'
maintainer_email 'pumpdev@foxguardsolutions.com'
license 'All Rights Reserved'
description 'Installs and configures docker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version ::File.read('VERSION')
source_url 'https://github.com/foxguardsolutions/docker-cookbook'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports 'centos', '>= 7.0'
supports 'ubuntu', '>= 16.04'

depends 'chef-client', '~> 8.1.2'
depends 'firewall', '~> 2.6.2'
