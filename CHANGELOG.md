Changelog for Graylog cookbook

1.2.1
-----

- Use Elasticsearch `1.7` by default

1.2.0
-----

- Update default Graylog version to `1.2.0`
- Use official repositories to install `graylog-server` and `graylog-web` packages
- Rename `web_interface` recipe to `web`, to follow package naming
- Rename `graylog.conf` attributes to `server.conf` to follow package naming
- Rename `graylog-web-interface.conf` attribtues to `web.conf` to follow package naming
- Add newly introduced options to attributes

1.1.6
-----

- Update default Graylog version to `1.1.6`

1.1.5
-----

- Update default Graylog version to `1.1.5`

1.1.4
-----

- Update default Graylog version to `1.1.4`

1.1.3
-----

- Update default Graylog version to `1.1.3`

1.1.1
-----

- Update default Graylog version to `1.1.1`
- Update default elasticsearch version to `1.5`

1.0.0
-----

- Update default Graylog version to `1.0.0`
- Configuration option and config file changes according to version `1.0.0`

  Attribute names for configruation files changed:
    graylog2.conf -> graylog.conf
    graylog2-web-interface.conf -> graylog-web-interface.conf

  Node ID default URL changed (Migrate the file manually, if needed)
    /etc/graylog2-server-node-id -> /etc/graylog/server/node-id

0.92.3
------

- Update default Graylog2 version to `0.92.3`

0.92.0
------

- Update default Graylog2 version to `0.92.0`
- Update Elasticsearch `1.4`

0.91.3
------

- Update default Graylog2 version to `0.91.3`


0.91.1
------

- Update default Graylog2 version to `0.91.1`

0.91.0
------

- Update default Graylog2 version to `0.91.0`
- Update Elasticsearch to `1.3`

0.20.6
------

- Update default Graylog2 version to `0.20.6`
- Disable default secrets/passwords and display helpful error message if not set

0.20.3
------

- Initial release of graylog
- Use default Graylog2 version `0.20.3`
