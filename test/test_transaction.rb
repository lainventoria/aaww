require 'minitest_helper'

describe Aaww::Transaction do
  subject { Aaww::Transaction.new(key: 'fake_test_key') }

  it 'can access the key' do
    subject.key.must_equal 'fake_test_key'
  end

  describe '#create_token' do
    before do
      VCR.use_cassette 'create_token' do
        @response = subject.create_token
      end
    end

    it 'creates a token and returns it' do
      @response.must_equal 'fake_test_token'
    end

    it 'saves the token for future use' do
      subject.token.must_equal @response
    end
  end
end
