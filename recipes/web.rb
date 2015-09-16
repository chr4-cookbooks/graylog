#
# Cookbook Name:: graylog
# Recipe:: web_interface
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

# Check whether application secret is set
unless node['graylog']['web_interface']['web.conf']['application.secret']
  fail <<-EOS
    Application secret is not set!
    Please set the attribute `default['graylog']['web_interface']['web.conf']['application.secret']`
    In your node configuration or wrapper cookbook! Use at least 64 characters.
    Generate one by using for example: "pwgen -s 96".
  EOS
end

package 'graylog-web'

# Configuration
template '/etc/graylog/web/web.conf' do
  mode      00644
  source    'graylog/web.conf.erb'
  variables config: node['graylog']['web_interface']['web.conf']
end

service 'graylog-web' do
  supports   restart: true
  action     [:enable, :start]
  subscribes :restart, 'template[/etc/graylog/web/web.conf]'
end
