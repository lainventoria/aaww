require 'minitest_helper'

describe Aaww::Transaction do
  before { Aaww.base_uri 'https://private-anon-ec6132c37-authentise.apiary-mock.com' }
  subject { Aaww::Transaction.new(key: 'abc') }

  it 'can access the key' do
    subject.key.must_equal 'abc'
  end

  describe '#create_token' do
    before do
      VCR.use_cassette 'create_token' do
        @response = subject.create_token
      end
    end

    it 'creates a token and returns it' do
      @response.must_equal '56497a3e9ffcbbe9b174b38a31sample'
    end

    it 'saves the token for future use' do
      subject.token.must_equal @response
    end
  end
end
