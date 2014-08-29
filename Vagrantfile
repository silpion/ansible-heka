# vim: set ft=ruby ts=2 sw=2 et:
# -*- mode: ruby -*-


VAGRANT_API_VERSION = '2'
Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.box = 'ubuntu/trusty64'

  config.vm.define :ansiblehekatest do |d|

    d.vm.hostname = 'ansiblehekatest'
    d.vm.synced_folder '.', '/vagrant', id: 'vagrant-root', disabled: true

    d.vm.provision :ansible do |ansible|
      ansible.playbook = 'tests/playbook.yml'
      ansible.tags = ENV['ANSIBLE_TAGS']
      ansible.groups = {
        'vagrant' => ['ansiblehekatest']
      }
      ansible.limit = 'vagrant'

      ::File.directory?('.vagrant/provisioners/ansible/inventory/') do
        ansible.inventory_path = '.vagrant/provisioners/ansible/inventory/'
      end

    end

    d.vm.provider :virtualbox do |v|
      v.customize 'pre-boot', ['modifyvm', :id, '--nictype1', 'virtio']
      v.customize [ 'modifyvm', :id, '--name', 'ansiblehekatest', '--memory', '512', '--cpus', '1' ]
    end

  end
end
