
default[:cw_mon][:cpuusage]                       = {}
default[:cw_mon][:cpuusage][:alarm_name_prefix]   = "cpu-usage"
default[:cw_mon][:cpuusage][:metric_description]  = "CPU utlization overload"
default[:cw_mon][:cpuusage][:namespace]           = "AWS/EC2"
default[:cw_mon][:cpuusage][:metric_name]         = "CPUUtilization"
default[:cw_mon][:cpuusage][:statistic]           = "Average"
default[:cw_mon][:cpuusage][:period]              = "300"
default[:cw_mon][:cpuusage][:unit]                = "Percent"
default[:cw_mon][:cpuusage][:threshold]           = "80"
default[:cw_mon][:cpuusage][:evaluation_periods]  = "1"
default[:cw_mon][:cpuusage][:comparison_operator] = "GreaterThanOrEqualToThreshold"

