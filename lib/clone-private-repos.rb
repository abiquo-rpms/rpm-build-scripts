require 'rubygems'
require 'orpium'

config = YAML.load_file 'profiles/default.yml'
config[:abiquo_ee_repos].each do |r|
  Orpium::Log.msg "Fetching repo #{r}... ".ljust(60),false
  res = Orpium::Git.pull_repo('ssh://rpm-git.abiquo.com/git/', r, :dest_dir => 'build/repos-ee')
  Orpium::Log.done
end
