# 2.0.1

Anja Siek (1):

* fix dependencies

# 2.0.0

Anja Siek (4):

* fix ansible\_local usage on check mode
* fix util calls
* change condition
* mv util tasks in main

# 1.1.1

Anja Siek (2):

* add privilege escalation to plugin install
* only try to stop service on update and not on install

Mark Kusch (1):

* Make utilization v2 compatible

# 1.1.0

Anja Siek (5):

* add option to install heka plugins via copy
* remove os-dependencies and allow to update heka version
* install heka to /opt/heka-;
* fix inital remove task and update smal beautifiing
* change shell to command

# 1.0.1

Mark Kusch (1):

* Update metadata to reflect support for EL 7

# 1.0.0

Anja Siek (1):

* fix centos support, update wrong sha256sum

Mark Kusch (8):

* Fix copy/paste in SysV template (thx to mdb)
* Re-run ansible-generator
* Add environment vars for testing the role with CentOS 7 via Vagrant
* Fix installation of heka configuration tasks
* Add better control for managing a hekad service
* Add --check support when running on ansible\_os\_family == RedHat
* Use complex args coding style
* Use true and false for boolean arguments

# 0.7.0

Mark Kusch (2):

* Make heka role checkmode ready
* Add heka dashboard configuration to test playbook

Anja Siek (1):

* change heka tasks handling

# 0.6.0

Mark Kusch (7):

* Fix role according to util role become framework issues
* Use util/\_{get,put} wrappers for downloading and uploading assets
* s/sudo/become/g
* Update heka installation to version 0.9.2
* Remove useless quotes
* This role now requires ansible 1.9
* Do not pin util role to a version which will not help

# 0.5.0

Mark Kusch (12):

* Update integration testing to work with Serverspec 2.N
* Add travis configuration
* Do not require playbooks to configure sudo: yes
* Introduce versioned variables paradigm
* Update heka to version 0.8.0
* Update heka to version 0.8.3
* Abstract supported platforms and allow to configure heka version
* Whether to allow automatic restart of heka service
* Configure explicit dependency to groover.util role
* Remove redundant tasks with groover.util and configure sudo: yes where required
* Manage dependency to util role
* Add documentation for dependencies

# 0.4.1

Mark Kusch (2):

* Update ubuntu-upstart-sshkey container to version 1.0.0
* Fix package installation if remote_ansible_data_path != /tmp

# 0.4.0

Mark Kusch (1):

* Move vars out of ansible_ variable scope

# 0.3.0

* Update heka to version 0.7.1.


<!-- vim: set nofen ts=4 sw=4 et: -->
