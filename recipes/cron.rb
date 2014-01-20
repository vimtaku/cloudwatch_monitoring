
include_recipe "cloudwatch_monitoring::default"
install_path = node[:cw_mon][:install_path]

git install_path do
  repository node[:cw_mon][:mon_script_git_repository]
  reference node[:cw_mon][:mon_script_git_branch]
  user node[:cw_mon][:user]
  group node[:cw_mon][:group]
  action :checkout

  not_if { ::File.directory? install_path }
end

bash 'extract_aws-scripts-mon' do
  user node[:cw_mon][:user]
  group node[:cw_mon][:group]
  code <<-EOH
    chown -R #{node[:cw_mon][:user]}:#{node[:cw_mon][:group]} #{install_path}
  EOH
  not_if { File.directory? install_path }
end


options = ['--from-cron'] + node[:cw_mon][:options]
if create_credential
  options << "--aws-credential-file #{credential_path}"
end

cron_d 'cloudwatch_monitoring' do
  minute "*/5"
  user node[:cw_mon][:user]
  command %Q{#{node[:cw_mon][:install_path]}/mon-put-instance-data.pl #{(options).join(' ')} || logger -t aws-scripts-mon "status=failed exit_code=$?"}
end
