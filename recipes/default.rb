#
# Cookbook Name:: mysql-component
# Recipe:: default
#
# Copyright 2013, Cometera
#
# All rights reserved - Do Not Redistribute
#

case node["platform_family"] 
  when "debian"
    execute "update packages cache" do
      command "apt-get update"
  end
end

include_recipe "mysql::server"

case node["platform_family"]
  when "rhel"
    service "iptables" do
      action :stop
    end
  when "debian"
    service "ufw" do
      action :stop
    end
  end

