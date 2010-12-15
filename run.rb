require 'rubygems'
require 'fileutils'
require 'rpm-robot'

FileUtils.mkdir_p 'build/srpms'
FileUtils.mkdir_p 'build/rpms'
FileUtils.mkdir_p 'build/repos'
FileUtils.mkdir_p 'build/repos-ee'

require 'clone-common-repos'
require 'clone-private-repos'
require 'build-srpms'
require 'build-rpms'
