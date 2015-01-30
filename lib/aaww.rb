require 'httmultiparty'
require 'active_model'
require 'aaww/version'
require 'aaww/transaction'
require 'aaww/status'
require 'aaww/progress'

module Aaww
  include HTTMultiParty

  base_uri 'https://widget.sendshapes.com:3443'
end
