require 'spec_helper'

describe package('heka') do
  it { should be_installed }
end

%w{
  /etc/hekad.d
  /var/cache/hekad
  /var/cache/hekad/dashboard
}.each do |f|
  describe file(f) do
    it { should be_directory }
  end
end

%w{
  /etc/hekad.d/hekad.toml
  /etc/hekad.d/dashboard.toml
}.each do |f|
  describe file(f) do
    it { should be_file }
  end
end

describe service('hekad') do
  it { should be_running }
  it { should be_enabled }
end

describe port(4352) do
  it { should be_listening }
end
