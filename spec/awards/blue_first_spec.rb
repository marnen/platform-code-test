require 'rspec'
require 'shared_contexts/award_contexts'
require 'shared_examples/award_examples'
require 'awards/blue_first'

RSpec.describe Awards::BlueFirst do
  include_context 'award class'

  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(1..45) }
  let(:award) { klass.new expires_in: initial_expires_in, quality: initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    context 'unexpired' do
      include_examples 'decrement count of days'
      include_examples 'quality does not go over 50'

      it 'increments the quality by 1' do
        expect(update!).to change { award.quality }.by 1
      end
    end

    context 'expired' do
      include_context 'expired'

      include_examples 'decrement count of days'
      include_examples 'quality does not go over 50'

      it 'increments the quality by 2' do
        expect(update!).to change { award.quality }.by 2
      end
    end
  end
end
