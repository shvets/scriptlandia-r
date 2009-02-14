#!/usr/bin/env ruby

require 'test/unit'

require '../lib/scriptlandia'

# http://www.rubular.com

class TestInterpolate < Test::Unit::TestCase

  def test_interpolate
    s = '-Dfan.home=#{repositories.local}/fan/fan-sys/1.0.29'

    repositories_local = 'c:/maven-repository'

    s_i = s.interpolate({'repositories.local' => repositories_local})

    puts s
    puts s_i
    assert_equal s_i, '-Dfan.home=' + repositories_local + '/fan/fan-sys/1.0.29'
  end
end
