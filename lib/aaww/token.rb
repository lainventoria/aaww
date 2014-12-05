require 'roar/client'

class Token < OpenStruct
  include Roar::JSON
  include TokenRepresenter
  include Roar::Client
end
