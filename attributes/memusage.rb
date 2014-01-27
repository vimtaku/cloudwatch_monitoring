
default[:cw_mon][:memusage]                       = {}
default[:cw_mon][:memusage][:alarm_name_prefix]   = "mem-usage"
default[:cw_mon][:memusage][:metric_description]  = "Memory usage alert"
default[:cw_mon][:memusage][:namespace]           = "System/Linux"
default[:cw_mon][:memusage][:metric_name]         = "MemoryUtilization"
default[:cw_mon][:memusage][:statistic]           = "Average"
default[:cw_mon][:memusage][:period]              = "300"
default[:cw_mon][:memusage][:unit]                = "Percent"
default[:cw_mon][:memusage][:threshold]           = "80"
default[:cw_mon][:memusage][:evaluation_periods]  = "1"
default[:cw_mon][:memusage][:comparison_operator] = "GreaterThanOrEqualToThreshold"

