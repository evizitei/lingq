require 'rubygems'
require "bundler"
Bundler.setup(:default,:test)
require 'test/unit'
require 'shoulda'
require 'webmock/test_unit'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lingq'

class Test::Unit::TestCase
  include WebMock
end
