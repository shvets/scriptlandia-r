# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name     = 'scriptlandia'
  spec.version  = '0.7.1'

  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  spec.authors  = ["Alexander Shvets"]
  spec.date     = %q{2009-03-29}
  spec.description  = 'Scriptlandia Launcher in Ruby.'
  spec.email    = 'alexander.shvets@gmail.com'

  spec.files = %w(CHANGES Rakefile README scriptlandia-r.gemspec TODO examples.zip) +
               %w(bin/sl bin/sl.bat) +
               %w(lib/buildfile lib/configurer.rb
                  lib/language_installer.rb lib/launcher.rb
                  lib/settings.yaml
                  lib/languages/ant/config.yaml
                  lib/languages/beanshell/config.yaml
                  lib/languages/clojure/config.yaml
                  lib/languages/fan/config.yaml
                  lib/languages/fortress/config.yaml
                  lib/languages/groovy/config.yaml
                  lib/languages/jaskell/config.yaml
                  lib/languages/javascript/config.yaml
                  lib/languages/jawk/config.yaml
                  lib/languages/jruby/config.yaml
                  lib/languages/judo/config.yaml
                  lib/languages/jython/config.yaml
                  lib/languages/lolcode/config.yaml
                  lib/languages/pnuts/config.yaml
                  lib/languages/ptilde/config.yaml
                  lib/languages/scala/config.yaml
                  lib/languages/sleep/config.yaml
                  lib/languages/tcl/config.yaml
                  lib/languages/yoix/config.yaml
                  lib/languages/extension_mapping.yaml) +
                %w(spec/rjb_spec.rb spec/string_spec.rb)
  spec.has_rdoc = false
  spec.homepage = 'http://github.com/shvets/scriptlandia-r'
  spec.require_paths = ["lib"]
  spec.rubyforge_project = 'scriptlandia-r'
  spec.rubygems_version = '1.3.1'
  spec.summary = %q{Scriptlandia Launcher in Ruby.}

  if spec.respond_to? :specification_version then
    spec.specification_version = 2
  end

  spec.executables = ['sl']
  spec.platform = Gem::Platform::RUBY
  spec.requirements = ["none"]
  spec.bindir = "bin"

  spec.add_dependency("rjb", ">= 1.1.6")
  spec.add_dependency("buildr", ">= 1.3.3")
end
