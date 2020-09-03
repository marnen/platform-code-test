require 'rspec'
require 'support/dummy_award'
require 'awards/basic_behavior'

RSpec.describe Awards::BasicBehavior do
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

  describe '#expired?' do
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

    describe '#normalize_quality!' do
      let(:award) { klass.new quality: quality }

      context 'quality is above 50' do
        let(:quality) { 50 + rand(1..10) }

        it 'sets quality to 50' do
          award.normalize_quality!
          expect(award.quality).to be == 50
        end
      end

      context 'quality is below 0' do
        let(:quality) { rand(-10..-1) }

        it 'sets quality to 0' do
          award.normalize_quality!
          expect(award.quality).to be_zero
        end
      end

      context 'quality is between 0 and 50' do
        let(:quality) { rand(0..50) }

        it 'does not change the quality' do
          expect { award.normalize_quality! }.not_to change { award.quality }
        end
      end
    end
end
