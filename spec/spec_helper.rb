require "codeclimate-test-reporter"

CodeClimate::TestReporter.configure do |config|
  config.path_prefix = "lib"
end

CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'diff_resource'
