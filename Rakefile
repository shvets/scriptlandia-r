# Rakefile for Scriptlandia-R

require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'
require 'spec/rake/spectask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

def create_zip_file dir
  require 'zip/zip'

  Zip::ZipOutputStream.open(dir + ".zip") do |zos|
    zip zos, dir
  end

end

def zip zos, dir
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

create_zip_file 'examples'


spec_name = 'scriptlandia-r.gemspec'

SPEC = Gem::Specification.load(spec_name)

Rake::GemPackageTask.new(SPEC) do |pkg| 
#  pkg.need_tar = true 
#  pkg.need_zip = true
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
  SPEC.validate
   
  puts SPEC
  puts "OK"
end

task :default => :rcov
