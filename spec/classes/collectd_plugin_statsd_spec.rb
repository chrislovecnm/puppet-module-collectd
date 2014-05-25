require 'spec_helper'

describe 'collectd::plugin::statsd', :type => :class do

  let :facts do
   {
     :osfamily => 'RedHat',
     :collectd_version => '5.4',
   }
  end

  context ':ensure => present, default host and port' do
    it 'Will create /etc/collectd.d/statsd.conf' do
      should contain_file('statsd.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-statsd.conf',
        :content =>  "# Generated by Puppet\nLoadPlugin statsd\n\n<Plugin statsd>\n  Host \"::\"\n  Port 8125\n</Plugin>\n"
      })
    end
  end

end

