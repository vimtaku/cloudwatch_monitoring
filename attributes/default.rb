default[:cw_mon][:user]              = "cw_monitoring"
default[:cw_mon][:group]             = "cw_monitoring"
default[:cw_mon][:home_dir]          = "/home/#{node[:cw_mon][:user]}"
default[:cw_mon][:version]           = "1.3.1"

default[:cw_mon][:use_iam_profile] = true
default[:cw_mon][:aws_users_databag] = "aws_users"
default[:cw_mon][:access_key_id]     = nil
default[:cw_mon][:secret_access_key] = nil

default[:cw_mon][:options] = %w{--disk-space-util --disk-path=/ --mem-util --load-average}

default[:cw_mon][:install_path] = "#{default[:cw_mon][:home_dir]}/cloud_watch_script-v#{node[:cw_mon][:version]}"
default[:cw_mon][:credential_path] ="#{default[:cw_mon][:home_dir]}/awscreds.conf"

default[:cw_mon][:mon_script_git_repository] = "https://github.com/FumihikoSHIROYAMA/cloud_watch_script.git"
default[:cw_mon][:mon_script_git_branch] = "master"

default[:cw_mon][:region] = "ap-northeast-1"
default[:cw_mon][:actions] = ""


default[:cw_mon][:global_alarm_name_prefix] = ""

[Chef::Recipe, Chef::Resource].each { |l| l.send :include, ::Credential }
[Chef::Recipe, Chef::Resource].each { |l| l.send :include, ::Util }

