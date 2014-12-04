require 'httparty'
require 'active_model'
require 'aaww/version'
require 'aaww/transaction'

module Aaww
  include HTTParty

  base_uri 'https://widget.sendshapes.com:3443'
end
