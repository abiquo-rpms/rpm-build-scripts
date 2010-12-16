require 'rubygems'
require 'rpm-robot'

config = YAML.load_file 'profiles/default.yml'
config[:abiquo_ee_repos].each do |r|
  RPMRobot::Log.msg "Fetching repo #{r}... ".ljust(60),false
  res = RPMRobot::Git.pull_repo('ssh://rpm-git.abiquo.com/git/', r, :dest_dir => 'build/repos-ee')
  if res
    RPMRobot::Log.done
  else
    RPMRobot::Log.failed
  end
end
