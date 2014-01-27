
require 'json'

include_recipe "cloudwatch_monitoring::default"

create_credential

instance_id = get_instance_id
dimensions = []
dimensions << get_ret_hash("InstanceId", instance_id)
alarm_name = get_alarm_name(node[:cw_mon][:cpuusage][:alarm_name_prefix])

bash 'put_cpu_usage_alarm_metric' do
  user node[:cw_mon][:user]
  group node[:cw_mon][:group]

  code <<-EOH
    aws cloudwatch put-metric-alarm \
      --region '#{node[:cw_mon]["region"]}' \
      --alarm-name='#{alarm_name}' \
      --alarm-description '#{node[:cw_mon][:cpuusage][:metric_description]}' \
      --alarm-actions '#{node[:cw_mon]["actions"]}' \
      --namespace  '#{node[:cw_mon][:cpuusage][:namespace]}'  \
      --metric-name  '#{node[:cw_mon][:cpuusage][:metric_name]}'  \
      --statistic  '#{node[:cw_mon][:cpuusage][:statistic]}'  \
      --period  '#{node[:cw_mon][:cpuusage][:period]}'  \
      --unit '#{node[:cw_mon][:cpuusage][:unit]}'  \
      --threshold  '#{node[:cw_mon][:cpuusage][:threshold]}'  \
      --evaluation-periods  '#{node[:cw_mon][:cpuusage][:evaluation_periods]}' \
      --comparison-operator '#{node[:cw_mon][:cpuusage][:comparison_operator]}' \
      --dimensions '#{dimensions.to_json}'
  EOH
end

