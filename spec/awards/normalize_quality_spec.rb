require 'rspec'
require 'support/dummy_award'
require 'awards/normalize_quality'

RSpec.describe Awards::NormalizeQuality do
  let(:klass) do
    Class.new(DummyAward).tap {|klass| klass.send :include, described_class }
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
