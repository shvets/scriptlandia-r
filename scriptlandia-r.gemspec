# scriptlandia-r.gemspec

Gem::Specification.new do |spec|
  spec.name              = 'scriptlandia'
  spec.rubyforge_project = 'scriptlandia-r'
  spec.version           = '0.5.4'
  spec.author            = "Alexander Shvets"
  spec.homepage          = 'http://github.com/shvets/scriptlandia-r'
  spec.date              = %q{2009-02-14}
  spec.description       = 'Scriptlandia Launcher for Ruby.'
  spec.email             = 'alexander.shvets@gmail.com'

  spec.files = %w(CHANGES Rakefile README scriptlandia-r.gemspec TODO examples.zip) +
               %w(bin/sl bin/sl.bat) +
               %w(lib/buildfile lib/configurer.rb lib/language_installer.rb lib/launcher.rb lib/settings.yaml
                  lib/languages/ant/config.yaml lib/languages/beanshell/config.yaml lib/languages/clojure/config.yaml
                  lib/languages/fan/config.yaml lib/languages/fortress/config.yaml lib/languages/groovy/config.yaml
                  lib/languages/jaskell/config.yaml lib/languages/javascript/config.yaml lib/languages/jawk/config.yaml
                  lib/languages/jruby/config.yaml lib/languages/judo/config.yaml lib/languages/jython/config.yaml
                  lib/languages/lolcode/config.yaml lib/languages/pnuts/config.yaml lib/languages/ptilde/config.yaml
                  lib/languages/scala/config.yaml lib/languages/sleep/config.yaml lib/languages/tcl/config.yaml
                  lib/languages/yoix/config.yaml lib/languages/extension_mapping.yaml) +
                %w(spec/rjb_spec.rb spec/string_spec.rb)
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
