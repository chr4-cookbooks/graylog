# graylog2-server REST URIs (one or more, comma separated) For example: "http://127.0.0.1:12900/,http://127.0.0.1:12910/"
default['graylog']['web_interface']['graylog2-web-interface.conf']['graylog2-server.uris'] = 'http://127.0.0.1:12900'

# Learn how to configure custom logging in the documentation:
#    http://support.torch.sh/help/kb/graylog2-web-interface/configuring-web-interface-logging

# Secret key
# ~~~~~
# The secret key is used to secure cryptographics functions. Set this to a long and randomly generated string.
# If you deploy your application to several instances be sure to use the same key!
# Generate for example with: pwgen -s 96
default['graylog']['web_interface']['graylog2-web-interface.conf']['application.secret'] = 'this-value-needs-to-be-at-least-16-chars-long'

# Web interface timezone
# Graylog2 stores all timestamps in UTC. To properly display times, set the default timezone of the interface.
# If you leave this out, Graylog2 will pick your system default as the timezone. Usually you will want to configure it explicitly.
default['graylog']['web_interface']['graylog2-web-interface.conf']['timezone'] = nil

# Message field limit
# Your web interface can cause high load in your browser when you have a lot of different message fields. The default
# limit of message fields is 100. Set it to 0 if you always want to get all fields. They are for example used in the
# search result sidebar or for autocompletion of field names.
default['graylog']['web_interface']['graylog2-web-interface.conf']['field_list_limit'] = 100

# Use this to run Graylog2 with a path prefix
default['graylog']['web_interface']['graylog2-web-interface.conf']['application.context'] = nil

# You usually do not want to change this.
default['graylog']['web_interface']['graylog2-web-interface.conf']['application.global'] = 'lib.Global'
