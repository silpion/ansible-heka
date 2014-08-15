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

### hekad inputs

* ``heka_inputs``: List of heka inputs (default: statsd)

### hekad outputs

* ``heka_outputs``: List of heka outputs (default: dashboard, debug log)

## Dependencies

None.

## Example Playbook

    - hosts: servers
      roles:
         - { role: heka }

## License

Apache Version 2.0

## Integration testing

This role provides integration tests using the Ruby RSpec/serverspec
framework.

Running integration tests requires a number of dependencies being
installed:

* [Ruby](https://www.ruby-lang.org)
* [rake](https://github.com/ruby/rake)
* [bundler](http://bundler.io)

Once bundler has been installed required Gems can be installed with
bundler.

    bundle install

### Docker

The integration test suite uses [Docker](https://docker.io) container
to provision this role and run integration tests.


The container used for running the integration tests is hosted at the
[Docker Index](https://registry.hub.docker.com/u/silpion/ubuntu-upstart-sshkey/)
and is open source at
[Github](https://github.com/silpion/docker-ubuntu-upstart-sshkey), is
based on the official Ubuntu Docker container with Upstart support
and integrates an *insecure-private-key* mechanism like Vagrant uses
it to allow passwordless SSH into the VM/container.


This allows ansible to provision the container flawlessly.

    # run the complete test suite with Docker
    rake docker

### Vagrant

Integration tests with [Vagrant](http://www.vagrantup.com/) is
implemented but serverspec configuration hardcodes to use the
Docker configuration.


Any help with a rake task based switch for the configuration
library to use is greatly appreciated.

    # run the complete test suite with Vagrant
    rake vagrant


<!-- vim: set nofen ts=4 sw=4 et: -->
