require 'rubygems'
require 'rpm-robot'

config = YAML.load_file 'profiles/default.yml'
repos = Dir['build/repos/*']
repos.delete 'build/repos/rpm-build-scripts'

repos.each do |r|
  cwd = Dir.pwd
  Dir.chdir r
  RPMRobot::RPMBuild.build_srpm :copy_to => "#{cwd}/build/srpms/", :rhel5_compat=> config[:rhel5_compat]
  Dir.chdir cwd
end
