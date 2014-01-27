
module Util
  def get_instance_id
    (`curl -s http://169.254.169.254/latest/meta-data/instance-id`).strip rescue ""
  end
  def get_hostname
    (`hostname`).strip rescue ""
  end
  def get_global_alarm_name_prefix
    global_alarm_name_prefix = node[:cw_mon][:global_alarm_name_prefix]
    return global_alarm_name_prefix + "-" if not global_alarm_name_prefix.empty?
  end
  def get_ret_hash(name, value)
    {"Name"=>name, "Value"=> value}
  end

  def get_alarm_name(alarm_name_prefix="")
    instance_id = get_instance_id
    hostname = get_hostname
    global_alarm_name_prefix = get_global_alarm_name_prefix
    alarm_name = sprintf("%s%s-%s-%s",
      global_alarm_name_prefix, alarm_name_prefix, hostname, instance_id
    )
    alarm_name
  end
end
