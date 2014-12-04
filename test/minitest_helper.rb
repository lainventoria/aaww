$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'aaww'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/api_responses'
  c.hook_into :webmock
end
