$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'aaww'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'test/api_responses'
  c.hook_into :webmock
end

def sample_stl
  File.new File.join(File.dirname(__FILE__), 'fixtures/sample.stl')
end
