cloudwatch_monitoring
==========
Install Amazon AWS Cloud Watch Monitoring Scripts and Create Alart
This script cloudwatch_monitoring is foked from https://github.com/alexism/cloudwatch_monitoring.

Requirements
==========

## Platform:

* Ubuntu/Debian
* RHEL

Attributes
==========
you should read and setting these param
 - node[:cw_mon][:default][...]
 - node[:cw_mon][:cpuusage][...]
 - node[:cw_mon][:diskusage][...]
 - node[:cw_mon][:loadaverage][...]
 - node[:cw_mon][:memusage][...]

Usage
=====
Put these recipe to your run_list.
 - recipe[cloudwatch_monitoring::cron]
 - recipe[cloudwatch_monitoring::diskusage]
 - recipe[cloudwatch_monitoring::cpuusage]
 - recipe[cloudwatch_monitoring::memusage]
 - recipe[cloudwatch_monitoring::loadaverage]

## AWS authentication

### with IAM role (recommended)

If your instance has an IAM role, then the script will use it to and you don't have to worry about setting keys.

Make sure that the role has permissions to perform the Amazon CloudWatch `PutMetricData` operation.

### with a key
(I'm sorry, I'm not testing this.)


License and Author
==================

Author:: vimtaku <vimtaku@gmail.com>

Copyright 2013, vimtaku

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
