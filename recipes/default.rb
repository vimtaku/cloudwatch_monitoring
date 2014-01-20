#
# Cookbook Name::       cloudwatch_monitoring
# Description::         Base configuration for cloudwatch_monitoring
# Recipe::              default
# Author::              Alexis Midon
#
# See https://github.com/alexism/cloudwatch_monitoring
#
# Copyright 2013, Alexis Midon
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'cron'

install_path = node[:cw_mon][:install_path]

case node[:platform_family]
  when 'rhel'
    %w{unzip perl-CPAN}.each do |p|
      package p
    end

    %w{Test::More Bundle::LWP}.each do |m|
      execute "install Perl module #{m}" do
        command "perl -MCPAN -e 'install #{m}' < /dev/null"
        not_if { ::File.directory?(install_path) }
      end
    end

  when 'debian'

    %w{unzip libwww-perl libcrypt-ssleay-perl}.each do |p|
      package p do
        action :install
      end
    end

  else
    log "#{node[:platform_family]} is not supported" do
      level :warn
    end
end

group node[:cw_mon][:group] do
  action :create
end

user node[:cw_mon][:user] do
  home node[:cw_mon][:home_dir]
  group node[:cw_mon][:group]
  action :create
end

directory node[:cw_mon][:home_dir] do
  group node[:cw_mon][:group]
  owner node[:cw_mon][:user]
end
