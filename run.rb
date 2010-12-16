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
RestClient.post 'http://localhost:8081/receive', :payload => "Clone/Update common repos" rescue nil
puts
require 'clone-common-repos'

puts
puts "Clone/Update private repos".bold
RestClient.post 'http://localhost:8081/receive', :payload => "Clone/Update private repos" rescue nil
puts
require 'clone-private-repos'

puts
puts "Create SRPMS".bold
RestClient.post 'http://localhost:8081/receive', :payload => "Create SRPMS" rescue nil
puts
require 'create-srpms'

puts
puts "Build SRPMS".bold
puts
require 'build-rpms'
