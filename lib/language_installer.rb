# language_installer.rb

require 'rbconfig'

module Scriptlandia
  class LanguageInstaller
    include Config

    def install
      my_bindir = CONFIG['bindir']

      unless File.writable? my_bindir
        my_bindir = [ENV['HOME'], '.gem', 'ruby', CONFIG["MAJOR"]+"."+CONFIG["MINOR"], 'bin'].join(File::SEPARATOR)
      end

      my_gems_path = [CONFIG['libdir'], 'ruby', 'gems'].join(File::SEPARATOR)

      unless File.writable? my_gems_path
        my_gems_path = [ENV['HOME'], '.gem', 'ruby'].join(File::SEPARATOR)
      end

      buildr = File.join my_bindir, 'buildr'

      buildr << '.bat' if CONFIG['host_os'] =~ /mswin/i

      old_ext = ENV['EXT']

      ENV['EXT'] = ARGV[1]

#      buildfile = File.join(my_gems_path,
#                            CONFIG["MAJOR"]+"."+CONFIG["MINOR"], 
#                            'gems', name + '-' + version, 'lib', 'buildfile') 

      buildfile = File.join(File.dirname(__FILE__), 'buildfile')

      ARGV.shift
      ARGV.shift

      ARGV.insert 0, buildfile
      ARGV.insert 0, '-f'

      require 'rubygems'
      require 'buildr'
      Buildr.application.run

      ENV['EXT'] = old_ext
    end
  end
end