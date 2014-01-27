
default[:cw_mon][:diskusage]                       = {}
default[:cw_mon][:diskusage][:alarm_name_prefix]   = "disk-usage"
default[:cw_mon][:diskusage][:metric_description]  = "Disk usage alert"
default[:cw_mon][:diskusage][:namespace]           = "System/Linux"
default[:cw_mon][:diskusage][:metric_name]         = "DiskSpaceUtilization"
default[:cw_mon][:diskusage][:statistic]           = "Average"
default[:cw_mon][:diskusage][:period]              = "300"
default[:cw_mon][:diskusage][:unit]                = "Percent"
default[:cw_mon][:diskusage][:threshold]           = "80"
default[:cw_mon][:diskusage][:evaluation_periods]  = "1"
default[:cw_mon][:diskusage][:comparison_operator] = "GreaterThanOrEqualToThreshold"

