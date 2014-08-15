# TODO load docker/vagrant depending on the testing backend in use

require 'rake'
require 'rspec/core/rake_task'

# we use data from the docker configuration in rake configuration
require './spec/lib/docker'
#require './spec/lib/vagrant'
d = Docker.new
#v = Vagrant.new


desc "Run integration tests with serverspec"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end


desc "Test ansible playbook syntax"
task :lint do
  sh %{ansible-playbook --inventory-file tests/hosts --syntax-check tests/playbook.yml}
end
task :default => :lint


desc "Clean test environment"
task :clean => [:docker_stop, :docker_rm] do
  d.ansible_hosts_del
end



# Docker
desc "docker pull"
task :docker_pull do
  d.docker_pull
end

desc "docker run"
task :docker_run => [:docker_pull] do
  d.docker_run
  d.ssh_available?
end

desc "docker 'provision'"
task :docker_provision => [:docker_run] do
  d.ansible_hosts_add
  sh %{ansible-playbook --inventory-file #{d.ansible_hosts_file} --limit #{d.env_name} tests/playbook.yml}
  d.ansible_hosts_del
end

desc "docker stop"
task :docker_stop do
  d.docker_stop
end

desc "docker rm --force"
task :docker_rm => [:docker_stop] do
  d.docker_rm
end


desc "Run test suite with Docker"
task :docker => [
  :lint,
  :docker_pull,
  :docker_run,
  :docker_provision,
  :spec,
  :docker_stop,
  :docker_rm
]



# Vagrant
desc "vagrant up --no-provision"
task :vagrant_up do
  v.vagrant_up
end

desc "vagrant provision"
task :vagrant_provision do
  v.vagrant_provision
end

desc "vagrant halt"
task :vagrant_halt do
  v.vagrant_halt
end

desc "vagrant destroy --force"
task :vagrant_destroy do
  v.vagrant_destroy
end


desc "Run test suite with Vagrant"
task :vagrant => [
  :lint,
  :vagrant_up,
  :vagrant_provision,
  :spec,
  :vagrant_halt,
  :vagrant_destroy
]
