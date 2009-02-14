#

Gem::Specification.new do |spec|
  spec.name              = 'scriptlandia'
  spec.rubyforge_project = 'scriptlandia-r'
  spec.version           = '0.4.0'
  spec.author            = "Alexander Shvets"
  spec.homepage          = 'http://rubyforge.org/projects/scriptlandia-r'
  spec.date              = %q{2008-11-02}
  spec.description       = 'Scriptlandia Launcher for Ruby.'
  spec.email             = 'alexander.shvets@gmail.com'

  candidates = Dir.glob("{docs,lib,tests,bin}/**/*")
  spec.files = candidates.delete_if do |item|
    item.include?("svn") || item.include?("rdoc")
  end
  candidates << 'configure.rb'
  candidates << 'scriptlandia-r.gemspec'

  spec.require_paths = ["lib"]
  spec.requirements = ["none"]
  spec.bindir = "bin"
  spec.rubygems_version = '1.3.0'
  spec.platform = Gem::Platform::RUBY
  spec.has_rdoc = false
  spec.add_dependency("rjb", ">= 1.1.6")
#  spec.add_dependency("buildr", ">= 1.3.3")

  spec.executables = ['sl']

  spec.summary = %q{.}
end
