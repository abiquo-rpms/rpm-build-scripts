require 'rubygems'
require 'fileutils'
require 'rpm-robot'
require 'term/ansicolor'
require 'restclient'

class String
  include Term::ANSIColor
end

FileUtils.mkdir_p 'build/srpms'
FileUtils.mkdir_p 'build/rpms'
FileUtils.mkdir_p 'build/repos'
FileUtils.mkdir_p 'build/repos-ee'

puts
puts "Clone/Update common repos".bold
puts
require 'clone-common-repos'

puts
puts "Clone/Update private repos".bold
puts
require 'clone-private-repos'

puts
puts "Create SRPMS".bold
puts
require 'create-srpms'

puts
puts "Build SRPMS".bold
puts
require 'build-rpms'
