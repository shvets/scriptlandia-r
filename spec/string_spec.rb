#!/usr/bin/env ruby

require '../lib/scriptlandia'

describe String do

  it "should interpolate values" do
    s = '-Dfan.home=#{repositories.local}/fan/fan-sys/1.0.29'

    repositories_local = 'c:/maven-repository'

    s_i = s.interpolate({'repositories.local' => repositories_local})

    s_i.should eql('-Dfan.home=' + repositories_local + '/fan/fan-sys/1.0.29')
  end
end
