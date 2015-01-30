require 'minitest_helper'

describe Aaww::Status do
  describe 'without errors' do
    subject { Aaww::Status.new code: 'ok' }

    it 'is ok' do
      subject.must_be :ok?
    end

    it 'wont have errors' do
      subject.wont_be :error?
    end
  end

  describe 'with errors' do
    subject { Aaww::Status.new code: 'error' }

    it 'wont be ok' do
      subject.wont_be :ok?
    end

    it 'has errors' do
      subject.must_be :error?
    end
  end
end
