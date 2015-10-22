#
# Cookbook Name:: mysql_component
# Recipe:: default
#
# Copyright 2014, Qubell
#
# All rights reserved - Do Not Redistribute
#

node.set['mysql']['tunable']['max_allowed_packet'] = '50M'

case node[:platform] 
  when "ubuntu"
    execute "update packages cache" do
      command "apt-get update"
    end
  end

include_recipe "mysql::server"

case node[:platform_family]
  when "rhel"
    service "iptables" do
      action :stop
    end

    directory '/etc/mysql' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end

    file '/etc/mysql/my.cnf' do
      owner 'root'
      group 'root'
      mode 0644
      content lazy { ::File.open("/etc/my.cnf").read }
      notifies :restart, "service[mysql]"
    end

  when "debian"
    service "ufw" do
      action :stop
    end
  end
