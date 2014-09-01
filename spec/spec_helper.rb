require 'serverspec'
require 'net/ssh'

set :backend, :ssh
set :env, :LANG => 'C', :LC_MESSAGES => 'C'

if ENV['RAKE_ANSIBLE_USE_VAGRANT']
  begin
    require 'lib/vagrant'
    conn = Vagrant.new
  rescue LoadError
    fail 'lib/vagrant is not available'
  rescue
    fail 'failed to load lib/vagrant'
  end
else
  begin
    require 'lib/docker'
    conn = Docker.new
  rescue LoadError
    fail 'lib/docker is not available'
  rescue
    fail 'failed to load lib/docker'
  end
end

options = Net::SSH::Config.for(conn.ssh_host)
options[:user] = conn.ssh_user
options[:port] = conn.ssh_port
options[:keys] = conn.ssh_keys
options[:auth_methods] = Net::SSH::Config.default_auth_methods

set :host, conn.ssh_host
set :ssh_options, options
