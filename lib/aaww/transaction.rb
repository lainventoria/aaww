module Aaww
  class Transaction
    include ActiveModel::Model

    attr_accessor :key, :token

    # Creates a single unique token for this transaction
    # Returns Token
    # GET /api3/api_create_partner_token?api_key={key}
    def create_token
      response = Aaww.get '/api3/api_create_partner_token', query: { api_key: key }
      self.token = response['data']['token']
    end
  end
end
