# scriptlandia-r.gemspec

class Gem::Specification
  def self.files name
    list = []

    if File.directory? name 
      Dir.new(name).each do |filename|
        if(filename != '.' and filename != '..')
          list += files(name + '/' + filename)
        end
      end
    else
      list << name
    end

    list
  end

  def self.create_zip_file dir
    require 'zip/zip'

    Zip::ZipOutputStream.open(dir + ".zip") do |zos|
      zip zos, dir
    end

  end

  def self.zip zos, dir
    Dir.new(dir).each do |filename|
      if(filename != '.' and filename != '..')
        full_name = dir + '/' + filename

        if File.directory? full_name
          zip(zos, full_name)
        else
          # Create a new entry with some arbitrary name
          zos.put_next_entry(dir + '/' + filename)
          # Add the contents of the file, don't read the stuff linewise if its binary, instead use direct IO
          zos.print IO.read(dir + '/' + filename)
        end
      end
    end
  end

end

Gem::Specification.new do |spec|
  create_zip_file 'examples'

  spec.name              = 'scriptlandia'
  spec.rubyforge_project = 'scriptlandia-r'
  spec.version           = '0.5.1'
  spec.author            = "Alexander Shvets"
  spec.homepage          = 'http://github.com/shvets/scriptlandia-r'
  spec.date              = %q{2009-02-14}
  spec.description       = 'Scriptlandia Launcher for Ruby.'
  spec.email             = 'alexander.shvets@gmail.com'

  spec.files = %w(CHANGES Rakefile README scriptlandia-r.gemspec TODO examples.zip) +
               files("bin") + 
               files("lib") + 
               files("spec")
               
  spec.require_paths = ["lib"]
  spec.requirements = ["none"]
  spec.bindir = "bin"
  spec.rubygems_version = '1.3.1'
  spec.platform = Gem::Platform::RUBY
  spec.has_rdoc = false
  spec.add_dependency("rjb", ">= 1.1.6")
  spec.add_dependency("buildr", ">= 1.3.3")

  spec.executables = ['sl']

  spec.summary = %q{.}
end
