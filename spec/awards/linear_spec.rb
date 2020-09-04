require 'rspec'
require 'shared_contexts/award_contexts'
require 'shared_examples/award_examples'
require 'awards/linear'

RSpec.describe Awards::Linear do
  include_context 'award class' do
    let(:mod) { described_class.new daily_change: daily_change, expired_multiplier: expired_multiplier }
  end

  let(:daily_change) { rand(-3..3) }
  let(:expired_multiplier) { rand(2..4) }
  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(10..30) }
  let(:award) { klass.new expires_in: initial_expires_in, quality: initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

     shared_examples 'invariants' do
      include_examples 'decrement count of days'
      include_examples 'quality does not go over 50'
      include_examples 'quality is never negative'
    end

    context 'unexpired' do
      include_examples 'invariants'

      it 'changes quality by the daily change amount' do
        expect(update!).to change { award.quality }.by daily_change
      end
    end

    context 'expired' do
      include_context 'expired'
      include_examples 'invariants'

      it 'changes quality by the daily change amount multiplied by the expired multiplier' do
        expect(update!).to change { award.quality }.by daily_change * expired_multiplier
      end

      context 'multiplier not given' do
        let(:mod) { described_class.new daily_change: daily_change }

        it 'defaults to 2' do
          expect(update!).to change { award.quality }.by daily_change * 2
        end
      end
    end
  end
end
