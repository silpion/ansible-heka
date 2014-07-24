require 'spec_helper'

describe package('heka') do
  it { should be_installed }
end

describe file('/etc/hekad.toml') do
  it { should be_file }
end

describe service('hekad') do
  it { should be_running }
  it { should be_enabled }
end

describe port(4352) do
  it { should be_listening }
end
