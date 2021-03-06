# Graylog cookbook

This cookbook sets up [Graylog](http://graylog.org).

Including the following support services:

- Elasticsearch
- MongoDB

# Quickstart

To quickly setup a working Graylog installation on a single node, do the following:

1. Setup application secrets

  This is required, as it would leave your Graylog installation insecure. Therefore the cookbook
  will fail with an error message if you do not set them!

  ```ruby
  # Set this to a random string, generated e.g. with "pwgen 96"
  node['graylog']['server']['server.conf']['password_secret'] = 'CHANGE ME!'

  # Generate with "echo -n yourpassword | shasum -a 256"
  node['graylog']['server']['server.conf']['root_password_sha2'] = '...'
  ```

2. Add default recipe to your run\_list

  ```json
  {
    "run_list": [
      "recipe[graylog::default]"
    ]
  }
  ```


## Supported Platforms

Currently tested on Ubuntu-14.04 LTS.

## Dependencies

- Chef `>= 0.11`
- [MongoDB cookbook](https://github.com/hipsnip-cookbooks/mongodb)
- [Apt cookbook](https://github.com/opscode-cookbooks/apt)


## Notes

Please do not expose the Graylog service directly in production. Instead, you
should use a reverse proxy (e.g. [nginx](http://nginx.org)).
This also adds the capability to use SSL to secure your logins.

Here's an example nginx site configuration you can use:
Note: The configuration assumes you set the `rest_listen_url` accordingly:

```ruby
default['graylog']['server']['server.conf']['web_endpoint_uri'] = 'https://graylog.example.com/api/'
```

```
# Upstream to Graylog frontend
proxy_next_upstream error timeout;
upstream graylog_web_interface {
    server 127.0.0.1:9000 fail_timeout=0;
}

upstream graylog_rest_api {
    server 127.0.0.1:12900 fail_timeout=0;
}

# Redirect everything to https
server {
    listen 80;

    return 301 https://graylog.example.com$request_uri;
}

server {
    listen 443 ssl;

    # SSL certificate
    ssl_certificate /etc/nginx/certs/graylog.example.com.crt;
    ssl_certificate_key /etc/nginx/certs/graylog.example.com.key;

    root /usr/share/nginx/html;

    proxy_pass_header Date;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host:$server_port;
    proxy_redirect off;
    proxy_set_header X_FORWARDED_PROTO $scheme;

    chunked_transfer_encoding off;

    location / {
        proxy_pass http://graylog_web_interface;
    }

    location /api {
        rewrite ^/api(.*)$ $1 break;
        proxy_pass http://graylog_rest_api;
    }
}
```


## Attributes

Global attribute:

```ruby
# Graylog version to use (must be available via the official repositories)
node['graylog']['version'] = '1.3'
```

### Graylog server

Attributes to configure Graylog.
The `password_secret` and `root_password_sha2` attributes NEED to be changed!

```ruby
# You MUST set a secret to secure/pepper the stored user passwords here. Use at least 64 characters.
# Generate one by using for example: pwgen -s 96
node['graylog']['server']['server.conf']['password_secret'] = 'CHANGE ME!'

# the default root user is named 'admin'
# You MUST specify a hash password for the root user (which you only need to initially set up the
# system and in case you lose connectivity to your authentication backend)
# This password cannot be changed using the API or via the web interface.
# Create one by using for example: "echo -n yourpassword | shasum -a 256"
#
# For testing purposes (only!) you can use the password "insecure" with the following hash
node['graylog']['server']['server.conf']['root_password_sha2'] = '1d92dae504a70fbcae6d3721a55d7eacaf94d3133ea5f0394b7d203d64841110'
```

This recipe disables multicast to learn about Elasticsearch. This is [recommended for production](http://support.torch.sh/help/kb/graylog2-server/configuring-and-tuning-elasticsearch-for-graylog2-v0200).

```ruby
# The default unicast host used and configured by this recipe is automatically retrieved from the Elasticsearch attributes
# (See below, node['graylog']['elasticsearch']['host'] and node['graylog']['elasticsearch']['port'])
node['graylog']['server']['server.conf']['elasticsearch_discovery_zen_ping_multicast_enabled'] = false
node['graylog']['server']['server.conf']['elasticsearch_discovery_zen_ping_unicast_hosts'] = '127.0.0.1:1234'
```

The cookbook accepts every possible configuration option supported by server.conf

```ruby
node['graylog']['server']['server.conf']['key'] = 'value'
```


### Elasticsearch

The `elasticsearch` recipe installs Elasticsearch using the official PPA repository.
You can finetune the installation here, although the defaults should "just work".

The settings below are the defaults

```ruby
# Elasticsearch version to use. Currently 0.90.x and 1.0.x versions are available
# See: http://www.elasticsearch.org/blog/apt-and-yum-repositories/
node['graylog']['elasticsearch']['version'] = '0.90'

# Assign half of the systems memory to elasticsearch heap (recommended setting)
# See: http://support.torch.sh/help/kb/graylog2-server/configuring-and-tuning-elasticsearch-for-graylog2-v0200
node['graylog']['elasticsearch']['heap_size'] = "#{(node['memory']['total'].to_i / 1024 / 2).to_i}m"
node['graylog']['elasticsearch']['cluster_name'] = 'graylog2'

# Elasticsearch ip:port to use
node['graylog']['elasticsearch']['host'] = '127.0.0.1'
node['graylog']['elasticsearch']['port'] = 9300
```


### MongoDB

The `default` recipe installs MongoDB, using the [MongoDB cookbook](https://github.com/hipsnip-cookbooks/mongodb).

As MongoDB is only used to store small amounts of data, it's usually sufficient to use a small data partition. Therefore, smallfile is enabled by default.
You can override the setting if needed, like so

```ruby
node['mongodb']['config']['smallfiles'] = false
```


## Recipes

### graylog::default

Installs and configures Elasticsearch, MongoDB, Graylog server and The Graylog web-interface.

### graylog::elasticsearch

Installs Elasticsearch from the official PPA, and configures it for Graylog use.

### graylog::server

Installs and configures Graylog server.


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Chris Aumann (<me@chr4.org>)
