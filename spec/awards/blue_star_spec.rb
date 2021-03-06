require 'rspec'
require 'shared_contexts/award_contexts'
require 'shared_examples/award_examples'
require 'awards/blue_star'

RSpec.describe Awards::BlueStar do
  include_context 'award class'

  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(4..45) }
  let(:award) { klass.new expires_in: initial_expires_in, quality: initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    context 'unexpired' do
      include_examples 'decrement count of days'
      include_examples 'quality is never negative'

      it 'decrements the quality by 2' do
        expect(update!).to change { award.quality }.by -2
      end
    end

    context 'expired' do
      include_context 'expired'

      include_examples 'decrement count of days'
      include_examples 'quality is never negative'

      it 'decrements the quality by 4' do
        expect(update!).to change { award.quality }.by -4
      end
    end
  end
end
