require 'rubygems'
require 'orpium'
require 'lib/helpers'
require 'streamly'

PLATFORM_WARS_URL = 'http://hudson/1.7.0-SNAPSHOT/premium/'
config = YAML.load_file 'profiles/default.yml'
cwd = Dir.pwd

config[:platform_packages].each do |pkg|
  source_name = pkg.gsub('abiquo-','')
  # HACK
  if source_name == 'v2v'
    source_name = 'bpm-async'
  end
  Orpium::Log.msg "Updating #{source_name} platform sources... ".ljust(60), false 
  begin
    pkg_dir = File.join('build/repos-ee', pkg)
    if File.directory?(pkg_dir)
      Dir.chdir pkg_dir 

      # this will raise an exception if we can't access the resource
      RestClient.get "#{PLATFORM_WARS_URL}/#{source_name}.war"

      File.open(source_name + '.war', 'w') do |f|
        Streamly.get "#{PLATFORM_WARS_URL}/#{source_name}.war" do |chunk|
          f.write chunk
        end
      end
      Orpium::Log.done
    else
      Orpium::Log.failed
    end
  rescue Exception => e
    Orpium::Log.failed
    $stderr.puts e.message
  ensure
    Dir.chdir cwd
  end
end
