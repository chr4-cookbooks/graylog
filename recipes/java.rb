#
# Cookbook Name:: graylog
# Recipe:: default
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

package 'lsb-release'

# Graylog 2.0 requires Java 8
apt_repository 'openjdk-8' do
  uri 'http://ppa.launchpad.net/openjdk-r/ppa/ubuntu'
  distribution node['lsb']['codename']
  components %w(main)
  key '86F44E2A'
  keyserver 'keyserver.ubuntu.com'
  only_if { node['lsb']['codename'] == 'trusty' }
end

package 'openjdk-8-jdk'
