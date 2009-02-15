# scriptlandia-r.gemspec

class Gem::Specification
  def self.files dir
    list = []
    Dir.new(dir).each do |f|
      if(f != '.' and f != '..')
        name = dir + '/' + f
        if File.directory? name 
          list += files(name)
        else
          list << name
        end
      end 
    end

    list
  end
end

Gem::Specification.new do |spec|
  spec.name              = 'scriptlandia'
  spec.rubyforge_project = 'scriptlandia-r'
  spec.version           = '0.5.1'
  spec.author            = "Alexander Shvets"
  spec.homepage          = 'http://github.com/shvets/scriptlandia-r'
  spec.date              = %q{2009-02-14}
  spec.description       = 'Scriptlandia Launcher for Ruby.'
  spec.email             = 'alexander.shvets@gmail.com'

  spec.files = %w(CHANGES configure.rb Rakefile README scriptlandia-r.gemspec TODO) +
               files("bin") + 
               files("lib") + 
               files("spec") + 
               files("examples")
               
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

