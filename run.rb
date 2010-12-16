require 'rubygems'
require 'fileutils'
require 'rpm-robot'
require 'term/ansicolor'
require 'restclient'

class String
  include Term::ANSIColor
end

config = YAML.load_file 'profiles/default.yml'

FileUtils.mkdir_p 'build/srpms'
FileUtils.mkdir_p 'build/rpms'
FileUtils.mkdir_p 'build/repos'
FileUtils.mkdir_p 'build/repos-ee'

if config[:run_steps][:clone_common_repos]
  puts
  puts "Clone/Update common repos".bold
  puts
  require 'clone-common-repos'
end

if config[:run_steps][:clone_private_repos]
  puts
  puts "Clone/Update private repos".bold
  puts
  require 'clone-private-repos'
end

if config[:run_steps][:update_plaform_sources]
  puts
  puts "Updating platform sources".bold
  puts
  require 'update-platform-sources'
end

if config[:run_steps][:create_srpms]
  puts
  puts "Create SRPMS".bold
  puts
  require 'create-srpms'
end

if config[:run_steps][:build_rpms]
  puts
  puts "Build RPMS".bold
  puts
  require 'build-rpms'
end
