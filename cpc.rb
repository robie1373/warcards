#!/usr/bin/env ruby
$: << File.dirname(__FILE__)

if e = ARGV.shift
  ENV['RACK_ENV'] = e
end

require 'lib/warcards.rb' # change this line to require your application
require 'irb'

puts "CooperPress Console"

IRB.start
