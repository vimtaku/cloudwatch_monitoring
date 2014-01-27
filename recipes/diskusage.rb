
require 'json'

include_recipe "cloudwatch_monitoring::default"

create_credential

instance_id = get_instance_id
filesystem  = (`df | grep -e '/$' | awk '{print $1}'`).strip rescue ""
dimensions = []
dimensions << get_ret_hash("InstanceId", instance_id)
dimensions << get_ret_hash("Filesystem", filesystem)
dimensions << get_ret_hash("MountPath", '/')
alarm_name = get_alarm_name(node[:cw_mon][:diskusage][:alarm_name_prefix])

bash 'put_disk_usage_alarm_metric' do
  user node[:cw_mon][:user]
  group node[:cw_mon][:group]

  code <<-EOH
    aws cloudwatch put-metric-alarm \
      --region '#{node[:cw_mon]["region"]}' \
      --alarm-name='#{alarm_name}' \
      --alarm-description '#{node[:cw_mon][:diskusage][:metric_description]}' \
      --alarm-actions '#{node[:cw_mon]["actions"]}' \
      --namespace  '#{node[:cw_mon][:diskusage][:namespace]}'  \
      --metric-name  '#{node[:cw_mon][:diskusage][:metric_name]}'  \
      --statistic  '#{node[:cw_mon][:diskusage][:statistic]}'  \
      --period  '#{node[:cw_mon][:diskusage][:period]}'  \
      --unit '#{node[:cw_mon][:diskusage][:unit]}'  \
      --threshold  '#{node[:cw_mon][:diskusage][:threshold]}'  \
      --evaluation-periods  '#{node[:cw_mon][:diskusage][:evaluation_periods]}' \
      --comparison-operator '#{node[:cw_mon][:diskusage][:comparison_operator]}' \
      --dimensions '#{dimensions.to_json}'
  EOH
end

