# Rakefile for Scriptlandia-R

require 'rubygems'
require 'rake/gempackagetask'

SPEC = Gem::Specification.load('scriptlandia-r.gemspec')

Rake::GemPackageTask.new(SPEC) do |pkg| 
  pkg.need_tar = true 
  pkg.need_zip = true
end 

file "sl.gemspec.yaml" do |t|
  require 'yaml'
  open(t.name, "w") { |f| f.puts SPEC.to_yaml }
end

# Install application using the standard install.rb script.

desc "Install the application"
task :install do
  ruby Rake.original_dir + "/install.rb"
end

# Support Tasks ------------------------------------------------------

RUBY_FILES = FileList['**/*.rb'].exclude('pkg')

desc "Look for TODO and FIXME tags in the code"
task :todo do
  RUBY_FILES.egrep(/#.*(FIXME|TODO|TBD)/)
end

desc "Look for Debugging print lines"
task :dbg do
  RUBY_FILES.egrep(/\bDBG|\bbreakpoint\b/)
end

desc "List all ruby files"
task :rubyfiles do 
  puts RUBY_FILES
  puts FileList['bin/*'].exclude('bin/*.rb')
end
task :rf => :rubyfiles

task :test2 do |t|
  require 'test/unit/testsuite'
  require 'test/unit/ui/console/testrunner'

  runner = Test::Unit::UI::Console::TestRunner

  $LOAD_PATH.unshift('tests')
  Dir['test/*.rb'].each do |testcase|
    load testcase
  end

  suite = Test::Unit::TestSuite.new

  ObjectSpace.each_object(Class) do |testcase|
    suite << testcase.suite if testcase < Test::Unit::TestCase
  end

  runner.run(suite)
end

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  require 'rubyforge'

  packages = %w( gem tgz zip ).collect{ |ext| "pkg/#{PKG_NAME}-#{PKG_VERSION}.#{ext}" }

  rubyforge = RubyForge.new
  rubyforge.login
  rubyforge.add_release(PKG_NAME, PKG_NAME, "REL #{PKG_VERSION}", *packages)
end
