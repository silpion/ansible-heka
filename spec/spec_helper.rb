# TODO switch docker vs vagrant

require 'serverspec'
require 'net/ssh'
require 'lib/docker'
require 'lib/vagrant'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS
include SpecInfra::Helper::Ssh

RSpec.configure do |c|
  c.before :all do
    d = Docker.new
    c.host = d.ssh_host
    opts = Net::SSH::Config.for(c.host)
    opts[:port] = d.ssh_port
    opts[:keys] = d.ssh_keys
    opts[:auth_methods] = Net::SSH::Config.default_auth_methods
    c.ssh = Net::SSH.start(d.ssh_host, d.ssh_user, opts)
  end
end
