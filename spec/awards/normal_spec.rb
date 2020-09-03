require 'rspec'
require 'support/dummy_award'
require 'shared_examples/award_examples'
require 'awards/normal'

RSpec.describe Awards::Normal do
  let(:klass) do
    Class.new(DummyAward).tap {|klass| klass.send :include, described_class }
  end

  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(2..45) }
  let(:award) { klass.new expires_in: initial_expires_in, quality: initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    context 'unexpired' do
      include_examples 'decrement count of days'
      include_examples 'quality is never negative'

      it 'decrements the quality by 1' do
        expect(update!).to change { award.quality }.by -1
      end
    end

    context 'expired' do
      include_context 'expired'

      include_examples 'decrement count of days'
      include_examples 'quality is never negative'

      it 'decrements the quality by 2' do
        expect(update!).to change { award.quality }.by -2
      end
    end
  end
end
