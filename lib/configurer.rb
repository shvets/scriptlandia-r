# installer.rb

require 'rubygems'
require 'rbconfig'
require 'find'
require 'ftools'
require 'rake/gempackagetask'

module Scriptlandia
  class Configurer
    include Config

    def configure
      ARGV.shift

      prepare()

      install_settings(File.dirname(__FILE__) + "/../" + "lib/settings.yaml", $my_libdir + "/../settings.yaml")

      settings = YAML::load File.open($my_libdir + "/../settings.yaml")

      #install_file("bin/sl.bat", $my_bindir, "sl.bat", settings) if CONFIG['host_os'] =~ /mswin/

      install_file_with_header($my_gem_path + "/bin/sl", $my_gem_path + "/bin/sl", settings)
    end

    protected

    def prepare
      $bindir = CONFIG["bindir"]

      $my_bindir = CONFIG['bindir']

      unless File.writable? $my_bindir
        $my_bindir = [ENV['HOME'], '.gem', 'ruby', CONFIG["MAJOR"]+"."+CONFIG["MINOR"], 'bin'].join(File::SEPARATOR)
      end

      $libdir = CONFIG["libdir"]
      
      my_gems_path = [CONFIG['libdir'], 'ruby', 'gems'].join(File::SEPARATOR)

     # unless File.writable? my_gems_path
     #   my_gems_path = [ENV['HOME'], '.gem', 'ruby'].join(File::SEPARATOR)
     # end

      $ruby = CONFIG['ruby_install_name']

      $spec = Gem::Specification.load(File.dirname(__FILE__) + "/../" + 'scriptlandia-r.gemspec')

      $my_gem_path = File.join(my_gems_path, CONFIG["MAJOR"]+"."+CONFIG["MINOR"], 
                               'gems', $spec.name + '-' + $spec.version.to_s)

      $my_libdir = File.join($my_gem_path, 'lib')
    end

    def tmp_file
      tmp_dir = nil
      for t in [".", "/tmp", "c:/temp", $my_bindir]
        stat = File.stat(t) rescue next
        if stat.directory? and stat.writable?
          tmp_dir = t
          break
        end
      end

      fail "Cannot find a temporary directory" unless tmp_dir

      File.join(tmp_dir, "_tmp")
    end

    def install_file from_file, to_dir, to_file, settings
      File.makedirs to_dir

      #File::install(from_file, File.join(to_dir, to_file), 0755, true)

      tmp = tmp_file()

      File.open(from_file) do |ip|
        File.open(tmp, "w") do |op|

          op.write ip.read.gsub('C:/Ruby/ruby-1.8.7/bin/sl', $bindir + '/sl')
        end
      end

      File::install(tmp, to_file, 0755, true)
      File::unlink(tmp)
    end

    def install_file_with_header(from_file, to_file, settings)
      tmp = tmp_file()

      File.open(from_file) do |ip|
        File.open(tmp, "w") do |op|
          ruby = File.join($bindir, $ruby)
          op.puts "#!#{ruby} -w"
          op.puts "name = '" + $spec.name + "'"
          op.puts "version = '" + $spec.version.to_s + "'"            
          op.puts "ENV['JAVA_HOME'] = '" + settings['java_home'].chomp + "'"

          op.write ip.read
        end
      end

      File::install(tmp, to_file, 0755, true)
      File::unlink(tmp)
    end

    def install_settings from_file, to_file
      require 'yaml'

      orig_settings_file_name = $my_libdir + "/settings.yaml"
      
      if(File.exist? orig_settings_file_name)
        settings = YAML::load File.open(orig_settings_file_name)
      else
        settings = YAML::load File.open(from_file)
      end

      orig_java_home = settings['java_home'].chomp

      if orig_java_home[0..1] == 'c:' && CONFIG['host_os'] =~ /darwin/i
        orig_java_home = '/Library/Java/Home'
      end

      orig_repository_home = settings['repositories']['local'].chomp

      if orig_repository_home[0..1] == 'c:' && CONFIG['host_os'] =~ /darwin/i
        orig_repository_home = '~/repository'
      end

      puts 'Enter Java Home (' + orig_java_home + "):"

      java_home = gets

      if(java_home.chomp.empty?)
        java_home = orig_java_home
      else
        java_home = java_home.chomp
      end

      puts 'Enter Repository Home (' + orig_repository_home + "):"

      repository_home = gets

      if(repository_home.chomp.empty?)
        repository_home = orig_repository_home
      else
        repository_home = repository_home.chomp
      end

      settings = YAML::load File.open(from_file)
      settings['java_home'] = java_home
      settings['repositories']['local'] = repository_home

      File.open( to_file, 'w' ) do |out|
        YAML.dump(settings, out)
      end
    end

  end

end