require 'rubygems'
require 'rpm-robot'

config = YAML.load_file 'profiles/default.yml'
repos = Dir['build/repos/*'].sort
repos += Dir['build/repos-ee/*'].sort
repos.delete 'build/repos/rpm-build-scripts'

repos.each do |r|
  cwd = Dir.pwd
  Dir.chdir r
  res = false
  RPMRobot::Log.msg "Building SRPM #{Dir.pwd.split('/').last} ".ljust(60), false
  begin
    res = RPMRobot::RPMBuild.build_srpm :copy_to => "#{cwd}/build/srpms/", :rhel5_compat=> config[:rhel5_compat]
  rescue RPMRobot::RPMBuild::NoSpecFound
    res = false
  end
  if res
    RPMRobot::Log.done
  else
    RPMRobot::Log.failed
  end

  Dir.chdir cwd
end

