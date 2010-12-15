require 'rubygems'
require 'rpm-robot'

config = YAML.load_file 'profiles/default.yml'

Dir['build/srpms/*.src.rpm'].each do |srpm|
  RPMRobot::Mock.mock_srpm :mock_profile => config[:mock_profile], :srpm => srpm, :result_dir => 'build/rpms'
end
