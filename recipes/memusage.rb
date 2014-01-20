
require 'json'

include_recipe "cloudwatch_monitoring::default"

def ret_hash(name, value)
  {"Name"=>name, "Value"=> value}
end

create_credential

instance_id = `curl -s http://169.254.169.254/latest/meta-data/instance-id`
dimensions = []
dimensions << ret_hash("InstanceId", instance_id)
hostname = (`hostname`).strip rescue ""
alarm_name = sprintf("%s-%s-%s",
  node[:cw_mon][:memusage][:alarm_name_prefix], hostname, instance_id
)

bash 'put_mem_usage_alarm_metric' do
  user node[:cw_mon][:user]
  group node[:cw_mon][:group]

  code <<-EOH
    aws cloudwatch put-metric-alarm \
      --region '#{node[:cw_mon]["region"]}' \
      --alarm-name='#{alarm_name}' \
      --alarm-description '#{node[:cw_mon][:memusage][:metric_description]}' \
      --alarm-actions '#{node[:cw_mon]["actions"]}' \
      --namespace  '#{node[:cw_mon][:memusage][:namespace]}'  \
      --metric-name  '#{node[:cw_mon][:memusage][:metric_name]}'  \
      --statistic  '#{node[:cw_mon][:memusage][:statistic]}'  \
      --period  '#{node[:cw_mon][:memusage][:period]}'  \
      --unit '#{node[:cw_mon][:memusage][:unit]}'  \
      --threshold  '#{node[:cw_mon][:memusage][:threshold]}'  \
      --evaluation-periods  '#{node[:cw_mon][:memusage][:evaluation_periods]}' \
      --comparison-operator '#{node[:cw_mon][:memusage][:comparison_operator]}' \
      --dimensions '#{dimensions.to_json}'
  EOH
end

