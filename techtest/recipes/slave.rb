#
# Cookbook:: techtest
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# :: Install docker and setting up the host to expose Docker API
docker_service 'default' do
  host      [ 'tcp://0.0.0.0:4243', 'unix:///var/run/docker.sock' ]
  action    [:create, :start]
end

# :: Install and enable firewall in the instance
firewall 'default' do
  action :install
end

# :: Allowing SSH port
firewall_rule 'ssh' do
  port 22
  command :allow
end

# :: Allowing Docker API port
firewall_rule 'docker-api' do
  port     4243
  command  :allow
end

# :: Allowing Docker Hotspot port used to communicate between Jenkins Master and Docker-API as cloud provider
firewall_rule 'docker-hotspot' do
  port    32768..60999
  command :allow
end
