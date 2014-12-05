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

    it 'returns the response' do
      @response.must_be_instance_of Hash
      @response['status']['code'].must_equal 'ok'
    end

    it 'saves the token for future use' do
      subject.token.must_equal @response['data']['token']
    end
  end

  describe '#upload' do
    before do
      VCR.use_cassette 'upload' do
        subject.token = 'fake_test_token'
        @response = subject.upload sample_stl, 'email@example.com', 1, 69
      end
    end

    it 'returns the response' do
      @response.must_be_instance_of Hash
      @response['status']['code'].must_equal 'ok'
    end

    it 'saves the file' do
      subject.file.path.must_equal sample_stl.path
    end

    it 'saves the email' do
      subject.email.must_equal 'email@example.com'
    end

    it 'saves the value' do
      subject.value.must_equal 1
    end

    it 'saves the id if sent' do
      subject.job_id.must_equal 69
    end

    it 'saves the link' do
      subject.link.must_equal @response['data']['token_link']
    end
  end

  describe '#upload' do
    before do
      VCR.use_cassette 'upload' do
        subject.token = 'fake_test_token'
        @response = subject.upload sample_stl, 'email@example.com', 1, 69
      end
    end

    it 'returns a token link' do
      @response.must_equal 'http://tokens.sendshapes.com/?token=fake_test_token'
    end

    it 'saves the file' do
      subject.file.path.must_equal sample_stl.path
    end

    it 'saves the email' do
      subject.email.must_equal 'email@example.com'
    end

    it 'saves the value' do
      subject.value.must_equal 1
    end

    it 'saves the id if sent' do
      subject.job_id.must_equal 69
    end
  end
end
