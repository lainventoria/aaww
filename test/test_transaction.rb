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
    end

    it 'saves the status' do
      subject.status.must_be_instance_of Aaww::Status
      subject.must_be :ok?
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
    end

    it 'saves the status' do
      subject.status.must_be_instance_of Aaww::Status
      subject.must_be :ok?
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

    it 'saves the ssl link' do
      subject.ssl_link.must_equal @response['data']['ssl_token_link']
    end
  end

  describe '#upload!' do
    describe 'with token' do
      subject do
        Aaww::Transaction.new key: 'fake_test_key', token: 'fake_test_token',
          file: sample_stl, email: 'email@example.com', value: 1, job_id: 69
      end

      before do
        VCR.use_cassette 'upload' do
          @response = subject.upload!
        end
      end

      it 'returns the response' do
        @response.must_be_instance_of Hash
        @response['status']['code'].must_equal 'ok'
      end

      it 'saves the status' do
        subject.status.must_be_instance_of Aaww::Status
        subject.must_be :ok?
      end

      it 'saves the link' do
        subject.link.must_equal @response['data']['token_link']
      end

      it 'saves the ssl link' do
        subject.ssl_link.must_equal @response['data']['ssl_token_link']
      end
    end

    describe 'without token' do
      subject do
        Aaww::Transaction.new key: 'fake_test_key',
          file: sample_stl, email: 'email@example.com', value: 1, job_id: 69
      end

      it 'generates a token' do
        subject.token.must_be_nil

        VCR.use_cassette 'create_token' do
          VCR.use_cassette 'upload' do
            subject.upload!
          end
        end

        subject.token.must_equal 'fake_test_token'
      end
    end
  end

  describe 'print_status' do
    subject do
      Aaww::Transaction.new key: 'fake_test_key',
        file: sample_stl, email: 'email@example.com', value: 1, job_id: 69
    end

    describe 'without print job' do
      before do
        VCR.use_cassette 'print_status_without_print' do
          subject.create_token
          @response = subject.print_status
        end
      end

      it 'fails' do
        @response.must_be_instance_of Hash
      end

      it 'saves the status' do
        subject.status.must_be_instance_of Aaww::Status
        subject.must_be :error?
      end

      it 'gives an error message' do
        subject.status.description.must_equal @response['status']['description']
        subject.status.extended_description.must_equal @response['status']['extended_description']
      end
    end

    describe 'with print job not started' do
      before do
        VCR.use_cassette 'print_status_with_print_not_started' do
          subject.upload!
          @response = subject.print_status
        end
      end

      it 'saves the status' do
        subject.status.must_be_instance_of Aaww::Status
        subject.must_be :error?
      end

      it 'gives an error message' do
        subject.status.description.must_equal @response['status']['description']
        subject.status.extended_description.must_equal @response['status']['extended_description']
      end
    end
  end
end
