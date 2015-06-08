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
