$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'diff_resource'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
