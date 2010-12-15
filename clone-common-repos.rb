require 'rubygems'
require 'fileutils'
require 'rpm-robot'

repos = RPMRobot::Github.list_repos('abiquo-rpms')
repos.delete 'rpm-build-scripts'

RPMRobot::Github.clone_update_repos('abiquo-rpms', repos, :dest_dir => 'build/repos')

