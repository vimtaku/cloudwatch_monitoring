
require 'json'

include_recipe "cloudwatch_monitoring::default"

create_credential

alarm_name_part = sprintf("%s-%s", get_hostname, get_instance_id)
pick_regix = sprintf('\A%s.*%s', node[:cw_mon][:global_alarm_name_prefix], alarm_name_part)

cloudwatch_json_path = "#{Chef::Config[:file_cache_path]}/cloudwatch_alart.json"
`aws cloudwatch describe-alarms --region='#{node[:cw_mon]["region"]}' > #{cloudwatch_json_path}`
alarm_names = nil
File.open(cloudwatch_json_path) do |io|
  json = JSON.load(io)
  alarm_names = json["MetricAlarms"].select do |alarm|
    alarm["AlarmName"] =~ /#{pick_regix}/
  end.map {|alarm|
    alarm["AlarmName"]
  }
end

return if alarm_names.empty?

bash 'delete_all_alarm' do
  user node[:cw_mon][:user]
  group node[:cw_mon][:group]

  code <<-EOH
   aws cloudwatch delete-alarms \
      --region '#{node[:cw_mon]["region"]}' \
      --alarm-names #{alarm_names.join(' ')}
  EOH
end

file cloudwatch_json_path do
  action :delete
end

