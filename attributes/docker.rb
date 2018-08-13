default['fgs_docker']['docker-version'] = case node['platform_family']
                                          when 'debian'
                                            '18.06.0~ce~3-0~ubuntu'
                                          when 'rhel'
                                            '18.03.0.ce-1.el7.centos'
                                          end
default['fgs_docker']['non-sudo-docker-users'] = []
default['firewall']['firewalld']['permanent'] = true
default['firewall']['allow_ssh'] = true
