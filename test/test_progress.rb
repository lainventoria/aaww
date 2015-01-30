require 'minitest_helper'

describe Aaww::Progress do
  describe 'without progress' do
    subject { Aaww::Progress.new }

    it 'doesnt show progress' do
      subject.wont_be :any?
    end
  end

  describe 'with progress' do
    subject { Aaww::Progress.new printing_percentage: '20' }

    it 'show progress' do
      subject.must_be :any?
    end
  end
end
