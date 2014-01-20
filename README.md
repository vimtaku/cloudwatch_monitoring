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

* `node[:cw_mon][:user]` - the user to run the script as. Created if necessary. Defaults to `cw_monitoring`.
* `node[:cw_mon][:group]` - the group the files should belong to. Defaults to `cw_monitoring`.
* `node[:cw_mon][:home_dir]` - the directory to install the scripts in. Defaults to  `/home/#{node[:cw_mon][:user]}`
* `node[:cw_mon][:version]`  - the version of the scripts to install. Defaults to `1.1.0`
* `node[:cw_mon][:release_url]` - the URL to download from. Defaults to `http://ec2-downloads.s3.amazonaws.com/cloudwatch-samples/CloudWatchMonitoringScripts-v1.1.0.zip`
* `node[:cw_mon][:aws_users_databag]` - the encrypted databag containing the AWS key. See section below for details. Defaults to `aws_users`
* `node[:cw_mon][:access_key_id]`     - the AWS access key id the script should authenticate with. See section below for details.
* `node[:cw_mon][:secret_access_key]` - the AWS access key the script should authenticate with. See section below for details.
* `node[:cw_mon][:options]` - the list of options to pass to the script. By default, all options are included:
            `--disk-space-util  --disk-path=/ --disk-space-used --disk-space-avail`
             `--swap-util --swap-used --mem-util --mem-used --mem-avail`

And you should read and setting these param
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
