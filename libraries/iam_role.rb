

module IAM
  def self.role
    require 'open-uri'
    instance_role = open("http://169.254.169.254/latest/meta-data/iam/security-credentials/").readlines.first rescue nil
    instance_role
  end
end