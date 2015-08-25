# heka

Install heka stream processing software.

## Requirements

None.

## Role Variables

* ``heka_hekad_etc_dir``: Where to store hekad configuration files (default: ``/etc/hekad.d``)
* ``heka_hekad_max_message_loops``: hekad configuration max message loops (default: ``4``)
* ``heka_hekad_max_process_inject``: hekad configuration max process inject (default: ``1``)
* ``heka_hekad_max_process_duration``: hekad configuration max process duration (default: ``100000``)
* ``heka_hekad_max_timer_inject``: hekad configuration max timer inject (default: ``10``)
* ``heka_hekad_maxprocs``: hekad configuration maxprocs (default: ``2``)
* ``heka_hekad_poolsize``: hekad configuration poolsize (default: ``100``)
* ``heka_hekad_plugin_chansize``: hekad configuration plugin chansize (default: ``50``)
* ``heka_hekad_sample_denominator``: hekad configuration sample denominator (default: ``1000``)
* ``heka_hekad_base_dir``: hekad configuration base directory (default: ``/var/cached/hekad``)
* ``heka_hekad_share_dir``: hekad configuration share directory (default: ``/usr/share/heka``)
* ``heka_hekad_cpuprof``: hekad configuration enable CPU profiling (default: ``false``)
* ``heka_hekad_memprof``: hekad configuration enable MEM profiling (default: ``false``)
* ``heka_hekad_pidfile``: hekad configuration PID file (default: ``/var/run/hekad.pid``)

### hekad tasks

* ``heka_tasks``: List of heka tasks (default: [])

#### Example:
```
heka_tasks:
  - file: "logging"
    section: "NginxAccessLogs"
    options:
      - option: "type"
        value: "\\\"LogstreamerInput\\\""
      - option: "splitter"
        value: "\\\"TokenSplitter\\\""
      - option: "decoder"
        value: "\\\"NginxAccessDecoder\\\""
      - option: "log_directory"
        value: "\\\"/srv/sites/magento/log/nginx\\\""
      - option: "file_match"
        value: "\'access\\.log\'"
  - file: "logging"
    section: "NginxAccessDecoder"
    options:
      - option: "type"
        value: "\\\"SandboxDecoder\\\""
      - option: "script_type"
        value: "\\\"lua\\\""
      - option: "filename"
        value: "\\\"lua_decoders/nginx_access.lua\\\""
  - file: "logging"
    section: "NginxAccessDecoder.config"
    options:
      - option: "log_format"
        value: "\'$remote_addr - $remote_user [$time_local] \\\"$request\\\" $status $body_bytes_sent \\\"$http_referer\\\" \\\"$http_user_agent\\\"\'"
      - option: "type"
        value: "\\\"nginx.access\\\""
```


## Dependencies

This role depends on ``groover.util`` role. This is configured
for ``ansible-galaxy install`` in **requirements.yml**.

**NOTE**: Requirements are installed as virtual user ``silpion``
(``silpion.util``).

Be sure to install required roles with

    ansible-galaxy install --role-file requirements.yml

* [groover.util](https://github.com/silpion/ansible-util)

## Example Playbook

    - hosts: servers
      roles:
         - { role: ansible-heka }

## License

Apache Version 2.0

## Integration testing

This role provides integration tests using the Ruby RSpec/serverspec framework
with a few drawbacks at the time of writing this documentation.

- Currently supports ansible_os_family == 'Debian' only.

Running integration tests requires a number of dependencies being
installed. As this role uses Ruby RSpec there is the need to have
Ruby with rake and bundler available.

    # install role specific dependencies with bundler
    bundle install

<!-- -->

    # run the complete test suite with Docker
    rake suite

<!-- -->

    # run the complete test suite with Vagrant
    RAKE_ANSIBLE_USE_VAGRANT=1 rake suite


## Author information

Mark Kusch @mark.kusch silpion.de


<!-- vim: set nofen ts=4 sw=4 et: -->
