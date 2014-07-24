require 'serverspec'
require 'pathname'
require 'net/ssh'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS
include SpecInfra::Helper::Ssh

RSpec.configure do |c|
  c.before :all do
    host = nil
    user = nil
    keys = nil
    port = nil
    config = `vagrant ssh-config`
    if config != ''
      config.each_line do |line|
        if match = /Hostname (.*)/.match(line)
          host = match[1]
        elsif match = /User (.*)/.match(line)
          user = match[1]
        elsif match = /IdentityFile (.*)/.match(line)
          keys = [match[1].gsub(/"/, '')]
        elsif match = /Port (.*)/.match(line)
          port = match[1]
        end
      end
      c.host = host
      options = Net::SSH::Config.for(c.host)
      options[:keys] = keys
      options[:port] = port
      c.ssh = Net::SSH.start(host, user, options)
    end
  end
end
