#
# Cookbook Name:: graylog
# Recipe:: server
#
# Copyright (C) 2014 Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Installation
ark 'graylog2-server' do
  url     node['graylog']['server']['url']
  version node['graylog']['server']['version']
  action  :install
end

# Create user
user node['graylog']['server']['user'] do
  system true
  home   '/nonexistent'
  shell  '/bin/false'
end

# Configuration
template '/etc/graylog2.conf' do
  mode      00644
  source    'graylog/graylog2.conf.erb'
  variables config: node['graylog']['server']['graylog2.conf']
end

# Graylog writes a node-id to this file, needs access
file '/etc/graylog2-server-node-id' do
  owner node['graylog']['server']['user']
end

# Service
template '/etc/init/graylog2-server.conf' do
  mode      00644
  source    'upstart/graylog2-server.erb'
  variables dir:        '/usr/local/graylog2-server',
            user:       node['graylog']['server']['user'],
            configfile: '/etc/graylog2.conf'
end

link '/etc/init.d/graylog2-server' do
  to '/lib/init/upstart-job'
end

service 'graylog2-server' do
  supports restart: true
  action [ :enable, :start ]

  subscribes :restart, 'template[/etc/graylog2.conf]'
  subscribes :restart, 'template[/etc/init/graylog2-server.conf]'
end
