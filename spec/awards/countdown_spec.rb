require 'rspec'
require 'support/dummy_award'
require 'awards/countdown'

RSpec.describe Awards::Countdown do
  let(:klass) do
    Class.new(DummyAward).tap {|klass| klass.send :include, described_class }
  end
  let(:award){ klass.new expires_in: expires_in }

  describe '#countdown!' do
    let(:expires_in) { rand(-10..10) }
    it 'decrements the count of days' do
      expect { award.countdown! }.to change { award.expires_in }.by -1
    end
  end

  describe 'expired?' do
    subject { award.expired? }

    context '0 days left' do
      let(:expires_in) { 0 }
      it { should be_true }
    end

    context 'already expired' do
      let(:expires_in) { rand(-10..-1) }
      it { should be_true }
    end

    context 'not yet expired' do
      let(:expires_in) { rand(1..10) }
      it { should be_false }
    end
  end
end
