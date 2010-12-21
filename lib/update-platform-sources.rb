require 'rubygems'
require 'orpium'
require 'lib/helpers'

config = YAML.load_file 'profiles/default.yml'
cwd = Dir.pwd

config[:platform_packages].each do |pkg|
  source_name = pkg.gsub('abiquo-','')
  Orpium::Log.msg "Updating #{source_name} platform sources... ".ljust(60), false 
  begin
    pkg_dir = File.join('build/repos-ee', pkg)
    if File.directory?(pkg_dir)
      Dir.chdir pkg_dir 
      repackage_war "http://hudson/#{config[:hudson_dir]}/premium/#{source_name}.war", config[:abiquo_version]
      Orpium::Log.done
    else
      Orpium::Log.failed
    end
  rescue Exception => e
    Orpium::Log.failed
    $stderr.puts e.msg
  ensure
    Dir.chdir cwd
  end
end
