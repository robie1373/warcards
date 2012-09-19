require 'simplecov'
SimpleCov.start

require 'minitest/spec'
require "minitest/autorun"
require 'minitest/reporters'
#require 'minitest/growl_notify'
require 'turn'
require 'growl'
require 'terminal-notifier-guard'

MiniTest::Reporters.use!

require_relative '../lib/warcards'
