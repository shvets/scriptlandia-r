#!/usr/bin/env ruby

require 'test/unit'

require 'rubygems'
require 'rjb'
        
class TestRJB < Test::Unit::TestCase

  def test_call_rjb

    #ENV['JAVA_HOME'] = 'c:/Java/jdk1.5.0'
    ENV['JAVA_HOME'] = '/Library/Java/Home'
    #ENV['LD_LIBRARY_PATH'] = "#{ENV['LD_LIBRARY_PATH']}:#{ENV['JAVA_HOME]}/jre/lib/i386:#{ENV['JAVA_HOME']}/jre/lib/i386/client"

    Rjb::load(classpath = '.', jvmargs=[])

    str = Rjb::import('java.lang.String') 

    instance = str.new  "test"

    puts instance

    #assert_equal instance.to_s, 'test'
  end
end
