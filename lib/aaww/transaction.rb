module Aaww
  class Transaction
    include ActiveModel::Model

    attr_accessor :key, :token, :file, :email, :value, :job_id, :link, :ssl_link

    # Creates a single unique token for this transaction
    # Returns Token
    # GET /api3/api_create_partner_token?api_key={key}
    def create_token
      response = Aaww.get '/api3/api_create_partner_token', query: { api_key: key }
      self.token = response['data']['token']
      response
    end

    # Uploads a 3D object associated with a specific token and purchase order information
    # Returns token_link and ssl_token_link
    # POST /api3/api_upload_partner_stl?api_key={key}&receiver_email={email}&print_value={value}&token=&partner_job_id={job_id}
    def upload(file, email, value, job_id = nil)
      self.file = file
      self.email = email
      self.value = value
      self.job_id = job_id unless job_id.nil?

      upload!
    end

    def upload!
      create_token if token.nil?

      response = Aaww.post '/api3/api_upload_partner_stl', query: upload_query
      self.link = response['data']['token_link']
      self.ssl_link = response['data']['ssl_token_link']
      response
    end

    def upload_query
      { api_key: key,
        receiver_email: email,
        print_value: value,
        token: token,
        partner_job_id: job_id,
        stl_file: file }.reject { |_, value| value.nil? }
    end
  end
end
