require 'rspec'
require 'support/dummy_award'
require 'shared_contexts/award_contexts'
require 'shared_examples/award_examples'
require 'awards/blue_compare'

RSpec.describe Awards::BlueCompare do
  let(:klass) do
    Class.new(DummyAward).tap {|klass| klass.send :include, described_class }
  end

  let(:initial_expires_in) { rand(2..5) }
  let(:initial_quality) { rand(1..45) }
  let(:award) { klass.new expires_in: initial_expires_in, quality: initial_quality }

  describe '#update_quality!' do
    let(:update!) { -> { award.update_quality! } }

    context 'more than 10 days left' do
      let(:initial_expires_in) { rand(11..50) }

      include_examples 'decrement count of days'
      include_examples 'quality does not go over 50'

      it 'increments the quality by 1' do
        expect(update!).to change { award.quality }.by 1
      end
    end

    context '6-10 days left' do
      let(:initial_expires_in) { rand(6..10) }

      include_examples 'decrement count of days'
      include_examples 'quality does not go over 50'

      it 'increments the quality by 2' do
        expect(update!).to change { award.quality }.by 2
      end
    end

    context '1-5 days left' do
      let(:initial_expires_in) { rand(1..5) }

      include_examples 'decrement count of days'
      include_examples 'quality does not go over 50'

      it 'increments the quality by 3' do
        expect(update!).to change { award.quality }.by 3
      end
    end

    context 'expired' do
      include_context 'expired'

      include_examples 'decrement count of days'

      it 'sets the quality to 0' do
        update!.call
        expect(award.quality).to be_zero
      end
    end
  end
end
