#
# Cookbook Name:: graylog
# Attributes:: elasticsearch
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

# Elasticsearch version to use. Currently 0.90.x and 1.0.x versions are available
# See: http://www.elasticsearch.org/blog/apt-and-yum-repositories/
default['graylog']['elasticsearch']['version'] = '1.0'

# Assign half of the systems memory to elasticsearch heap
default['graylog']['elasticsearch']['heap_size'] = "#{(node['memory']['total'].to_i / 1024 / 2).to_i}m"
