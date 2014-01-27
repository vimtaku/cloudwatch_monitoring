
module Credential
  def create_credential
    credential_path = node[:cw_mon][:credential_path]
    if (credential_path.nil? || credential_path.to_s.length <= 0)
      raise Chef::Exceptions::ConfigurationError, "credential not created."
    end

    if node[:cw_mon][:use_iam_profile] && iam_role = IAM::role
      log "IAM role available: #{iam_role}"
      ## no need to create credential file
      return
    end


    vars = {}
    begin
      user_creds = Chef::EncryptedDataBagItem.load(node[:cw_mon][:aws_users_databag], node[:cw_mon][:user])
      vars[:access_key_id] = user_creds['access_key_id']
      vars[:secret_access_key] = user_creds['secret_access_key']
      log "AWS key for user #{ node[:cw_mon][:user]} found in databag #{node[:cw_mon][:aws_users_databag]}"
    rescue
      vars = node[:cw_mon]
    end

    template credential_path do
      owner node[:cw_mon][:user]
      group node[:cw_mon][:group]
      mode 0644
      source 'awscreds.conf.erb'
      variables :cw_mon => vars

      not_if { File.exists? credential_path }
    end

    return true
  end
end

