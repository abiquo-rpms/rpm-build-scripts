require 'rubygems'
require 'orpium'

config = YAML.load_file 'profiles/default.yml'

config[:platform_packages].each do |pkg|
  source_name = pkg.gsub('abiquo-','')
  Orpium::Log.msg "Updating #{source_name} platform sources... ".ljust(60), false 
  cwd = Dir.pwd
  pkg_dir = File.join('build/repos-ee', pkg)
  if File.directory?(pkg_dir)
    Dir.chdir pkg_dir 
    `rake update_war[#{source_name},#{config[:abiquo_version]},#{config[:hudson_dir]}]`
    Dir.chdir cwd
    if $? == 0
      Orpium::Log.done
    else
      Orpium::Log.failed
    end
  else
    Orpium::Log.failed
  end
end
