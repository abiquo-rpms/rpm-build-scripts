require 'rubygems'
require 'orpium'

config = YAML.load_file 'profiles/default.yml'

Dir['build/srpms/*.src.rpm'].each do |srpm|
  pkg = srpm.split('/').last
  Orpium::Log.msg "Mocking srpm #{pkg}... ".ljust(60), false 
  res = Orpium::Mock.mock_srpm :mock_profile => config[:mock_profile], :srpm => srpm, :result_dir => 'build/rpms'
  if res
    Orpium::Log.done
  else
    Orpium::Log.failed
  end
end
