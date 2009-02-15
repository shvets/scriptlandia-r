# Rakefile for Scriptlandia-R

require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'
require 'spec/rake/spectask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

spec_name = 'scriptlandia-r.gemspec'

SPEC = Gem::Specification.load(spec_name)

Rake::GemPackageTask.new(SPEC) do |pkg| 
  pkg.need_tar = true 
  pkg.need_zip = true
end 

Spec::Rake::SpecTask.new do |task|
  task.libs << 'lib'
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'teststuff'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |task|
  task.libs << 'test'
  task.test_files = FileList['test/**/*_test.rb']
  task.verbose = true
end

desc "test gem compatibility with github"
task :"github:validate" do
  require 'yaml'
   
#p FileList['{docs,lib,tests,bin}/**/*']

  require 'rubygems/specification'
  data = File.read(spec_name)
  spec = nil
   
  if data !~ %r{!ruby/object:Gem::Specification}
    Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
  else
    spec = YAML.load(data)
  end
   
  spec.validate
   
  puts spec
  puts "OK"
end

task :default => :rcov







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

