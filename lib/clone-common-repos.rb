require 'rubygems'
require 'fileutils'
require 'orpium'

repos = Orpium::Github.list_repos('abiquo-rpms')
repos.delete 'rpm-build-scripts'

repos.each do |repo|
  Orpium::Log.msg "Fetching repo #{repo}... ".ljust(60), false
  res = Orpium::Github.pull_repo('abiquo-rpms', repo, :dest_dir => 'build/repos')
  if res
    Orpium::Log.done
  else
    Orpium::Log.failed
  end
end

