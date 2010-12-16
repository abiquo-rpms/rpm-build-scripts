require 'rubygems'
require 'fileutils'
require 'rpm-robot'

repos = RPMRobot::Github.list_repos('abiquo-rpms')
repos.delete 'rpm-build-scripts'

repos.each do |repo|
  RPMRobot::Log.msg "Fetching repo #{repo}... ".ljust(60), false
  res = RPMRobot::Github.pull_repo('abiquo-rpms', repo, :dest_dir => 'build/repos')
  if res
    RPMRobot::Log.done
  else
    RPMRobot::Log.failed
  end
end

