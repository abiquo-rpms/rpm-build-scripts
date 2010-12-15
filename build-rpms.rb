require 'rubygems'
require 'rpm-robot'

config = YAML.load_file 'profiles/default.yml'

Dir['build/srpms/*.src.rpm'].each do |srpm|
  RPMRobot::Log.msg "Mocking srpm #{srpm}... ".ljust(60), false 
  res = RPMRobot::Mock.mock_srpm :mock_profile => config[:mock_profile], :srpm => srpm, :result_dir => 'build/rpms'
  if res
    RPMRobot::Log.done
  else
    RPMRobot::Log.failed
  end
end
