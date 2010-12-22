require 'rubygems'
require 'uri'
require 'streamly'
require 'zlib'
require 'archive/zip'
require 'archive/tar/minitar'
require 'fileutils'

include Archive::Tar


#
# May raise a exception
# 
def repackage_war(war_url, version, dest_dir = nil)
  uri = URI.parse war_url
  fpath = uri.path
  if dest_dir.nil?
    dest_dir = Dir.pwd
  end
  war_file = File.join(dest_dir, File.basename(fpath))
  source_dir_name = "abiquo-" + File.basename(fpath, '.war') + "-#{version}"
  tgz_name = "#{source_dir_name}.tar.gz"
  source_dir = File.join(dest_dir, source_dir_name)

  # Create war-name-version directory
  Dir.mkdir source_dir

  # Download war
  File.open(war_file, 'w') do |f| 
    Streamly.get war_url do |chunk|
      f.write chunk
    end
  end

  # Extract war
  Archive::Zip.extract(war_file, source_dir)

  # Create tarball
  cwd = Dir.pwd
  Dir.chdir dest_dir
  tgz = Zlib::GzipWriter.new(File.open(tgz_name, 'wb'))
  Minitar.pack(source_dir_name, tgz)
  Dir.chdir cwd
  
  # Cleanup
  FileUtils.rm_f war_file
  FileUtils.rm_rf source_dir
end

