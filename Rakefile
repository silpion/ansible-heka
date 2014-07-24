require 'rake'
require 'rspec/core/rake_task'

desc "serverspec"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end


desc "Test ansible playbook syntax"
task :lint do
  sh %{ansible-playbook -i tests/hosts --syntax-check tests/vagrant.yml}
end


desc "Cleanup test environment"
task :clean do
  sh %{vagrant destroy -f}
end


desc "vagrant up --no-provision"
task :vagrant_up do
  sh %{vagrant up --no-provision}
end


desc "vagrant provision"
task :vagrant_provision => [:lint, :vagrant_up] do
  sh %{vagrant provision}
end


desc "Run all tests with Vagrant"
task :vagrant => [
  :lint,
  :vagrant_up,
  :vagrant_provision,
  :spec,
  :clean
]


desc "Run all tests with Packer"
task :packer => [
  :lint,
  :packer_build,
  :spec,
  :clean
]


task :default => :lint
