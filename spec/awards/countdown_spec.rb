require 'rspec'
require 'support/dummy_award'
require 'awards/countdown'

RSpec.describe Awards::Countdown do
  let(:klass) do
    Class.new(DummyAward).tap {|klass| klass.send :include, described_class }
  end

  describe '#countdown!' do
    it 'decrements the count of days' do
      award = klass.new expires_in: rand(-10..10)
      expect { award.countdown! }.to change { award.expires_in }.by -1
    end
  end
end
