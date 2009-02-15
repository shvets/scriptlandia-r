#

require 'rubygems'
require 'rjb'


describe Rjb do

  it "should load java String class" do
    if RUBY_PLATFORM =~ /mswin32/
      ENV['JAVA_HOME'] = 'c:/Java/jdk1.5.0'
    else
      ENV['JAVA_HOME'] = '/Library/Java/Home'
    end

    #ENV['LD_LIBRARY_PATH'] = "#{ENV['LD_LIBRARY_PATH']}:#{ENV['JAVA_HOME]}/jre/lib/i386:#{ENV['JAVA_HOME']}/jre/lib/i386/client"

    Rjb::load(classpath = '.', jvmargs=[])

    str = Rjb::import('java.lang.String') 

    instance = str.new "test"

    instance.should_not be_nil
    #assert_equal instance.to_s, 'test'
  end

end