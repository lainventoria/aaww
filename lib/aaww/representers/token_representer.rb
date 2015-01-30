class TokenRepresenter < Roar::Decorator
  include Roar::JSON

  property :status
  property :token
end
