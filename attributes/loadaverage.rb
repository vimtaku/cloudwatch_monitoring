
default[:cw_mon][:loadaverage]                       = {}
default[:cw_mon][:loadaverage][:alarm_name_prefix]   = "load-average"
default[:cw_mon][:loadaverage][:metric_description]  = "Load average alert"
default[:cw_mon][:loadaverage][:namespace]           = "System/Linux"
default[:cw_mon][:loadaverage][:metric_name]         = "LoadAverage"
default[:cw_mon][:loadaverage][:statistic]           = "Average"
default[:cw_mon][:loadaverage][:period]              = "300"
default[:cw_mon][:loadaverage][:unit]                = "Count"
default[:cw_mon][:loadaverage][:threshold]           = "1.2"
default[:cw_mon][:loadaverage][:evaluation_periods]  = "1"
default[:cw_mon][:loadaverage][:comparison_operator] = "GreaterThanOrEqualToThreshold"

