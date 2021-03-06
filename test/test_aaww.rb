require 'minitest_helper'

describe Aaww do
  subject { Aaww }

  it 'has a version number' do
    subject::VERSION.wont_be_nil
  end

  describe '#base_uri' do
    before { @original = subject.base_uri }
    after { subject.base_uri @original }

    it 'has a base uri' do
      subject.base_uri.wont_be_nil
    end

    it "can change it's base uri" do
      subject.base_uri 'https://somewhere.safe'

      subject.base_uri.must_equal 'https://somewhere.safe'
    end
  end
end
