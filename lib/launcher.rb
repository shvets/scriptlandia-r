# scriptlandia.rb

require 'yaml'
require 'rubygems'
require 'rjb'

class String
  def interpolate vars
    s_i = self.dup

    vars.each do |key, value|
      regexp = Regexp.new('#\{' + key + '\}')

      s_i.gsub! regexp, value
    end

    s_i
  end

end

module Scriptlandia
  class Launcher
    def initialize
      @settings = YAML::load File.open(File.dirname(__FILE__) + '/settings.yaml')
      @ext_mapping = YAML::load File.open(File.dirname(__FILE__) + '/languages/extension_mapping.yaml')
    end

    def self.extension name
      name[name.rindex('.')+1, name.length]
    end

    def self.language_folder ext_mapping, name
      language_folder = nil

      ext = extension(name)

      ext_mapping.each do |folder, extensions|
        if extensions.include?(ext) or extensions.include?(name)
          language_folder = folder
          break
        end
      end

      language_folder
    end

    def launch
      script_name = ARGV[0]

      language = Launcher.language_folder(@ext_mapping, File.dirname(__FILE__) + "/" + script_name)
      
      if(language == nil) 
        puts "Unsupported language/extension: " + Launcher.extension(File.dirname(__FILE__) + "/" + script_name)
      else
        lang_config = YAML::load File.open(File.dirname(__FILE__) + '/languages/' + 
                             language + '/config.yaml')

        ENV['JAVA_HOME'] = @settings['java_home']
        local_repository = @settings['repositories']['local']

        vars = {'repositories.local' => local_repository }

        jvm_args = lang_config['jvmargs']
        jvm_args = [] if jvm_args == nil

        jvm_args = jvm_args.collect { |arg| arg.interpolate(vars) }

        classpath = lang_config['classpath']
        classpath = [] if classpath == nil

        lang_config['artifacts'].each do |name, artifact|
          group, id, type,version = artifact.split(':')
          
          file_name = local_repository + '/' + 
                      group.gsub('.', '/') + '/' + 
                      id.gsub('.', '/') + '/' + 
                      version + '/' + 
                      id.gsub('.', '/') + '-' + version + '.' + type

          unless File.exist? file_name
            puts 'File ' + file_name + ' does not exists.'
          else
            classpath << file_name
          end
        end

        pause = false

        if(ARGV.include? '--wait')
          ARGV.delete '--wait'
          pause = true
        end

        Rjb::load(classpath.join(File::PATH_SEPARATOR), jvmargs = jvm_args)       

        ARGV[0, 0] = lang_config['command_line'] if lang_config['command_line']

        Rjb::import(lang_config['start_class']).main(ARGV)
        
        STDIN.gets if pause
      end
    end
  end
end
