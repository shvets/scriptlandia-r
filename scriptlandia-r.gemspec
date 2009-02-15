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
  spec.version           = '0.5.0'
  spec.author            = "Alexander Shvets"
  spec.homepage          = 'http://rubyforge.org/projects/scriptlandia-r'
  spec.date              = %q{2008-11-02}
  spec.description       = 'Scriptlandia Launcher for Ruby.'
  spec.email             = 'alexander.shvets@gmail.com'

  spec.files = files("bin") + files("lib") + files("spec") + files("examples") +
               %w(CHANGES configure.rb Rakefile README scriptlandia-r.gemspec TODO)

  #p spec.files

  spec.require_paths = ["lib"]
  spec.requirements = ["none"]
  spec.bindir = "bin"
  spec.rubygems_version = '1.3.1'
  spec.platform = Gem::Platform::RUBY
  spec.has_rdoc = false
  spec.add_dependency("rjb", ">= 1.1.6")
#  spec.add_dependency("buildr", ">= 1.3.3")

  spec.executables = ['sl']

  spec.summary = %q{.}
end

